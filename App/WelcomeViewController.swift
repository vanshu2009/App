//
//  WelcomeViewController.swift
//  App
//
//  Created by Yankit Kumar on 20/01/25.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var ButtonContinue: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ButtonContinue.layer.cornerRadius = 12.0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
