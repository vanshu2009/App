//
//  MendingTableViewCell.swift
//  App
//
//  Created by Yuktika Sood on 13/01/25.
//

import UIKit

class MendingTableViewCell: UITableViewCell {

    @IBOutlet weak var MendingPlantImage: UIImageView!
    
    
    @IBOutlet weak var plantName: UILabel!
    
    
    @IBOutlet weak var plantTask: UILabel!
    
    @IBOutlet weak var completeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        completeButton.layer.cornerRadius = completeButton.frame.height / 2
        completeButton.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
