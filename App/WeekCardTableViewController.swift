import UIKit

class WeekCardTableViewController: UITableViewController {

    // Array to hold stages passed from the previous view controller
    var stages: [Stage] = [] // Received from MyPlantsViewController
    var weeks: [Week] = [] // Array to hold weeks
    var currentWeekNumber = 1 // Track the running week number
    var selectedPlantName: String? // Property to hold selected plant name
    var selectedWeekIndex: Int? // To hold the selected week index
    let currentUser = DataModel.shared.getUser()
    var selectedPlantId: Int = 0
    let currentDate = Date()
    var addedDate: Date? {
        return currentUser.userPlants[selectedPlantId]?.addedDate
    }
    
    // Add a property to store the initial stage ID
    var initialStageId: Int? {
        return currentUser.userPlants[selectedPlantId]?.stageId
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the navigation bar title to the selected plant's name
        if let plantName = selectedPlantName {
            self.navigationItem.title = plantName // Set the title of the navigation bar
        }

        tableView.separatorStyle = .none

        // Prepare week data
        prepareWeeks()

        // Add image to the table header
        setupTableHeaderView()
    }

    // MARK: - Setup table header view
    private func setupTableHeaderView() {
      
        let stageId = DataModel.shared.getUser().userPlants[selectedPlantId]?.stageId
        
        let stageName = DataModel.shared.getPlantData(id: selectedPlantId)?.stages.first { $0.Id == stageId }?.name ?? ""
        
        let headerLabel = UILabel()
        headerLabel.text = "\(stageName)"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
        headerLabel.textColor = .black
        headerLabel.textAlignment = .center

        let headerHeight: CGFloat = 100
        headerLabel.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: headerHeight)
        tableView.tableHeaderView = headerLabel
    }

    // MARK: - Prepare week data based on stages
    // New property to map weeks to stages
    var weekStageMap: [Int: Stage] = [:] // Key: Index in `weeks`, Value: Corresponding `Stage`

    func prepareWeeks() {
        weeks.removeAll()
        weekStageMap.removeAll()
        currentWeekNumber = 1 // Reset the week counter to start at 1

        for stage in stages {
            if let totalWeeks = extractWeeks(from: stage.timeLine) {
                for _ in 1...totalWeeks {
                    let week = Week(weekNumber: "Week \(currentWeekNumber)", dailyTasks: [])
                    weeks.append(week)
                    weekStageMap[weeks.count - 1] = stage // Map the week index to the corresponding stage
                    currentWeekNumber += 1
                }
            }
        }
    }

    // MARK: - Calculate Total Weeks from Stages
    func calculateTotalWeeks(for stages: [Stage]) -> Int {
        var totalWeeks = 0

        for stage in stages {
            if let weeks = extractWeeks(from: stage.timeLine) {
                totalWeeks += weeks
            }
        }

        return totalWeeks
    }
    
    func extractWeeks(from timeLine: String) -> Int? {
        let regex = try? NSRegularExpression(pattern: "\\d+", options: [])
        let range = NSRange(location: 0, length: timeLine.utf16.count)

        if let match = regex?.firstMatch(in: timeLine, options: [], range: range) {
            if let range = Range(match.range, in: timeLine) {
                return Int(timeLine[range])
            }
        }

        return nil
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Single section for the weeks
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeks.count // Return the number of weeks
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeekCardCell", for: indexPath) as? WeekCardTableViewCell else {
            return UITableViewCell()
        }

        let week = weeks[indexPath.row]
        let currentStage = weekStageMap[indexPath.row]
        
        // Get the status based on initial stage and time passed
        let status: String
        let isCompleted: Bool
        
        // Calculate days since added for current progress
        let daysSinceAdded = Calendar.current.dateComponents([.day], from: addedDate ?? Date(), to: currentDate).day ?? 0
        let weekIndexFromAdded = daysSinceAdded / 7 // Determine the current week index
        
        // Check if the week's stage is before the initial stage
        if let initialStageId = initialStageId,
           let currentStage = currentStage,
           let initialStageIndex = stages.firstIndex(where: { $0.Id == initialStageId }),
           let currentStageIndex = stages.firstIndex(where: { $0.Id == currentStage.Id }) {
            
            
            if currentStageIndex < initialStageIndex {
                // This week is from an earlier stage than the initial stage
                // Mark as completed automatically
                status = "Completed"
                isCompleted = true
            } else if currentStageIndex > initialStageIndex {
                // This is a future stage
                if indexPath.row < weekIndexFromAdded {
                    status = "Completed"
                    isCompleted = true
                } else if indexPath.row == weekIndexFromAdded {
                    status = "Ongoing"
                    isCompleted = false
                } else {
                    status = "Upcoming"
                    isCompleted = false
                }
            } else {
                // Same stage as initial stage
                // Calculate how many weeks into this stage we are
                let previousWeeksCount = stages.prefix(initialStageIndex).reduce(0) { total, stage in
                    total + (extractWeeks(from: stage.timeLine) ?? 0)
                }
                
                let adjustedIndex = indexPath.row - previousWeeksCount
                
                if adjustedIndex < weekIndexFromAdded {
                    status = "Completed"
                    isCompleted = true
                } else if adjustedIndex == weekIndexFromAdded {
                    status = "Ongoing"
                    isCompleted = false
                } else {
                    status = "Upcoming"
                    isCompleted = false
                }
            }
        } else {
            // Fallback to original logic if we can't determine stage relationships
            if indexPath.row < weekIndexFromAdded {
                status = "Completed"
                isCompleted = true
            } else if indexPath.row == weekIndexFromAdded {
                status = "Ongoing"
                isCompleted = false
            } else {
                status = "Upcoming"
                isCompleted = false
            }
        }

        cell.configure(with: week.weekNumber, status: status, isCompleted: isCompleted)
        return cell
    }

    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160 // Fixed height for the cards
    }

    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedStage = weekStageMap[indexPath.row] else {
            print("Error: No stage found for week \(indexPath.row)")
            return
        }

        // Determine the zero-based index of the week within the stage
        let weekIndexWithinStage = (0...indexPath.row)
            .filter { weekStageMap[$0] == selectedStage }
            .count - 1 // Subtract 1 to get zero-based index within the stage

        guard weekIndexWithinStage < selectedStage.task.count else {
            print("Error: Invalid week index for the selected stage")
            return
        }

        let selectedWeek = selectedStage.task[weekIndexWithinStage]

        if let storyboard = storyboard,
           let destinationVC = storyboard.instantiateViewController(withIdentifier: "WeekScheduleTableViewController") as? WeekScheduleTableViewController {

            let daysSinceAdded = Calendar.current.dateComponents([.day], from: addedDate ?? Date(), to: currentDate).day ?? 0
            let weekIndexFromAdded = daysSinceAdded / 7

            var dailyStatuses: [(String, String)] = []

            if let initialStageId = initialStageId,
               let currentStage = weekStageMap[indexPath.row],
               let initialStageIndex = stages.firstIndex(where: { $0.Id == initialStageId }),
               let currentStageIndex = stages.firstIndex(where: { $0.Id == currentStage.Id }) {

                if currentStageIndex < initialStageIndex {
                    // Previous stage — all days completed
                    dailyStatuses = selectedWeek.dailyTasks.map { ($0.task, "Completed") }

                } else if currentStageIndex > initialStageIndex {
                    // Future stage — all days Upcoming, unless week is at the boundary
                    if indexPath.row < weekIndexFromAdded {
                        dailyStatuses = selectedWeek.dailyTasks.map { ($0.task, "Completed") }
                    } else if indexPath.row == weekIndexFromAdded {
                        dailyStatuses = selectedWeek.dailyTasks.enumerated().map { index, task in
                            if index < daysSinceAdded % 7 {
                                return (task.task, "Completed")
                            } else if index == daysSinceAdded % 7 {
                                return (task.task, "Ongoing")
                            } else {
                                return (task.task, "Upcoming")
                            }
                        }
                    } else {
                        dailyStatuses = selectedWeek.dailyTasks.map { ($0.task, "Upcoming") }
                    }

                } else {
                    // Same stage
                    let previousWeeksCount = stages.prefix(initialStageIndex).reduce(0) { total, stage in
                        total + (extractWeeks(from: stage.timeLine) ?? 0)
                    }
                    let adjustedIndex = indexPath.row - previousWeeksCount

                    if adjustedIndex < weekIndexFromAdded {
                        dailyStatuses = selectedWeek.dailyTasks.map { ($0.task, "Completed") }
                    } else if adjustedIndex == weekIndexFromAdded {
                        dailyStatuses = selectedWeek.dailyTasks.enumerated().map { index, task in
                            if index < daysSinceAdded % 7 {
                                return (task.task, "Completed")
                            } else if index == daysSinceAdded % 7 {
                                return (task.task, "Ongoing")
                            } else {
                                return (task.task, "Upcoming")
                            }
                        }
                    } else {
                        dailyStatuses = selectedWeek.dailyTasks.map { ($0.task, "Upcoming") }
                    }
                }
            } else {
                // Fallback logic
                dailyStatuses = selectedWeek.dailyTasks.enumerated().map { index, task in
                    if index < daysSinceAdded {
                        return (task.task, "Completed")
                    } else if index == daysSinceAdded {
                        return (task.task, "Ongoing")
                    } else {
                        return (task.task, "Upcoming")
                    }
                }
            }

            destinationVC.currentWeekTasks = dailyStatuses
            navigationController?.pushViewController(destinationVC, animated: true)
        }
    }

}
