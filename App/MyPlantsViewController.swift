
import UIKit

enum PlantStage: String, CaseIterable {
    case all = "All Plants"
    case germination = "Germination"
    case seedling = "Seedling"
    case vegetativeGrowth = "Vegetative Growth"
    case dormancy = "Dormancy"
    case budding = "Budding"
    case flowering = "Flowering"
    case maturity = "Maturity"
    case maturityPropagation = "Propagation"
}

class MyPlantsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    var currentUser: UserSection?
    var plants: [Plant] = []  // All plants data
    var users: [UserSection] = []
    var favouritePlant: Plant?  // Single favourite plant
    var selectedStage: PlantStage = .all  // Default to 'All'

    var searchController: UISearchController!
    var filteredPlantsList: [Plant] = []  // To hold search results
    var isSearching: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUser = DataModel.shared.getUser()

        // Set up collection view
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false

        // Set up table view
        tableView.delegate = self
        tableView.dataSource = self

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            layout.itemSize = UICollectionViewFlowLayout.automaticSize
        }

        setupSearchController()

        loadData()
    }

    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Plants"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func loadData() {
        plants = DataModel.shared.getAllPlants()
        users = DataModel.shared.getAllUsers()

        if let userId = currentUser?.userId {
            favouritePlant = DataModel.shared.plantsInFavourite(userId: userId)?.first
        } else {
            favouritePlant = nil
        }

        collectionView.reloadData()
        tableView.reloadData()
    }

    func filteredPlants() -> [Plant] {
        guard let user = currentUser else { return [] }

        if selectedStage == .all {
            return plants.filter { plant in
                user.userPlants.keys.contains(plant.id)
            }
        } else {
            return plants.filter { plant in
                if let plantData = user.userPlants[plant.id] {
                    return plant.stages.first(where: { $0.Id == plantData.stageId })?.name == selectedStage.rawValue
                }
                return false
            }
        }
    }
//
//    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
//        let actionSheet = UIAlertController(title: "Add Plant", message: "Choose an option", preferredStyle: .actionSheet)
//
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
//                self.presentImagePickerController(sourceType: .camera)
//            }))
//        }
//
//        actionSheet.addAction(UIAlertAction(title: "Choose from Gallery", style: .default, handler: { _ in
//            self.presentImagePickerController(sourceType: .photoLibrary)
//        }))
//
//        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//
//        present(actionSheet, animated: true, completion: nil)
//    }
//
//    func presentImagePickerController(sourceType: UIImagePickerController.SourceType) {
//        let imagePickerController = UIImagePickerController()
//        imagePickerController.sourceType = sourceType
//        imagePickerController.delegate = self
//        present(imagePickerController, animated: true, completion: nil)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//        guard info[.originalImage] is UIImage else { return }
//
//        let alertController = UIAlertController(title: "Add New Plant", message: "Enter the plant name", preferredStyle: .alert)
//
//        alertController.addTextField { textField in
//            textField.placeholder = "Plant Name"
//        }
//
//        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
//            guard let plantName = alertController.textFields?.first?.text, !plantName.isEmpty else { return }
//            self.tableView.reloadData()
//            self.collectionView.reloadData()
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//
//        alertController.addAction(addAction)
//        alertController.addAction(cancelAction)
//
//        dismiss(animated: true) {
//            self.present(alertController, animated: true, completion: nil)
//        }
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }
//
}

// MARK: - UISearchResultsUpdating & UISearchBarDelegate

extension MyPlantsViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            isSearching = true
            filteredPlantsList = filteredPlants().filter { $0.name.lowercased().contains(searchText.lowercased()) }
        } else {
            isSearching = false
            filteredPlantsList.removeAll()
        }
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        filteredPlantsList.removeAll()
        tableView.reloadData()
    }
}

// MARK: - Collection View Delegate & Data Source

extension MyPlantsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PlantStage.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StageCell", for: indexPath) as! StageCollectionViewCell
        let stage = PlantStage.allCases[indexPath.item]
        cell.configure(with: stage)

        if stage == selectedStage {
            cell.stageButton.backgroundColor = UIColor.black
            cell.stageButton.setTitleColor(.white, for: .normal)
        } else {
            cell.stageButton.backgroundColor = .clear
            cell.stageButton.setTitleColor(.black, for: .normal)
        }

        cell.stageButton.addTarget(self, action: #selector(didSelectStage(_:)), for: .touchUpInside)

        return cell
    }

    @objc func didSelectStage(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text, let selectedStage = PlantStage(rawValue: title) else { return }
        self.selectedStage = selectedStage
        collectionView.reloadData()
        tableView.reloadData()
    }
}

// MARK: - Table View Delegate & Data Source

extension MyPlantsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if selectedStage == .all {
                return favouritePlant == nil ? 0 : 1
            } else {
                return 0
            }
        } else {
            return isSearching ? filteredPlantsList.count : filteredPlants().count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritePlantCell", for: indexPath) as! FavouritePlantsTableViewCell
            cell.FavouriteImage.image = UIImage(systemName: "heart.fill")
            cell.FavouritePlants.text = "Favourite Plants"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlantCell", for: indexPath) as! MyPlantsTableViewCell
            let plant = isSearching ? filteredPlantsList[indexPath.row] : filteredPlants()[indexPath.row]
            cell.configure(with: plant)
            cell.tag = plant.id
            return cell
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return selectedStage == .all ? "Favourite Plant" : nil
        } else {
            return selectedStage == .all ? "All Plants" : selectedStage.rawValue
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func showWeekDetails(for plant: Plant) {
        guard let weekCardVC = storyboard?.instantiateViewController(withIdentifier: "WeekCardTableViewController") as? WeekCardTableViewController else {
            return
        }

        weekCardVC.selectedPlantName = plant.name
        weekCardVC.stages = plant.stages
        weekCardVC.selectedPlantId = plant.id

        navigationController?.pushViewController(weekCardVC, animated: true)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let selectedPlant = isSearching ? filteredPlantsList[indexPath.row] : filteredPlants()[indexPath.row]
            showWeekDetails(for: selectedPlant)
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Delete Plant", message: "Are you sure you want to delete this plant?", preferredStyle: .alert)

            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                let plantToDelete = self.isSearching ? self.filteredPlantsList[indexPath.row] : self.filteredPlants()[indexPath.row]
                if let index = self.plants.firstIndex(where: { $0.id == plantToDelete.id }) {
                    self.plants.remove(at: index)
                }
                self.currentUser?.userPlants.removeValue(forKey: plantToDelete.id)
                DataModel.shared.updateUser(self.currentUser!)
                self.tableView.reloadData()
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)

            present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func showFavoritesTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showFavorites", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFavorites" {
            if let destinationVC = segue.destination as? FavouriteCollectionViewController {
                if let userId = currentUser?.userId {
                    destinationVC.favouritePlants = DataModel.shared.plantsInFavourite(userId: userId) ?? []
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        currentUser = DataModel.shared.getUser()
        tableView.reloadData()
    }
}
