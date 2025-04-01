import UIKit

class CollectionViewController: UICollectionViewController {
    
    let taskOptions = ["Water", "Pruning", "Fertilizer", "Mending"]
    let taskImages = ["water", "pruning", "Fertilizer", "mending"]
    var recommendedPlantsData: [Plant] = []
    
    @IBOutlet weak var userImage: UIBarButtonItem!
    let taskColors: [UIColor] = [
        UIColor(hex: "#75BFB7"), // systemBlue
        UIColor(hex: "#928637"), // systemGreen
        UIColor(hex: "#579862"), // systemOrange
        UIColor(hex: "#D87F2B")  // systemPink
    ]
    let taskLogos = ["water01","Pruning logo","Fertilizer","Mending logo"]
    //    var tasksCount = [1,0,0,1]
    // user get
    var logUser: UserSection?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let logUser = logUser {
            if let recommendedPlants = DataModel.shared.getRecommendation(userId: logUser.userId) {
                recommendedPlantsData = recommendedPlants
            } else {
                recommendedPlantsData = []
            }
        }
//        setupUserImage()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
    }
    
    // MARK: - Create Compositional Layout
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
            case 0:
                return self.createTrendingSection()
            case 1:
                return self.createTaskSection()
            case 2:
                return self.createRecommendationSection()
            default:
                fatalError("Unexpected section")
            }
        }
    }
    


    // MARK: - Section Layouts
    
    // Trending Section
    private func createTrendingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.35))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
        
        // Add header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    // Task Section
    private func createTaskSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(120))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10)
        
        // Add header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    // Recommendation Section
    private func createRecommendationSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .absolute(150))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10)
        
        // Add header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    // MARK: - Data Source
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3 // Trending, Task, Recommendation
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return taskOptions.count
        case 2:
            return recommendedPlantsData.count
        default:
            return 0
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
            
        case 2:
            let selectedPlant = recommendedPlantsData[indexPath.item]
            navigateToPlantInfo(plantID: selectedPlant.id)
        case 1: // Today's Tasks
            let selectedTask = taskOptions[indexPath.row]
            var viewController: UIViewController?
            
            switch selectedTask {
            case "Water":
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                viewController = storyboard.instantiateViewController(withIdentifier: "WaterTableViewController") as? WaterTableViewController
            case "Pruning":
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                viewController = storyboard.instantiateViewController(withIdentifier: "PruningTableViewController") as? PruningTableViewController
            case "Fertilizer":
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                viewController = storyboard.instantiateViewController(withIdentifier: "FertilizerTableViewController") as? FertilizerTableViewController
            case "Mending":
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                viewController = storyboard.instantiateViewController(withIdentifier: "MendingTableViewController") as? MendingTableViewController
            default:
                return
            }
            
            if let viewController = viewController {
                navigationController?.pushViewController(viewController, animated: true)
            }
        default:
            break
        }
    }
    func navigateToPlantInfo(plantID: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name
        if let plantInfoVC = storyboard.instantiateViewController(withIdentifier: "PlantInfoVC") as? PlantInfoTableViewController {
            plantInfoVC.plantID = plantID // Pass the selected plant ID
            navigationController?.pushViewController(plantInfoVC, animated: true)
        }
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Trending", for: indexPath) as! TrendingCollectionViewCell
            cell.delegate = self
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Task", for: indexPath) as! TaskCollectionViewCell
            cell.titleLabel.text = taskOptions[indexPath.row]
            cell.imageView.image = UIImage(named: taskLogos[indexPath.row])
            //                cell.countTasks.text = "\(tasksCount[indexPath.item])"
            cell.contentView.backgroundColor = taskColors[indexPath.row % taskColors.count]
            cell.contentView.layer.cornerRadius = 20
            cell.contentView.layer.masksToBounds = true
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Recommendation", for: indexPath) as! RecommendationCollectionViewCell
            let plant = recommendedPlantsData[indexPath.row]
            cell.titleLabel.text = plant.name
            cell.imageView.image = plant.image
            return cell
        default:
            fatalError("Invalid section")
        }
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! HeaderReusableView
            switch indexPath.section {
            case 0:
                header.titleLabel.text = "Trending Plants"
            case 1:
                header.titleLabel.text = "Today's Tasks"
            case 2:
                header.titleLabel.text = "Recommended Plants"
            default:
                header.titleLabel.text = ""
            }
            return header
        }
        fatalError("Unexpected kind")
    }
    private func setupUserImage() {
        guard let logUser = logUser else { return }

        // Extract the first letter of the username and convert it to uppercase
        let firstLetter = logUser.userName.first?.uppercased() ?? "U"

        // Create a UIButton to display the initial
        let button = UIButton(type: .system)
        button.setTitle(firstLetter, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)

        // Assign the button to the userImage UIBarButtonItem
        userImage.customView = button
    }



}
class HeaderReusableView: UICollectionReusableView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 26)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
extension CollectionViewController: TrendingCollectionViewCellDelegate {
    func didSelectTrendingPlant(_ plant: Plant) {
        navigateToPlantInfo(plantID: plant.id)
    }
    
}
