import UIKit

class HomeViewController: UIViewController {
    
    let welcomeLabel = UILabel()
    let loginText = UITextView()
    let subLabel = UILabel()
    let vstack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshUI), name: NSNotification.Name("UserDidLogin"), object: nil)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Cấu hình Welcome Label
        welcomeLabel.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        welcomeLabel.numberOfLines = 0
        
        // Cấu hình Sub Label (Dòng chữ thứ 2)
        subLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        subLabel.textColor = .secondaryLabel
        
        // Cấu hình Login Text (Có chứa link)
        loginText.isEditable = false
        loginText.isScrollEnabled = false
        loginText.isSelectable = true
        loginText.backgroundColor = .clear
        loginText.delegate = self
        
        // StackView
        vstack.axis = .vertical
        vstack.alignment = .leading
        vstack.spacing = 10
        vstack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(vstack)
        vstack.addArrangedSubview(welcomeLabel)
        vstack.addArrangedSubview(subLabel)
        vstack.addArrangedSubview(loginText)
        
        NSLayoutConstraint.activate([
            vstack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            vstack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            vstack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
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
            welcomeLabel.text = "Welcome,\n\(user.name)!"
            welcomeLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
            subLabel.text = "Ready to discover your next favorite book?"
            subLabel.isHidden = false
            loginText.isHidden = true
            
            // Hiện thanh bar để dùng nút Logout
            navigationController?.setNavigationBarHidden(false, animated: true)
            title = "Home"
            
            let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
            logoutButton.tintColor = .systemRed
            navigationItem.rightBarButtonItem = logoutButton
        } else {
            // --- TRẠNG THÁI CHƯA LOGIN ---
            welcomeLabel.text = "Hi, there!"
            subLabel.isHidden = true
            loginText.isHidden = false
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


extension HomeViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.scheme == "login" {
            openLogin()
            return false
        }
        return true
    }
}
