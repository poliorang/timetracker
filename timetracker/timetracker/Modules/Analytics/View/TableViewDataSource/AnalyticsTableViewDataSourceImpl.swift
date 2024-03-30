//
//  AnalyticsTableViewDataSourceImpl.swift
//  timetracker
//
//  Created by Polina Egorova on 30.03.2024.
//

import UIKit

protocol AnalyticsTableViewDataSourceDelegate: AnyObject {
//    func setSelectedAction(action: ActionProject?)
}


final class AnalyticsTableViewDataSourceImpl: NSObject {
    
    // MARK: - Private properties
    
    private enum Constants {
        static let cellHeight: CGFloat = 50
        static let cellIdentifier: String = "AnalyticsTableViewCell"
    }

    private var projects: [ProjectModel]?
    private weak var tableView: UITableView?
    private weak var delegate: AnalyticsTableViewDataSourceDelegate?

    // MARK: - Init
    
    override init() {
        super.init()
    }
}

extension AnalyticsTableViewDataSourceImpl: AnalyticsTableViewDataSource {

    func update(with projects: [ProjectModel],
                tableView: UITableView,
                delegate: AnalyticsTableViewDataSourceDelegate
    ) {
        self.projects = projects
        self.tableView = tableView
        self.delegate = delegate

        DispatchQueue.main.async {
            tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? AnalyticsTableViewCell,
            let projects = projects else {
            assertionFailure("Failed to set tableview cell")
            return UITableViewCell()
        }

        let project = projects[indexPath.row]
        cell.configure(
            project: project,
            delegate: delegate
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let action = actions?[indexPath.row] else { return }
//        delegate?.setSelectedAction(action: ActionProject(action.name, action.projectName))
    }
}
