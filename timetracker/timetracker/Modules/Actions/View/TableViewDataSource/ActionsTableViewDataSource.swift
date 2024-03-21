//
//  ActionsTableViewDataSource.swift
//  timetracker
//
//  Created by Polina Egorova on 14.03.2024.
//

import UIKit

protocol ActionsTableViewDataSource: UITableViewDataSource, UITableViewDelegate {
    func update(with actions: [ActionModel],
                tableView: UITableView,
                delegate: ActionsTableViewDataSourceDelegate
    )
}
