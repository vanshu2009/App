import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var UserLogged: UserSection?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        
        emailTextField.text = "diana@example.com"
        passwordTextField.text = "123456"
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @objc func textFieldsDidChange() {
       
        if let email = emailTextField.text, let password = passwordTextField.text,
           isValidEmail(email), isValidPassword(password) {
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor.systemBlue
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor(red: 0.0/255.0, green: 170.0/255.0, blue: 185.0/255.0, alpha: 1.0)
            loginButton.titleLabel?.textColor = .white
            loginButton.layer.cornerRadius = 12

 
        }
    }

    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

   
    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 8
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let currentText = textField.text, let textRange = Range(range, in: currentText) {
            let updatedText = currentText.replacingCharacters(in: textRange, with: string)
            if textField == emailTextField {
                return !updatedText.contains(" ")
            }
            if textField == passwordTextField {
                return !updatedText.contains(" ")
            }
        }
        return true
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
                      !email.isEmpty,
                      !password.isEmpty else {
                    print("Please enter both email and password")
                    return
                }
                
                if let loggedUser = DataModel.shared.validateUser(email: email, password: password) {
                    // Store logged-in user (if needed)
                    UserLogged = loggedUser
                    
                    // Load the HomeScreens storyboard
                                
                    guard let tabBarController = storyboard?.instantiateViewController(withIdentifier: "tabbarController") as? UITabBarController else {
                            print("Error: TabBarController not found in Home storyboard")
                            return
                        }
                    // Instantiate HomeViewController from the HomeScreens storyboard
                    if let homeVC = storyboard?.instantiateViewController(withIdentifier: "HomeScreen") as? CollectionViewController {
                        homeVC.logUser = UserLogged  // Pass logged-in user data
                   
                                    if var viewControllers = tabBarController.viewControllers {
                                               // Replace the first tab with the instantiated HomeVC
                                       viewControllers[0] = UINavigationController(rootViewController: homeVC)
                                       tabBarController.viewControllers = viewControllers
                                   }
                                }
                                if let window = UIApplication.shared.windows.first {
                                        window.rootViewController = tabBarController
                                        window.makeKeyAndVisible()
                                    }
                            } else {
                                let alert = UIAlertController(title: "Login Failed", message: "Invalid email or password. Please try again.", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default))
                                present(alert, animated: true)
                                print("User not found or incorrect credentials")
                            }
    }

    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    func navigateToNextPage() {
        // Add your segue or navigation logic here
        // Example:
        // let nextViewController = storyboard?.instantiateViewController(identifier: "NextViewController") as! NextViewController
        // navigationController?.pushViewController(nextViewController, animated: true)
    }
}

