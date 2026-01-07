import UIKit

class LoginViewController: UIViewController {

    // MARK: - UI Components
    private let dimView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        v.alpha = 0
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let loginUI: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowOpacity = 0.25
        view.layer.shadowRadius = 12
        view.layer.shadowOffset = CGSize(width: 0, height: 6)
        return view
    }()

    // Hàm tạo TextField dùng chung để tránh lặp code
    private func createTextField(placeholder: String, isSecure: Bool = false) -> UITextField {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.gray])
        tf.backgroundColor = .systemIndigo.withAlphaComponent(0.1)
        tf.layer.cornerRadius = 8
        tf.isSecureTextEntry = isSecure
        tf.autocapitalizationType = .none
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        tf.leftViewMode = .always
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return tf
    }

    private lazy var userInput = createTextField(placeholder: "Enter username...")
    private lazy var passwordInput = createTextField(placeholder: "Enter password...", isSecure: true)

    private let loginButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Login"
        config.baseBackgroundColor = .systemIndigo
        let btn = UIButton(configuration: config)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupActions()
    }

    private func setupLayout() {
        view.addSubview(dimView)
        view.addSubview(loginUI)
        
        // Dùng StackView để quản lý các item bên trong cho gọn
        let stack = UIStackView(arrangedSubviews: [userInput, passwordInput, loginButton])
        stack.axis = .vertical
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        loginUI.addSubview(stack)

        NSLayoutConstraint.activate([
            dimView.topAnchor.constraint(equalTo: view.topAnchor),
            dimView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            loginUI.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginUI.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginUI.widthAnchor.constraint(equalToConstant: 300),

            stack.topAnchor.constraint(equalTo: loginUI.topAnchor, constant: 40),
            stack.leadingAnchor.constraint(equalTo: loginUI.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: loginUI.trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: loginUI.bottomAnchor, constant: -30)
        ])
        
        // Hiệu ứng Fade In cho dimView
        UIView.animate(withDuration: 0.3) { self.dimView.alpha = 1 }
    }

    private func setupActions() {
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSelf))
        dimView.addGestureRecognizer(tap)
    }

    @objc private func dismissSelf() {
        UIView.animate(withDuration: 0.2, animations: {
            self.dimView.alpha = 0
            self.loginUI.alpha = 0
        }) { _ in
            self.dismiss(animated: false)
        }
    }

    @objc func handleLogin() {
        // ... Giữ nguyên logic login của cậu ...
        guard let name = userInput.text, !name.isEmpty, passwordInput.text == "123456" else { return }
        
        if let foundUser = UserSession.shared.allUsers.first(where: { $0.userName == name }) {
            UserSession.shared.isLoggedIn = true
            UserSession.shared.currentUser = foundUser
            NotificationCenter.default.post(name: NSNotification.Name("UserDidLogin"), object: nil)
            dismissSelf()
        }
    }
}
