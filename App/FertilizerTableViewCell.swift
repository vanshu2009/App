//
//  FertilizerTableViewCell.swift
//  App
//
//  Created by Yuktika Sood on 07/01/25.
//

import UIKit

class FertilizerTableViewCell: UITableViewCell {

    @IBOutlet weak var fertilizerPlantName: UILabel!
    
    @IBOutlet weak var ertilizerPlantTask: UILabel!
    
    @IBOutlet weak var fertilizerPlantImage: UIImageView!
    @IBOutlet weak var completeButton:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
