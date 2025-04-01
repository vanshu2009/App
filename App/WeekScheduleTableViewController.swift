

import UIKit

class WeekScheduleTableViewController: UITableViewController {
    
    // Data source for tasks of the selected week
    var currentWeekTasks: [(description: String, status: String)] = []
    
    // Dates for the current week (Day, Date)
    var currentWeekDates: [(day: String, date: Date)] = []
    var currentWeek: Date = Date() // Starting date of the current week
    var selectedDate: Date? // Currently selected date
    let calendar = Calendar.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial setup
        updateCurrentWeekDates()
        setupTodayLabel()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Single section for tasks
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentWeekTasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeekCardCell", for: indexPath) as? WeekScheduleTableViewCell else {
            return UITableViewCell()
        }
        
        let task = currentWeekTasks[indexPath.row]
        cell.configure(with: task.description, status: task.status)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Task card height
    }
    
    private func updateCurrentWeekDates() {
        guard let weekInterval = calendar.dateInterval(of: .weekOfMonth, for: currentWeek) else { return }
        let startDate = weekInterval.start
        var dates: [(String, Date)] = []
        
        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: i, to: startDate) {
                let dayFormatter = DateFormatter()
                dayFormatter.dateFormat = "EEE"
                let day = dayFormatter.string(from: date)
                dates.append((day, date))
            }
        }
        
        currentWeekDates = dates
        updateTasksForCurrentWeek()
    }
    
    private func updateTasksForCurrentWeek() {
        // Logic to fetch tasks for the current week
        // This function should update `currentWeekTasks` based on `currentWeekDates`
        
        tableView.reloadData()
    }
    
    private func setupTodayLabel() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let todayLabel = UILabel()
        todayLabel.textAlignment = .center
        todayLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        todayLabel.text = formatter.string(from: Date())
        
        todayLabel.frame = headerView.bounds
        headerView.addSubview(todayLabel)
        
        tableView.tableHeaderView = headerView
    }
}
