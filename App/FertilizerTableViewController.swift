//
//  FertilizerTableViewController.swift
//  App
//
//  Created by Yuktika Sood on 07/01/25.
//

import UIKit

class FertilizerTableViewController: UITableViewController {

    @IBOutlet weak var fertilizerSelectAll: UIButton!
    @IBOutlet weak var fertilizerNoTask: UILabel!

    var plants: [(name: String, fertilizer: String, image: UIImage)] = []
    var isSelectAllTriggered = false

    override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationItem.largeTitleDisplayMode = .never

            // Set up the "No Pending Task" label
            fertilizerNoTask.isHidden = plants.count > 0
            fertilizerNoTask.text = "No Pending Task"
            fertilizerNoTask.textAlignment = .center
            fertilizerNoTask.textColor = .systemGray
            fertilizerNoTask.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            fertilizerNoTask.translatesAutoresizingMaskIntoConstraints = false

            // Center the label in the view
            NSLayoutConstraint.activate([
                fertilizerNoTask.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                fertilizerNoTask.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])

            // Initially hide "Select All" button if no tasks exist
            fertilizerSelectAll.isHidden = plants.isEmpty
        }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FertilizerTableViewCell", for: indexPath)

        let (name, fertilizer, image) = plants[indexPath.row]

        if let fertilizerCell = cell as? FertilizerTableViewCell {
            fertilizerCell.fertilizerPlantName.text = name
            fertilizerCell.ertilizerPlantTask.text = fertilizer
            fertilizerCell.fertilizerPlantImage.image = image
            fertilizerCell.fertilizerPlantImage.layer.cornerRadius = 13
            fertilizerCell.completeButton.tag = indexPath.row
            fertilizerCell.completeButton.addTarget(self, action: #selector(completeButtonTapped(_:)), for: .touchUpInside)
            fertilizerCell.completeButton.layer.cornerRadius = 15

            // If "Select All" is triggered, change background and button color
            if isSelectAllTriggered {
                fertilizerCell.backgroundColor = UIColor.fromHex("579862", alpha: 0.5)
                fertilizerCell.completeButton.backgroundColor = .systemBlue
            } else {
                fertilizerCell.backgroundColor = UIColor.systemBackground
            }
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove plant and update table view
            plants.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)

            // Show "No Tasks" label if no tasks are left
            updateNoTasksLabel()
        }
    }

    @objc func completeButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        guard index < plants.count else { return }
        guard let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? FertilizerTableViewCell else { return }

        // Trigger completion animation
        sender.backgroundColor = .systemBlue
        cell.contentView.backgroundColor = UIColor.fromHex("579862", alpha: 1.0)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.3, animations: {
                cell.alpha = 0.0
            }) { _ in
                // Remove plant after animation
                self.plants.remove(at: index)
                self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)

                // Update "No Tasks" label visibility
                self.updateNoTasksLabel()
            }
        }
    }

    @IBAction func fertilizerSelectAllTap(_ sender: UIButton) {
        // Disable the "Select All" button and update its title
        sender.isEnabled = false
        sender.setTitle("Selected", for: .normal)

        // Trigger "Select All" logic
        isSelectAllTriggered = true
        tableView.reloadData()

        // Animate the rows fading out, then remove all tasks
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            UIView.animate(withDuration: 1.0, animations: {
                for cell in self.tableView.visibleCells {
                    cell.alpha = 0.0
                }
            }) { _ in
                // Remove all plants and reset view
                self.plants.removeAll()
                self.tableView.reloadData()

                // Update UI
                sender.isHidden = true
                self.fertilizerNoTask.isHidden = false
            }
        }
    }

    // Helper function to update the "No Tasks" label visibility
    private func updateNoTasksLabel() {
        fertilizerNoTask.isHidden = !plants.isEmpty
        fertilizerSelectAll.isHidden = plants.isEmpty
    }
}
