
import UIKit

class PruningTableViewController: UITableViewController {

    @IBOutlet weak var selectAllButton: UIButton!
    @IBOutlet weak var noTasksLabel: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
    
    var plants: [(name: String, task: String, image: UIImage)] = [] // Sample structure
    
    var isSelectAllTriggered = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Today's Task", style: .plain, target: nil, action: nil)
        self.navigationItem.largeTitleDisplayMode = .never
        headerImageView.image = UIImage(named: "Pruning")
        
        // Center the noTasksLabel
        noTasksLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noTasksLabel)
        NSLayoutConstraint.activate([
            noTasksLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noTasksLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        noTasksLabel.text = "No Pending Task"
        noTasksLabel.textAlignment = .center
        noTasksLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        noTasksLabel.textColor = .secondaryLabel
        
        // Update visibility
        noTasksLabel.isHidden = !plants.isEmpty
        selectAllButton.isHidden = plants.isEmpty
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PruningTableViewCell", for: indexPath)
        
        let plant = plants[indexPath.row]
        
        if let pruningCell = cell as? PruningTableViewCell {
            pruningCell.plantName.text = plant.name
            pruningCell.plantTask.text = plant.task
            pruningCell.plantImage.image = plant.image
            pruningCell.plantImage.layer.cornerRadius = 13
            pruningCell.completeButton.tag = indexPath.row
            pruningCell.completeButton.addTarget(self, action: #selector(completeButtonTapped(_:)), for: .touchUpInside)
            
            if isSelectAllTriggered {
                pruningCell.backgroundColor = UIColor.fromHex("928637", alpha: 0.5)
                pruningCell.completeButton.backgroundColor = .systemBlue
            } else {
                pruningCell.backgroundColor = UIColor.systemBackground
                pruningCell.completeButton.backgroundColor = UIColor.systemBackground
            }
        }
        
        return cell
    }

    @objc func completeButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        
        guard index < plants.count else { return }
        guard let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? PruningTableViewCell else { return }
        
        sender.backgroundColor = .systemBlue
        cell.contentView.backgroundColor = UIColor.fromHex("928637", alpha: 1.0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.3, animations: {
                cell.alpha = 0.0
            }) { _ in
                self.plants.remove(at: index)
                self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                
                // Update UI if no plants are left
                self.updateNoTasksUI()
            }
        }
    }

    @IBAction func selectAllTapped(_ sender: UIButton) {
        sender.isEnabled = false
        sender.setTitle("Selected", for: .normal)
        isSelectAllTriggered = true
        tableView.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UIView.animate(withDuration: 0.5, animations: {
                for cell in self.tableView.visibleCells {
                    cell.alpha = 0.0
                }
            }) { _ in
                self.plants.removeAll()
                self.tableView.reloadData()
                
                // Update UI if no plants are left
                self.updateNoTasksUI()
            }
        }
    }
    
    /// Updates the UI when no tasks are left
    private func updateNoTasksUI() {
        noTasksLabel.isHidden = !plants.isEmpty
        selectAllButton.isHidden = plants.isEmpty
    }
}
