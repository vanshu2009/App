import UIKit

class WaterTableViewCell: UITableViewCell {
    @IBOutlet weak var plantImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var waterLabel: UILabel!
    
    // Add a button to trigger completion of tasks
    @IBOutlet weak var completeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        plantImageView.layer.cornerRadius = 15
        // Optionally, style the button if needed
        completeButton.layer.cornerRadius = completeButton.frame.height / 2
        completeButton.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
