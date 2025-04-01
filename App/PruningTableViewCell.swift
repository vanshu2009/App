//
//  PruningTableViewCell.swift
//  App
//
//  Created by Yuktika Sood on 26/12/24.
//

import UIKit

class PruningTableViewCell: UITableViewCell {
    @IBOutlet weak var plantImage: UIImageView!
    
    @IBOutlet weak var plantName: UILabel!
    
    @IBOutlet weak var plantTask: UILabel!
    
    @IBOutlet weak var completeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        plantImage.layer.cornerRadius = 15
               completeButton.layer.cornerRadius = completeButton.frame.height / 2
               completeButton.clipsToBounds = true
        completeButton.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        super.setSelected(selected, animated: animated)
    }

}
