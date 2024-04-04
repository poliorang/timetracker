//
//  GoalsTableViewDataSourceImpl.swift
//  timetracker
//
//  Created by Polina Egorova on 31.03.2024.
//

import UIKit

final class GoalsTableViewDataSourceImpl: NSObject {
    
    // MARK: - Private properties
    
    private enum Constants {
        static let cellHeight: CGFloat = 110
        static let cellIdentifier: String = "GoalsTableViewCell"
    }

    private var goals: [GoalModel]?
    private weak var tableView: UITableView?

    // MARK: - Init
    
    override init() {
        super.init()
    }
}

extension GoalsTableViewDataSourceImpl: GoalsTableViewDataSource {

    func update(with goals: [GoalModel],
                tableView: UITableView
    ) {
        self.goals = goals
        self.tableView = tableView

        DispatchQueue.main.async {
            tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? GoalsTableViewCell,
            let goals = goals else {
            assertionFailure("Failed to set tableview cell")
            return UITableViewCell()
        }

        let goal = goals[indexPath.row]
        cell.configure(
            goal: goal
        )
        cell.setUpUI()
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
}
