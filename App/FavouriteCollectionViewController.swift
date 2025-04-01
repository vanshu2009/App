//
//  favouriteCollectionViewController.swift
//  browseall
//
//  Created by Yuktika Sood on 15/01/25.
//

import UIKit

private let reuseIdentifier = "FavouriteCell"

//struct favouritePlant {
//    let name: String
//    let imageName: String
//}

class FavouriteCollectionViewController: UICollectionViewController {
    
    // Property to hold favorite plants
    var favouritePlants: [Plant] = []  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = favourite()
        collectionView.reloadData() // Reload data after view loads
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouritePlants.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FavouriteCollectionViewCell else {
            fatalError("Could not dequeue cell with identifier \(reuseIdentifier)")
        }
        
        let plant = favouritePlants[indexPath.item]
        cell.favouriteImage.image = plant.image
                                                    // Use a placeholder if imageName is nil
        cell.favouriteImage.backgroundColor = UIColor(named: "#D9D9D9")
        cell.favouriteImage.layer.cornerRadius = 15
        cell.favouriteImage.layer.masksToBounds = true
        cell.favouriteLabel.text = plant.name
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let selectedPlant = favouritePlants[indexPath.item]
            navigateToPlantInfo(plantID: selectedPlant.id)  // Pass the selected plant's ID
        }
        
        // Navigate to the plant's detailed view
        func navigateToPlantInfo(plantID: Int) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name
            if let plantInfoVC = storyboard.instantiateViewController(withIdentifier: "PlantInfoVC") as? PlantInfoTableViewController {
                plantInfoVC.plantID = plantID // Pass the selected plant ID
                navigationController?.pushViewController(plantInfoVC, animated: true)
            }
        }
    func favourite() -> UICollectionViewLayout {
            return UICollectionViewCompositionalLayout { sectionIndex, _ in
                guard sectionIndex == 0 else { return nil }
                
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .fractionalHeight(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(160)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
        }
}

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */


