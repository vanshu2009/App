//
//  ChangeProfileInfoTableViewController.swift
//  App
//
//  Created by Vanshika Garg on 14/01/25.
//

import UIKit

protocol ChangeProfileInfoDelegate: AnyObject {
    func didUpdateProfileInfo(userName: String, email: String, location: String)
}

class ChangeProfileInfoTableViewController: UITableViewController {
    
    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    @IBOutlet weak var Email: UITextField!
    
    @IBOutlet weak var Location: UITextField!
    var userNameText: String?
    var passwordText: String?
    var emailText: String?
    var location: String = DataModel.shared.getUser().location
    weak var delegate: ChangeProfileInfoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserName.text = userNameText
//        Password.text = passwordText
        Email.text = emailText
        Location.text = location

        
    }
    
    @IBAction func Done(_ sender: UIBarButtonItem) {
        let user = DataModel.shared.getUser() // No need for optional binding

        let updatedUserName = UserName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let updatedEmail = Email.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let updatedLocation = Location.text?.trimmingCharacters(in: .whitespacesAndNewlines)

        // Call update function
        DataModel.shared.updateUserDetails(userId: user.userId, newName: updatedUserName, newEmail: updatedEmail, newLocation: updatedLocation)

        // Notify delegate
        delegate?.didUpdateProfileInfo(userName: updatedUserName ?? "", email: updatedEmail ?? "", location: updatedLocation ?? "")

        // Dismiss the view controller
        self.dismiss(animated: true, completion: nil)
    }


    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = super.tableView(tableView, cellForRowAt: indexPath)
            cell.contentView.layoutMargins = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
            return cell
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
    
}
