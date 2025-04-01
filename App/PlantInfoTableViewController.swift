//
//  plantInfoTableViewController.swift
//  App
//
//  Created by Yankit Kumar on 12/12/24.
//

import UIKit

class PlantInfoTableViewController: UITableViewController {
    
    var plantID: Int?
    var plant: Plant?
    var favoriteButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let plantID = plantID{
            plant = DataModel.shared.getPlantData(id: plantID)
        }
        if let plant = plant{
            navigationItem.title = plant.name
        }
//        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PlantInfoCell")
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AboutCell")
        
        setupFooterView()
        setupFavoriteButtonState()
    }
    func setupFooterView() {
        // Create the footer view
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
        footerView.backgroundColor = UIColor.white

        // Create a horizontal stack view
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // Add "Add to my plants" button
        let addToPlantsButton = UIButton(type: .system)
        addToPlantsButton.setTitle("Add to my plants", for: .normal)
        addToPlantsButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        addToPlantsButton.backgroundColor = UIColor(red: 187/255, green: 232/255, blue: 132/255, alpha: 1.0)
        addToPlantsButton.setTitleColor(.black, for: .normal)
        addToPlantsButton.layer.cornerRadius = 25
        addToPlantsButton.clipsToBounds = true
        addToPlantsButton.addTarget(self, action: #selector(addToPlantsTapped), for: .touchUpInside)

        addToPlantsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addToPlantsButton.heightAnchor.constraint(equalToConstant: 50),
            addToPlantsButton.widthAnchor.constraint(equalToConstant: 200)
        ])

        // Add "Favorite" button
        favoriteButton = UIButton(type: .system) // Now assigning to the property
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.tintColor = .black
        favoriteButton.backgroundColor = UIColor(red: 187/255, green: 232/255, blue: 132/255, alpha: 1.0)
        favoriteButton.layer.cornerRadius = 25
        favoriteButton.clipsToBounds = true
        favoriteButton.layer.borderColor = UIColor.lightGray.cgColor
        favoriteButton.layer.borderWidth = 1.0
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            favoriteButton.widthAnchor.constraint(equalToConstant: 50),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)

        // Add buttons to the stack view
        stackView.addArrangedSubview(addToPlantsButton)
        stackView.addArrangedSubview(favoriteButton)

        // Add the stack view to the footer view
        footerView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: footerView.widthAnchor, multiplier: 0.7),
            stackView.heightAnchor.constraint(equalTo: footerView.heightAnchor)
        ])

        // Set the footer view to the table view
        tableView.tableFooterView = footerView
    }






    private var isStageSelected: Bool = false

    @objc func addToPlantsTapped(_ sender: UIButton) {
        guard let plant = plant else { return }

        if isStageSelected {
            return
        }

        let actionSheet = UIAlertController(
            title: "Select Plant Stage",
            message: "Please select the stage your plant is currently in:",
            preferredStyle: .actionSheet
        )

        for stage in plant.stages {
            // Add each stage as an action
            let action = UIAlertAction(title: "\(stage.name) (\(stage.timeLine))", style: .default) { _ in
                self.handleStageSelection(stage, sender: sender)
            }
            actionSheet.addAction(action)
        }

        // Add a cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)

        // Present the action sheet
        present(actionSheet, animated: true, completion: nil)
    }


    /// Handle the user's stage selection
    private func handleStageSelection(_ stage: Stage, sender: UIButton) {
        print("User selected stage: \(stage.name)")

        // Change the button's title to "Added" and disable further interactions
        sender.setTitle("Added", for: .normal)
        sender.isEnabled = false // Disable the button to prevent further taps

        // Get the current user
        var currentUser = DataModel.shared.getUser()

        // Add the plant to the user's plants
        guard let plant = plant else { return }
        let currentDate = Date()
        let plantData = PlantData(addedDate: currentDate, stageId: stage.Id)
        currentUser.userPlants[plant.id] = plantData

        // Update the user in the data model
        DataModel.shared.updateUser(currentUser)
 
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        print("Plant added to user's plants: \(plant.name) in stage: \(stage.name)")

        // Optional: Notify the user about the success
        let alert = UIAlertController(
            title: "Plant Added",
            message: "Your plant '\(plant.name)' has been added to your list in stage '\(stage.name)'.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        tableView.reloadData()
        present(alert, animated: true, completion: nil)
    }

    func setupFavoriteButtonState() {
        guard let plant = plant, let favoriteButton = favoriteButton else { return }
        let currentUser = DataModel.shared.getUser()
        
        // Check if the plant is in the user's favorites
        let isFavorite = currentUser.favouritePlantsId.contains(plant.id)
        
        // Set the favorite button's initial state
        if isFavorite {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }


    @objc func favoriteTapped(_ sender: UIButton) {
        guard let plant = plant else { return }

        // Toggle the favorite status
        var currentUser = DataModel.shared.getUser()

        if currentUser.favouritePlantsId.contains(plant.id) {
            // If the plant is already in favorites, remove it
            currentUser.favouritePlantsId.removeAll { $0 == plant.id }
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            // Otherwise, add the plant to favorites
            currentUser.favouritePlantsId.append(plant.id)
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }

        // Update the user in the data model
        DataModel.shared.updateUser(currentUser)

        // Optional: Provide feedback to the user
        let alertMessage = currentUser.favouritePlantsId.contains(plant.id)
            ? "Added to Favorites"
            : "Removed from Favorites"

        let alert = UIAlertController(title: "Favorites Updated", message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)

        print("Favorites updated: \(currentUser.favouritePlantsId)")
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
            guard let plant = plant else { return 0 }
            return 2 + plant.stages.count
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return 1
        }

        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let plant = plant else {
                return UITableViewCell() // Handle the case where plant data is not available
            }

            if indexPath.section == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlantInfoCell", for: indexPath) as? PlantInfoTableViewCell else {
                    return UITableViewCell()
                }
                // Configure Plant Info Cell using the plant data
                cell.plantInfoWater.text = "Water"
                cell.plantInfoAmount.text = plant.waterRequired
                cell.plantInfoTemp.text = "Temp"
                cell.plantInfoTempNeeded.text = plant.temperatureRequired
                cell.plantInfoLight.text = "Light"
                cell.plantInfoLightNeed.text = plant.lightRequired
                cell.plantInfoPlantImg.image = plant.image
                cell.plantInfoWater.font = UIFont.systemFont(ofSize: 18)
                cell.plantInfoTemp.font = UIFont.systemFont(ofSize: 18)
                cell.plantInfoLight.font = UIFont.systemFont(ofSize: 18)
                cell.plantInfoAmount.font = UIFont.systemFont(ofSize: 18)
                cell.plantInfoTempNeeded.font = UIFont.systemFont(ofSize: 18)
                cell.plantInfoLightNeed.font = UIFont.systemFont(ofSize: 18)
                cell.plantInfoWater.textAlignment = .center
                cell.plantInfoTemp.textAlignment = .center
                cell.plantInfoLight.textAlignment = .center

                return cell
            } else if indexPath.section == 1 {
                let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "AboutCell")
                    cell.textLabel?.text = "About"
                    cell.textLabel?.font = UIFont.systemFont(ofSize: 32)
                    cell.detailTextLabel?.text = plant.description
                    cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 17)
                    cell.detailTextLabel?.numberOfLines = 0
                cell.separatorInset = .zero
                    
                    cell.selectionStyle = .none

                    return cell            } else if indexPath.section >= 2 {
                // The section for plant stages, dynamically handled
                let stageIndex = indexPath.section - 2 // Adjust for stages starting from section 2
                guard stageIndex < plant.stages.count else {
                    return UITableViewCell() // Handle the case if the stage index is out of bounds
                }

                let stage = plant.stages[stageIndex]
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "StageCell", for: indexPath) as? PlantInfoStageTableViewCell else {
                    return UITableViewCell()
                }

                // Configure each stage dynamically based on the plant's growth stages
                cell.stageTitleLabel.text = stage.name
                cell.stageDescriptionLabel.text = stage.information
                cell.stageTimelineLabel.text = stage.timeLine
                cell.stageImageView.image = stage.image
                return cell
            }
            return UITableViewCell()
        }

        
        
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.section == 0 {
                return 271 // Fixed height for Plant Info
            } else if indexPath.section == 1 {
                return UITableView.automaticDimension // Dynamic height for About section
            } else if indexPath.section >= 2 && indexPath.section < 2 + (plant?.stages.count ?? 0) {
                return 200 // Fixed height for each stage cell
            }
            return UITableView.automaticDimension
        }
    @objc func addPlant() {
        // Ensure valid plant and user IDs
        guard let plantId = plant?.id, let userId = plantID else { return }
     
        let alert = UIAlertController(
            title: "Plant Added",
            message: "Your plant '\(plant?.name ?? "Unknown")' has been added to your list in stage 'Seedling'.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            // Switch to the third tab in the Tab Bar Controller
  
            if let tabBarController = self.tabBarController {
                tabBarController.selectedIndex = 2 // Switch to the third tab (index starts from 0)
            } else {
                print("Tab Bar Controller not found")
            }
        }))
        
        present(alert, animated: true, completion: nil)
    }
    


//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedPlant = DataModel.shared.plants[indexPath.row]
//        let detailsVC = PlantInfoTableViewController() // Instantiate programmatically
//        detailsVC.plant = selectedPlant
//        detailsVC.plantID = plantID
//        navigationController?.pushViewController(detailsVC, animated: true)
//    }



    }
