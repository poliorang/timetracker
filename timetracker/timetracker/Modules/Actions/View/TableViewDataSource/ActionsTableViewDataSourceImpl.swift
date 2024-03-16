//
//  ActionsTableViewDataSourceImpl.swift
//  timetracker
//
//  Created by Polina Egorova on 14.03.2024.
//

import UIKit

protocol ActionsTableViewDataSourceDelegate: AnyObject {
    func getActions() -> [String]
    
    func setSelectedAction(action: String?)
}

final class ActionsTableViewDataSourceImpl: NSObject {
    
    // MARK: - Private properties
    
    private enum Constants {
        static let cellHeight: CGFloat = 50
        static let cellIdentifier: String = "ActionsTableViewCell"
    }

    private var cellCount: Int?
    private weak var tableView: UITableView?
    private weak var delegate: ActionsTableViewDataSourceDelegate?

    // MARK: - Init
    
    override init() {
        super.init()
    }
}

extension ActionsTableViewDataSourceImpl: ActionsTableViewDataSource {

    func update(with cellCount: Int,
                tableView: UITableView,
                delegate: ActionsTableViewDataSourceDelegate
    ) {
        self.cellCount = cellCount
        self.tableView = tableView
        self.delegate = delegate

        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? ActionsTableViewCell else {
            assertionFailure("Failed to set tableview cell")
            return UITableViewCell()
        }

        let actions = delegate?.getActions()
        cell.configure(
            actionName: actions?[indexPath.row] ?? "",
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
        let actions = delegate?.getActions()
        delegate?.setSelectedAction(action: actions?[indexPath.row])
    }
}
