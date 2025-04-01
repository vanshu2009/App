import UIKit

class MendingTableViewController: UITableViewController {

    @IBOutlet weak var SelectAll: UIButton!
    @IBOutlet weak var NoTaskLabel: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
    
    var plants = [
        ("Marigold", "Check drainage to avoid root rot", UIImage(named: "marigold1"))
    ]
    
    var isSelectAllTriggered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        NoTaskLabel.isHidden = true
        
        // Center the "No Tasks" label
        NoTaskLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NoTaskLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            NoTaskLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Set up header image view constraints
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: view.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MendingTableViewCell", for: indexPath)
        
        let (name, task, image) = plants[indexPath.row]
        
        if let mendingCell = cell as? MendingTableViewCell {
            mendingCell.plantName.text = name
            mendingCell.plantTask.text = task
            mendingCell.MendingPlantImage.image = image
            mendingCell.MendingPlantImage.layer.cornerRadius = 13
            mendingCell.completeButton.tag = indexPath.row
            mendingCell.completeButton.addTarget(self, action: #selector(completeButtonTapped(_:)), for: .touchUpInside)

            // Apply background color based on "Select All" state
            if isSelectAllTriggered {
                mendingCell.backgroundColor = UIColor.fromHex("F4A261", alpha: 0.5) // Light orange
                mendingCell.completeButton.backgroundColor = .systemBlue
            } else {
                mendingCell.backgroundColor = UIColor.systemBackground
            }
        }
        
        return cell
    }
    
    // MARK: - Actions

    @objc func completeButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        
        guard index < plants.count else { return }
        
        guard let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? MendingTableViewCell else { return }
        
        sender.backgroundColor = .systemBlue
        cell.contentView.backgroundColor = UIColor.fromHex("F4A261", alpha: 1.0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.3, animations: {
                cell.alpha = 0.0
            }) { _ in
                self.plants.remove(at: index)
                self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                
                self.updateNoTasksLabel()
                self.tableView.reloadData()
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
                
                self.updateNoTasksLabel()
                sender.isHidden = true
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func updateNoTasksLabel() {
        // Show or hide the "No Tasks" label based on the plants array
        NoTaskLabel.isHidden = !plants.isEmpty
        SelectAll.isHidden = plants.isEmpty
    }
}
