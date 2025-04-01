import UIKit

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

private let reuseIdentifier = "Cell"
private let browseHeaderReuseIdentifier = "BrowseHeader"
private let browseHeaderElementKind = "BrowseHeader"

class BrowseCollectionViewController: UICollectionViewController, UISearchResultsUpdating {
    
    private var plants: [Plant] = []           // Original plant list
    private var filteredPlants: [Plant] = []   // Filtered plant list based on search
    
    func create() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(220)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)

            let browseHeaderSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(50)
            )
            let browseHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: browseHeaderSize,
                elementKind: browseHeaderElementKind,
                alignment: .top,
                absoluteOffset: CGPoint(x: 0, y: 60)
            )

            section.boundarySupplementaryItems = [browseHeader]
            section.contentInsets = NSDirectionalEdgeInsets(top: 60, leading: 0, bottom: 0, trailing: 0)
            return section
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = create()
        
        plants = DataModel.shared.getAllPlants()
        filteredPlants = plants // Initially, show all plants
        
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: browseHeaderElementKind, withReuseIdentifier: browseHeaderReuseIdentifier)

        // Setup search bar
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
       searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Plants by Name"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredPlants.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? BrowseCollectionViewCell else {
            fatalError("Could not dequeue cell with identifier \(reuseIdentifier)")
        }
        let plant = filteredPlants[indexPath.item]
        cell.browseImage.image = plant.image
        cell.browseImage.backgroundColor = .systemGray4
        cell.browseImage.layer.cornerRadius = 15
        cell.browseImage.layer.masksToBounds = true
        cell.label.text = plant.name
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPlant = filteredPlants[indexPath.item]
        navigateToPlantInfo(plantID: selectedPlant.id)
    }

    func navigateToPlantInfo(plantID: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let plantInfoVC = storyboard.instantiateViewController(withIdentifier: "PlantInfoVC") as? PlantInfoTableViewController {
            plantInfoVC.plantID = plantID
            navigationController?.pushViewController(plantInfoVC, animated: true)
        }
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == browseHeaderElementKind {
            let browseHeaderView = collectionView.dequeueReusableSupplementaryView(
                ofKind: browseHeaderElementKind,
                withReuseIdentifier: browseHeaderReuseIdentifier,
                for: indexPath
            )
            browseHeaderView.subviews.forEach { $0.removeFromSuperview() }
            let label = UILabel(frame: browseHeaderView.bounds)
            label.text = "Browse All"
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            browseHeaderView.addSubview(label)
            return browseHeaderView
        }
        return UICollectionReusableView()
    }

    // MARK: - UISearchResultsUpdating

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }

        if searchText.isEmpty {
            filteredPlants = plants
        } else {
            filteredPlants = plants.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }

        collectionView.reloadData()
    }
}
