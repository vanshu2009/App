//
//  FavouritePlantsTableViewCell.swift
//  App
//
//  Created by Yankit Kumar on 14/01/25.
//

import UIKit

class FavouritePlantsTableViewCell: UITableViewCell {

    @IBOutlet weak var FavouritePlants: UILabel!
    @IBOutlet weak var FavouriteImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
