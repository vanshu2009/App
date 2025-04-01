import UIKit

extension UIColor {
    // Create a UIColor from a hex value
    static func fromHex(_ hex: String, alpha: CGFloat = 1.0) -> UIColor {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

import UIKit

class WaterTableViewController: UITableViewController {
    
    @IBOutlet weak var selectAllButton: UIButton!
    @IBOutlet weak var noTasksLabel: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
    
    var plants = [
        ("Aloe Vera", "Keep the soil moist", UIImage(named: "aloeVera1"))
    ]
    
    var isSelectAllTriggered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Today's Task", style: .plain, target: nil, action: nil)
        self.navigationItem.largeTitleDisplayMode = .never
        noTasksLabel.isHidden = true
        
        // Set up "No Tasks" label constraints
        noTasksLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noTasksLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noTasksLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "WaterTableViewCell", for: indexPath)
        
        let (name, water, image) = plants[indexPath.row]
        
        if let waterCell = cell as? WaterTableViewCell {
            waterCell.nameLabel.text = name
            waterCell.waterLabel.text = water
            waterCell.plantImageView.image = image
            waterCell.plantImageView.layer.cornerRadius = 13

            waterCell.completeButton.tag = indexPath.row
            waterCell.completeButton.addTarget(self, action: #selector(completeButtonTapped(_:)), for: .touchUpInside)
            
            if isSelectAllTriggered {
                waterCell.backgroundColor = UIColor.fromHex("75BFB7", alpha: 0.5)
                waterCell.completeButton.backgroundColor = .systemBlue
            } else {
                waterCell.backgroundColor = UIColor.systemBackground
            }
        }
        
        return cell
    }
    
    // MARK: - Actions

    @objc func completeButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        
        guard index < plants.count else { return }
        
        guard let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? WaterTableViewCell else { return }
        
        sender.backgroundColor = .systemBlue
        cell.contentView.backgroundColor = UIColor.fromHex("D1E8E2", alpha: 1.0)
        
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
                // Remove all plants and update UI
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
        noTasksLabel.isHidden = !plants.isEmpty
        selectAllButton.isHidden = plants.isEmpty
    }
}
