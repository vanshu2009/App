//
//  MyPlantsTableViewCell.swift
//  App
//
//  Created by Yankit Kumar on 14/01/25.
//

import UIKit

class MyPlantsTableViewCell: UITableViewCell {

    @IBOutlet weak var plantImageView: UIImageView!
    @IBOutlet weak var plantLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Set corner radius for circular appearance
        plantImageView.layer.cornerRadius = plantImageView.frame.size.width / 2
        plantImageView.clipsToBounds = true
        
        // Ensure the image fits well within the bounds
        plantImageView.contentMode = .scaleAspectFill
    }
    
    func configure(with plant: Plant) {
        plantLabel.text = plant.name
        
        if let image = plant.image {
            // Resize the image to fit the view (e.g., 100x100 size)
            let resizedImage = resizeImage(image, to: CGSize(width: 100, height: 100))
            plantImageView.image = resizedImage
        } else {
            // Use a placeholder image if no image is provided
            plantImageView.image = UIImage(systemName: "leaf.fill")
        }
    }
    
    // Helper function to resize an image
    private func resizeImage(_ image: UIImage, to size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
