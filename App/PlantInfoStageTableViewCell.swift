//
//  plantInfoStageTableViewCell.swift
//  App
//
//  Created by Yuktika Sood on 31/12/24.
//

import UIKit

class PlantInfoStageTableViewCell: UITableViewCell {

    @IBOutlet weak var stageImageView: UIImageView!
    
    @IBOutlet weak var stageTitleLabel: UILabel!
    
    @IBOutlet weak var stageDescriptionLabel: UILabel!
    
    @IBOutlet weak var stageTimelineLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Set background color to BBE884
        contentView.backgroundColor = UIColor(red: 187/255, green: 232/255, blue: 132/255, alpha: 1.0)
            
            // Add black border
            contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
            
            // Optional: Add rounded corners
            contentView.layer.cornerRadius = 8
            contentView.layer.masksToBounds = true
        
               stageImageView.layer.cornerRadius = 8
                stageImageView.layer.masksToBounds = true
        
        stageDescriptionLabel.numberOfLines = 0 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
