//
//  GoalsTableViewDataSource.swift
//  timetracker
//
//  Created by Polina Egorova on 31.03.2024.
//

import UIKit

protocol GoalsTableViewDataSource: UITableViewDataSource, UITableViewDelegate {
    func update(with goals: [GoalModel],
                tableView: UITableView,
                delegate: GoalsTableViewDataSourceDelegate
    )
}

