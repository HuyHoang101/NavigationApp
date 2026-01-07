//
//  UserViewController.swift
//  NavigationApp
//
//  Created by hoang.nguyenh on 1/5/26.
//

import UIKit

class UserViewController: UIViewController {
    
    let loginText = UITextView()
    let image = UIImageView()
    let name = UILabel()
    let sexAge = UILabel()
    let email = UILabel()
    let phone = UILabel()
    let address = UILabel()
    let vstack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshUI), name: NSNotification.Name("UserDidLogin"), object: nil)
    }
    
    private func setUpUI() {
        view.backgroundColor = .systemBackground
        
        //Login text
        loginText.isEditable = false
        loginText.isScrollEnabled = false
        loginText.isSelectable = true
        loginText.backgroundColor = .clear
        loginText.delegate = self
        loginText.translatesAutoresizingMaskIntoConstraints = false
        
        
        // VSTACK
        vstack.axis = .vertical
        vstack.alignment = .center
        vstack.distribution = .fill
        vstack.spacing = 10
        vstack.translatesAutoresizingMaskIntoConstraints = false
        
        
        // IMAGE
        image.contentMode = .scaleToFill
        image.layer.borderWidth = 2
        image.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        image.layer.cornerRadius = 60
        image.translatesAutoresizingMaskIntoConstraints = false
        
        // NAME
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        name.textAlignment = .center
        
        // SEX & AGE
        sexAge.textColor = .systemGray
        sexAge.font = UIFont.systemFont(ofSize: 18)
        sexAge.textAlignment = .center
        
        // EMAIL
        email.textColor = .systemGray
        email.font = UIFont.systemFont(ofSize: 18)
        email.textAlignment = .center
        
        // PHONE
        phone.textColor = .systemGray
        phone.font = UIFont.systemFont(ofSize: 18)
        phone.textAlignment = .center
        
        // ADDRESS
        address.textColor = .systemGray
        address.font = UIFont.systemFont(ofSize: 18)
        address.textAlignment = .center
        
        view.addSubview(loginText)
        view.addSubview(vstack)
        vstack.addArrangedSubview(image)
        vstack.addArrangedSubview(name)
        vstack.addArrangedSubview(sexAge)
        vstack.addArrangedSubview(email)
        vstack.addArrangedSubview(phone)
        vstack.addArrangedSubview(address)
        
        NSLayoutConstraint.activate([
            loginText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            loginText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            
            vstack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            vstack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            image.widthAnchor.constraint(equalToConstant: 120),
            image.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUIState()
    }
    
    private func updateUIState() {
        let session = UserSession.shared
        if session.isLoggedIn, let user = session.currentUser {
            // --- TRẠNG THÁI ĐÃ LOGIN ---
            loginText.isHidden = true
            vstack.isHidden = false
            
            image.image = UIImage(systemName: user.userName)
            name.text = "\(user.name)"
            sexAge.text = "Sex: \(user.sex)  *  Age: \(user.age)"
            email.setTextWithSystemIcon(iconName: "mail", text: "\(user.email)")
            phone.setTextWithSystemIcon(iconName: "phone", text: "\(user.phone)")
            address.setTextWithSystemIcon(iconName: "mappin.circle", text: "\(user.address)")
            
            // Hiện thanh bar để dùng nút Logout
            navigationController?.setNavigationBarHidden(false, animated: true)
            
            let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
            logoutButton.tintColor = .systemRed
            navigationItem.rightBarButtonItem = logoutButton
        } else {
            
            // --- TRẠNG THÁI CHƯA LOGIN ---
            loginText.isHidden = false
            vstack.isHidden = true
            setupLoginAttributedText()
            
            // Ẩn thanh bar cho đẹp đúng ý cậu ban đầu
            navigationController?.setNavigationBarHidden(true, animated: true)
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    
    private func setupLoginAttributedText() {
        let text = "Login to reach all feature of Bookmark app!"
        let attributed = NSMutableAttributedString(string: text)
        let loginRange = (text as NSString).range(of: "Login")
        
        attributed.addAttributes([
            .foregroundColor: UIColor.systemBlue,
            .font: UIFont.systemFont(ofSize: 20, weight: .regular),
            .link: URL(string: "login://action")!
        ], range: loginRange)
        
        loginText.attributedText = attributed
        loginText.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        loginText.textAlignment = .left
    }
    
    @objc func handleLogout() {
        UserSession.shared.isLoggedIn = false
        UserSession.shared.currentUser = nil
        updateUIState() // Vẽ lại giao diện ngay lập tức
    }
    
    @objc func openLogin() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .overFullScreen
        loginVC.modalTransitionStyle = .crossDissolve
        present(loginVC, animated: true, completion: nil)
    }
    
    @objc func refreshUI() {
        updateUIState()
    }
}

extension UserViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.scheme == "login" {
            openLogin()
            return false
        }
        return true
    }
}

extension UILabel {

    func setTextWithSystemIcon(
        iconName: String,
        text: String,
        iconSize: CGFloat? = nil,
        iconOffsetY: CGFloat = -2,
        spacing: String = " "
    ) {
        let fontSize = iconSize ?? font.pointSize

        let config = UIImage.SymbolConfiguration(pointSize: fontSize, weight: .regular)
        let image = UIImage(
            systemName: iconName,
            withConfiguration: config
        )?.withRenderingMode(.alwaysTemplate)

        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(
            x: 0,
            y: iconOffsetY,
            width: fontSize,
            height: fontSize
        )

        let attributed = NSMutableAttributedString(
            attachment: attachment
        )
        
        attributed.append(NSAttributedString(string: spacing + text))
        self.attributedText = attributed
        self.tintColor = textColor
    }
}

