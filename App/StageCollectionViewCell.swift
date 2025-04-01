import UIKit

class StageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var stageButton: UIButton!
    
    // Configure the button based on the stage
    func configure(with stage: PlantStage) {
        // Set the title of the button to the raw value of the stage
        stageButton.setTitle(stage.rawValue, for: .normal)
        
        // Set the corner radius for the capsule shape
        stageButton.layer.cornerRadius = stageButton.frame.height / 2  // Capsule shape
        stageButton.layer.masksToBounds = true  // Ensure the content is clipped to the button's bounds
        
        // Set initial button border (optional)
        stageButton.layer.borderWidth = 1.0
        stageButton.layer.borderColor = UIColor.black.cgColor
        
        // Set the initial text color and background color for unselected state
        stageButton.setTitleColor(.black, for: .normal)  // Text color is black initially
        stageButton.backgroundColor = .clear  // Transparent background initially
        
        // Set content edge insets to add some padding inside the button
//        stageButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)  // Add padding around the text
        
        // Set the button's content to expand with the text
        stageButton.sizeToFit()
        
        // Ensure the button size adjusts based on the content
        stageButton.translatesAutoresizingMaskIntoConstraints = false
    }
}
