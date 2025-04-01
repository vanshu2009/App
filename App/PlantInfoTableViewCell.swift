//
//  plantInfoTableViewCell.swift
//  App
//
//  Created by Yuktika Sood on 12/12/24.
//

import UIKit

class PlantInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var plantInfoView1: UIView!
   
    @IBOutlet weak var plantInfoWater: UILabel!
    
    @IBOutlet weak var plantInfoDrop: UIImageView!
    
    @IBOutlet weak var plantInfoAmount: UILabel!
    
    @IBOutlet weak var plantInfoView2: UIView!
    
    @IBOutlet weak var plantInfoTemp: UILabel!
    
    @IBOutlet weak var plantInfoThermo: UIImageView!
    
    @IBOutlet weak var plantInfoTempNeeded: UILabel!
    
    @IBOutlet weak var plantInfoView3: UIView!
    
    @IBOutlet weak var plantInfoLight: UILabel!
    
    
    @IBOutlet weak var plantInfoSun: UIImageView!
    
    @IBOutlet weak var plantInfoLightNeed: UILabel!
    
    @IBOutlet weak var plantInfoPlantImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.masksToBounds = true
        
        plantInfoView1.layer.cornerRadius = 8
        plantInfoView1.layer.masksToBounds = true
        
        plantInfoView2.layer.cornerRadius = 8
        plantInfoView2.layer.masksToBounds = true
        
        plantInfoView3.layer.cornerRadius = 8
        plantInfoView3.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
