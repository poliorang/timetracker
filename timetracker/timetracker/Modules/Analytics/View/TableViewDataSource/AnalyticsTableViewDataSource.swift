//
//  AnalyticsTableViewDataSource.swift
//  timetracker
//
//  Created by Polina Egorova on 30.03.2024.
//

import UIKit

protocol AnalyticsTableViewDataSource: UITableViewDataSource, UITableViewDelegate {
    func update(with analytics: [AnalyticModel],
                tableView: UITableView,
                delegate: AnalyticsTableViewDataSourceDelegate
    )
}