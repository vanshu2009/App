//
//  ChangePasswordTableViewController.swift
//  App
//
//  Created by Yuktika Sood on 23/01/25.
//

import UIKit

class ChangePasswordTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var oldPassword: UITextField!
    
    @IBOutlet weak var newPassword: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    var oldPasswordText: String? = "123456"
    
    var newPasswordText: String?
    
    var confirmPasswordText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do not display old password in the text field
        oldPassword.text = "" // Keep this empty to not show the old password
        
        // Optionally, make the oldPassword text field secure so the characters are hidden
        oldPassword.isSecureTextEntry = true
        
        // Set the view controller as the delegate of each text field
        oldPassword.delegate = self
        newPassword.delegate = self
        confirmPassword.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func changePasswordTapped(_ sender: UIButton) {
        // Step 1: Validate Input
        guard let oldPasswordText = oldPassword.text, !oldPasswordText.isEmpty else {
            showAlert(message: "Please enter your old password.")
            return
        }
        
        guard let newPasswordText = newPassword.text, !newPasswordText.isEmpty else {
            showAlert(message: "Please enter a new password.")
            return
        }
        
        guard let confirmPasswordText = confirmPassword.text, !confirmPasswordText.isEmpty else {
            showAlert(message: "Please confirm your new password.")
            return
        }
        
        // Step 2: Check if old password is correct (you could validate it with a stored value or an API)
        if oldPasswordText != self.oldPasswordText {
            showAlert(message: "Old password is incorrect.")
            return
        }
        
        // Step 3: Check if new password and confirm password match
        if newPasswordText != confirmPasswordText {
            showAlert(message: "New password and confirm password do not match.")
            return
        }
        
        // Step 4: Change the password (save to storage or API call)
        // Assuming you save the new password or update the backend here
        self.oldPasswordText = newPasswordText
        self.newPasswordText = newPasswordText
        self.confirmPasswordText = newPasswordText
        
        // Show success alert and navigate back to the previous screen
        showAlert(message: "Password changed successfully!", shouldNavigateBack: true)
    }

    func showAlert(message: String, shouldNavigateBack: Bool = false) {
        let alert = UIAlertController(title: "Change Password", message: message, preferredStyle: .alert)
        
        // Add OK action to the alert
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            if shouldNavigateBack {
                self.returnToLoginScreen()
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

    func returnToLoginScreen() {
        if let navigationController = self.navigationController {
            // Handle navigation stack scenario
            for viewController in navigationController.viewControllers {
                if viewController is UserProfileViewController {
                    navigationController.popToViewController(viewController, animated: true)
                    return
                }
            }
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }

}
