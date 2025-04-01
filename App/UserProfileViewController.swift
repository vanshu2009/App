//
//  UserProfileViewController.swift
//  App
//
//  Created by Yuktika Sood on 23/12/24.
//

import UIKit

class UserProfileViewController: UIViewController, ChangeProfileInfoDelegate {
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var myView: UIView!
    
    @IBOutlet weak var UserLabel: UILabel!
    
    @IBOutlet weak var UserName: UILabel!
    
    @IBOutlet weak var UserGmail: UILabel!
    
//    @IBOutlet weak var UserAdd: UILabel!
    
    var updatedUserName: String?
    var updatedEmail: String?
    var updatedLocation: String?
    var logUser: UserSection? = DataModel.shared.getUser()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Apply corner radius to myView
        myView.layer.cornerRadius = myView.frame.size.width / 2

        // Bring myView to the front and send stackView to the back
        myView.layer.zPosition = 1
            stackView.layer.zPosition = 0

        // Populate UI with logUser details
        if let logUser = logUser {
            UserName.text = logUser.userName
            UserGmail.text = logUser.email
//            UserAdd.text = logUser.location
            if let firstLetter = logUser.userName.first {
                UserLabel.text = String(firstLetter).uppercased()
            }
        }
    }

    
    func didUpdateProfileInfo(userName: String, email: String,location:String) {
        UserName.text = userName
        UserGmail.text = email
//        UserAdd.text = location
        if let firstLetter = userName.first {
                UserLabel.text = String(firstLetter).uppercased()
            }
    }
    
    
    @IBAction func changeProfileInfoButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "showChangeProfile", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChangeProfile" {
            if let navigationController = segue.destination as? UINavigationController, let destinationVC = navigationController.viewControllers.first as? ChangeProfileInfoTableViewController {
                destinationVC.userNameText = UserName.text
                destinationVC.passwordText = "" 
                destinationVC.emailText = UserGmail.text
//                destinationVC.location = logUser?.location
                destinationVC.delegate = self
            }
        }
    }
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        // Clear the logged-in user session
        

        // Get the main storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        // Instantiate WelcomeViewController
        if let welcomeVC = storyboard.instantiateViewController(withIdentifier: "initial") as? UINavigationController {
            
            // Set it as the root view controller
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = welcomeVC
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
    }

    
}
//import UIKit
//
//class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    
//    private let tableView = UITableView()
//    private var user = DataModel.shared.getUser()
//    
//    private var sections: [(header: String?, items: [[String: String]])] = [
//        (nil, [["title": "", "icon": "person.circle"]]),
//        (nil, [
//            ["title": "Edit Profile", "icon": "key.fill"],
//            ["title": "Request a Plant", "icon": "person.crop.circle.badge.xmark"]
//        ]),
//        (nil, [["title": "Log Out", "icon": ""]])
//    ]
//    
//    private var selectedImage: UIImage?
//    private var selectedName: String {
//        return DataModel.shared.getUser().userName
//    }
//
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupTableView()
//        setupNavigationBar()
//        loadUserProfile()
//    }
//    
//    private func setupTableView() {
//        view.addSubview(tableView)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.0)
//        tableView.separatorStyle = .none
//        tableView.register(ProfileCell.self, forCellReuseIdentifier: "ProfileCell")
//        tableView.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
//        tableView.register(LogoutCell.self, forCellReuseIdentifier: "LogoutCell")
//    }
//    
//    private func setupNavigationBar() {
//        navigationItem.title = "Profile"
//        navigationController?.navigationBar.prefersLargeTitles = true
//    }
//    
//    private func loadUserProfile() {
//        
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return sections.count
//    }
//
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return sections[section].items.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let item = sections[indexPath.section].items[indexPath.row]
//        
//        if indexPath.section == 0 && indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
//            cell.configure(name: selectedName, profileImage: selectedImage)
//            return cell
//        } else if indexPath.section == sections.count - 1 {
//            return tableView.dequeueReusableCell(withIdentifier: "LogoutCell", for: indexPath) as! LogoutCell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
//            cell.configure(with: item["title"] ?? "", iconName: item["icon"] ?? "")
//            return cell
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        
//        if indexPath.section == 0 && indexPath.row == 0 {
//            // Profile Cell tapped (Do nothing for now)
//        } else if sections[indexPath.section].items[indexPath.row]["title"] == "Edit Profile" {
//            let editProfileVC = ChangeProfileInfoTableViewController()
//            navigationController?.pushViewController(editProfileVC, animated: true)
//        } else if sections[indexPath.section].items[indexPath.row]["title"] == "Request a Plant" {
//            do {
//                let requestPlantVC = RequestPlantTableViewController()
//                navigationController?.pushViewController(requestPlantVC, animated: true)
//            } catch {
//                print("Error navigating to RequestPlantTableViewController: \(error.localizedDescription)")
//            }
//
//        } else if indexPath.section == sections.count - 1 {
//            handleLogOut()
//        }
//    }
//
//    
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//        if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
//            self.selectedImage = image
//            updateProfileInSettingsView(animated: true)
//        }
//        dismiss(animated: true)
//    }
//    
//    private func updateProfileInSettingsView(animated: Bool) {
//        let indexPath = IndexPath(row: 0, section: 0)
//        if animated {
//            UIView.transition(with: tableView, duration: 0.3, options: .transitionCrossDissolve) {
//                self.tableView.reloadRows(at: [indexPath], with: .fade)
//            }
//        } else {
//            tableView.reloadRows(at: [indexPath], with: .none)
//        }
//    }
//    
//    private func handleLogOut() {
//        let alert = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
//            Task {
//                
//                UserDefaults.standard.removeObject(forKey: "currentUserId")
//                self.navigateToLoginScreen()
//            }
//        }))
//        present(alert, animated: true)
//    }
//    
//    private func navigateToLoginScreen() {
//        let loginVC = UINavigationController(rootViewController: LoginViewController())
//        if let window = UIApplication.shared.windows.first {
//            window.rootViewController = loginVC
//            window.makeKeyAndVisible()
//        }
//    }
//}
//import UIKit
//
//// MARK: - Custom Profile Cell
//class ProfileCell: UITableViewCell {
//    private let profileImageView = UIImageView()
//    private let nameLabel = UILabel()
//    private let containerView = UIView()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupUI() {
//        selectionStyle = .none
//        backgroundColor = .clear
//        
//        // Container view setup for card-like appearance
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.backgroundColor = .white
//        containerView.layer.cornerRadius = 12
//        contentView.addSubview(containerView)
//        
//        profileImageView.translatesAutoresizingMaskIntoConstraints = false
//        profileImageView.layer.cornerRadius = 30
//        profileImageView.clipsToBounds = true
//        profileImageView.contentMode = .scaleAspectFill
//        
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        nameLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
//        
//        containerView.addSubview(profileImageView)
//        containerView.addSubview(nameLabel)
//        
//        NSLayoutConstraint.activate([
//            // Container constraints
//            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
//            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
//            
//            // Profile image constraints
//            profileImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
//            profileImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            profileImageView.widthAnchor.constraint(equalToConstant: 60),
//            profileImageView.heightAnchor.constraint(equalToConstant: 60),
//            
//            // Name label constraints
//            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
//            nameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            
//            // Make the cell taller
//            containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80)
//        ])
//    }
//    
//    func configure(name: String, profileImage: UIImage?) {
//        nameLabel.text = name
//        
//        if let profileImage = profileImage {
//            profileImageView.image = profileImage
//        } else {
//            profileImageView.image = createInitialsImage(name: name)
//        }
//    }
//    private func createInitialsImage(name: String) -> UIImage? {
//        let initials = name.components(separatedBy: " ").compactMap { $0.first }.prefix(2)
//        let initialsString = String(initials)
//
//        let size = CGSize(width: 60, height: 60)
//        let renderer = UIGraphicsImageRenderer(size: size)
//        
//        return renderer.image { context in
//            UIColor.systemBlue.setFill()
//            context.fill(CGRect(origin: .zero, size: size))
//            
//            let attributes: [NSAttributedString.Key: Any] = [
//                .foregroundColor: UIColor.white,
//                .font: UIFont.boldSystemFont(ofSize: 24)
//            ]
//            
//            let textSize = initialsString.size(withAttributes: attributes)
//            let rect = CGRect(
//                x: (size.width - textSize.width) / 2,
//                y: (size.height - textSize.height) / 2,
//                width: textSize.width,
//                height: textSize.height
//            )
//            
//            initialsString.draw(in: rect, withAttributes: attributes)
//        }
//    }
//
//
//}
//
//// MARK: - Custom Settings Cell
//class SettingsCell: UITableViewCell {
//    private let iconImageView = UIImageView()
//    private let titleLabel = UILabel()
//    private let containerView = UIView()
//    private let disclosureIndicator = UIImageView()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupUI() {
//        backgroundColor = .clear
//        selectionStyle = .none
//        
//        // Container view setup
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.backgroundColor = .white
//        contentView.addSubview(containerView)
//        
//        // Icon setup
//        iconImageView.translatesAutoresizingMaskIntoConstraints = false
//        iconImageView.contentMode = .scaleAspectFit
//        iconImageView.tintColor = .white
//        iconImageView.backgroundColor = .systemBlue
//        iconImageView.layer.cornerRadius = 16
//        iconImageView.clipsToBounds = true
//        
//        // Title setup
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.font = UIFont.systemFont(ofSize: 17)
//        
//        // Disclosure indicator setup
//        disclosureIndicator.translatesAutoresizingMaskIntoConstraints = false
//        disclosureIndicator.image = UIImage(systemName: "chevron.right")
//        disclosureIndicator.tintColor = .systemGray
//        disclosureIndicator.contentMode = .scaleAspectFit
//        
//        containerView.addSubview(iconImageView)
//        containerView.addSubview(titleLabel)
//        containerView.addSubview(disclosureIndicator)
//        
//        NSLayoutConstraint.activate([
//            // Container constraints
//            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            
//            // Icon constraints
//            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
//            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            iconImageView.widthAnchor.constraint(equalToConstant: 32),
//            iconImageView.heightAnchor.constraint(equalToConstant: 32),
//            
//            // Title constraints
//            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
//            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            
//            // Disclosure indicator constraints
//            disclosureIndicator.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
//            disclosureIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            disclosureIndicator.widthAnchor.constraint(equalToConstant: 8),
//            disclosureIndicator.heightAnchor.constraint(equalToConstant: 13),
//            
//            // Set the cell height
//            containerView.heightAnchor.constraint(equalToConstant: 44)
//        ])
//        
//        // Add separator line
//        let separator = UIView()
//        separator.translatesAutoresizingMaskIntoConstraints = false
//        separator.backgroundColor = UIColor.systemGray5
//        containerView.addSubview(separator)
//        
//        NSLayoutConstraint.activate([
//            separator.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
//            separator.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
//            separator.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
//            separator.heightAnchor.constraint(equalToConstant: 0.5)
//        ])
//    }
//    
//    func configure(with title: String, iconName: String) {
//        titleLabel.text = title
//        
//        let iconSize: CGFloat = 20
//        
//        if let systemImage = getSystemImageFor(iconName: iconName) {
//            let configuration = UIImage.SymbolConfiguration(pointSize: iconSize, weight: .regular)
//            iconImageView.image = systemImage.withConfiguration(configuration)
//            
//            // Set specific colors for specific menu items based on the mockup
//            if iconName == "hourglass" {
//                iconImageView.backgroundColor = .systemIndigo
//            } else if iconName == "accessibility" {
//                iconImageView.backgroundColor = .systemBlue
//            } else if iconName == "hand.raised.fill" {
//                iconImageView.backgroundColor = .systemBlue
//            } else if iconName == "bell.fill" {
//                iconImageView.backgroundColor = .systemRed
//            } else if iconName == "snowflake.circle.fill" {
//                iconImageView.backgroundColor = .systemTeal
//            } else if iconName == "gearshape" {
//                iconImageView.backgroundColor = .systemGray
//            } else {
//                iconImageView.backgroundColor = .systemBlue
//            }
//        } else {
//            iconImageView.image = UIImage(systemName: "questionmark")
//            iconImageView.backgroundColor = .systemGray
//        }
//    }
//    
//    private func getSystemImageFor(iconName: String) -> UIImage? {
//        // Map the icon names from your data model to the actual SF Symbols
//        switch iconName {
//        case "hourglass":
//            return UIImage(systemName: "hourglass")
//        case "gearshape":
//            return UIImage(systemName: "gearshape")
//        case "accessibility":
//            return UIImage(systemName: "accessibility")
//        case "hand.raised.fill":
//            return UIImage(systemName: "hand.raised.fill")
//        case "bell.fill":
//            return UIImage(systemName: "bell.fill")
//        case "snowflake.circle.fill":
//            return UIImage(systemName: "snowflake.circle.fill")
//        default:
//            return UIImage(systemName: iconName)
//        }
//    }
//    
//    func configureBorders(isFirstInSection: Bool, isLastInSection: Bool) {
//        if isFirstInSection && isLastInSection {
//            // Single cell in section
//            containerView.layer.cornerRadius = 12
//            containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//        } else if isFirstInSection {
//            // First cell in section
//            containerView.layer.cornerRadius = 12
//            containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        } else if isLastInSection {
//            // Last cell in section
//            containerView.layer.cornerRadius = 12
//            containerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//        } else {
//            // Middle cell in section
//            containerView.layer.cornerRadius = 0
//        }
//    }
//}
//
//// MARK: - Custom Logout Cell
//class LogoutCell: UITableViewCell {
//    private let logoutLabel = UILabel()
//    private let containerView = UIView()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupUI() {
//        backgroundColor = .clear
//        selectionStyle = .none
//        
//        // Container view setup
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.backgroundColor = .white
//        containerView.layer.cornerRadius = 12
//        contentView.addSubview(containerView)
//        
//        // Logout label setup
//        logoutLabel.translatesAutoresizingMaskIntoConstraints = false
//        logoutLabel.text = "Log Out"
//        logoutLabel.textColor = .systemRed
//        logoutLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
//        logoutLabel.textAlignment = .center
//        
//        containerView.addSubview(logoutLabel)
//        
//        NSLayoutConstraint.activate([
//            // Container constraints
//            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
//            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
//            
//            // Logout label constraints
//            logoutLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//            logoutLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
//            logoutLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
//            logoutLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
//            containerView.heightAnchor.constraint(equalToConstant: 44)
//        ])
//    }
//}
