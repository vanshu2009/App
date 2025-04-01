//
//  WeekCardTableViewCell.swift
//  browseall
//
//  Created by Yuktika Sood on 15/01/25.
//

import UIKit

class WeekCardTableViewCell: UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var disclosureImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Set corner radius for card
        cardView.layer.cornerRadius = 15
        cardView.layer.masksToBounds = true
        statusLabel.textColor = .darkGray
        
        

        // Default hidden green border
//        leftBorderView.backgroundColor = .green
//        leftBorderView.isHidden = true
    }

//    func configure(with week: String, status: String, isCompleted: Bool) {
//        weekLabel.text = week
//        statusLabel.text = status
//
//        if status == "Completed" {
//            cardView.layer.borderColor = UIColor.green.cgColor
//            cardView.layer.borderWidth = 3
//        } else {
//            cardView.layer.borderColor = UIColor.clear.cgColor
//            cardView.layer.borderWidth = 0
//        }
//    }
    func configure(with week: String, status: String, isCompleted: Bool) {
        // Set the text for the labels
        weekLabel.text = week
        statusLabel.text = status

        // Reset styles to avoid conflicts from reused cells
        cardView.layer.borderWidth = 0
        cardView.backgroundColor = .clear
        weekLabel.textColor = .label
        statusLabel.textColor = .darkGray
        cardView.alpha = 1.0
        cardView.layer.shadowOpacity = 0 // Reset shadow

        switch status {
        case "Completed":
            // Set a soft textured green background for completed
            cardView.backgroundColor = UIColor(
                red: 187.0 / 255.0,
                green: 232.0 / 255.0,
                blue: 132.0 / 255.0,
                alpha: 1
            )
            // Set a soothing border color that matches the card
            cardView.layer.borderColor = UIColor(
                red: 160.0 / 255.0,
                green: 210.0 / 255.0,
                blue: 140.0 / 255.0,
                alpha: 0.5
            ).cgColor
            cardView.layer.borderWidth = 2

            // Set text colors to gray for a completed look
            weekLabel.textColor = .darkGray
            statusLabel.textColor = .gray
            statusLabel.text = "🌿 \(status)"

            // Add subtle drop shadow for completion highlight
            cardView.layer.shadowColor = UIColor.darkGray.cgColor
            cardView.layer.shadowOffset = CGSize(width: 0, height: 3)
            cardView.layer.shadowOpacity = 0.2
            cardView.layer.shadowRadius = 4

        case "Ongoing":
            // Set a soft textured green background for completed
            cardView.backgroundColor = UIColor(
                red: 187.0 / 255.0,
                green: 232.0 / 255.0,
                blue: 132.0 / 255.0,
                alpha: 1
            )
            // Set a soothing border color that matches the card
            cardView.layer.borderColor = UIColor(
                red: 160.0 / 255.0,
                green: 210.0 / 255.0,
                blue: 140.0 / 255.0,
                alpha: 1
            ).cgColor
            cardView.layer.borderWidth = 4
            cardView.layer.cornerRadius = 20
            // Set text colors to gray for a completed look
            weekLabel.textColor = .darkGray
            statusLabel.textColor = .gray
            statusLabel.text = "🌱 \(status)"

            // Add subtle drop shadow for completion highlight
            cardView.layer.shadowColor = UIColor.darkGray.cgColor
            cardView.layer.shadowOffset = CGSize(width: 0, height: 3)
            cardView.layer.shadowOpacity = 0.2
            cardView.layer.shadowRadius = 4

        case "Upcoming":
            // Set a soft textured green background for completed
                cardView.backgroundColor = UIColor(
                    red: 190.0 / 255.0,
                    green: 231.0 / 255.0,
                    blue: 170.0 / 255.0,
                    alpha: 1
                )
                // Set a soothing border color that matches the card
                cardView.layer.borderColor = UIColor(
                    red: 160.0 / 255.0,
                    green: 210.0 / 255.0,
                    blue: 140.0 / 255.0,
                    alpha: 1
                ).cgColor
                cardView.layer.borderWidth = 2

                // Set text colors to gray for a completed look
                weekLabel.textColor = .darkGray
                statusLabel.textColor = .gray
                statusLabel.text = status

                // Add subtle drop shadow for completion highlight
                cardView.layer.shadowColor = UIColor.darkGray.cgColor
                cardView.layer.shadowOffset = CGSize(width: 0, height: 3)
                cardView.layer.shadowOpacity = 0.2
                cardView.layer.shadowRadius = 4

        default:
            // Default styling for other statuses
            cardView.layer.borderColor = UIColor.clear.cgColor
            cardView.layer.borderWidth = 0
        }
    }

}
