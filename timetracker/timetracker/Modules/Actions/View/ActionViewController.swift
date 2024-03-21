//
//  ActionViewController.swift
//  timetracker
//
//  Created by Polina Egorova on 14.03.2024.
//

import UIKit

final class ActionViewController: UIViewController {
    
    weak var delegate: TimerViewControllerDelegate?
    
    // MARK: - Private properties
    
    private enum Constants {
        static let cellIdentifier: String = "ActionsTableViewCell"
        static let emptyLabelText: String = "You haven't tracked the time yet"
    }
    private let output: ActionsViewOutput
    private let tableViewDataSource: ActionsTableViewDataSource
    private var tableView: UITableView
    private var emptyLabel: UILabel

    // MARK: - Init

    init(output: ActionsViewOutput,
         tableViewDataSource: ActionsTableViewDataSource
    ) {
        self.output = output
        self.tableViewDataSource = tableViewDataSource
        self.tableView = UITableView().autolayout()
        self.emptyLabel = UILabel().autolayout()
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpAppearance()
        updateTableView()
    }

    // MARK: - Private functions

    private func setUpUI() {
        view.backgroundColor = .white

        view.addSubview(emptyLabel)
        NSLayoutConstraint.activate([
            emptyLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            emptyLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            emptyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            emptyLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setUpAppearance() {
        emptyLabel.text = Constants.emptyLabelText
        emptyLabel.textColor = .systemGray2
        emptyLabel.textAlignment = .center
        emptyLabel.isHidden = true
        
        tableView.register(ActionsTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.delegate = tableViewDataSource
        tableView.dataSource = tableViewDataSource
        tableView.separatorColor = .black
    }
    
    private func updateTableView() {
        output.setActions()
    }
}

extension ActionViewController: ActionsViewInput {
    func didGetActions(actions: [ActionModel]) {
        if actions.isEmpty {
            DispatchQueue.main.async {
                self.emptyLabel.isHidden = false
                self.tableView.isHidden = true
            }
            return
        }
        
        DispatchQueue.main.async {
            self.emptyLabel.isHidden = true
            self.tableView.isHidden = false
        }
        tableViewDataSource.update(
            with: actions,
            tableView: tableView,
            delegate: self
        )
    }
}

extension ActionViewController: ActionsTableViewDataSourceDelegate {
    func setSelectedAction(action: ActionProject?) {
        delegate?.update(action: action)
        self.dismiss(animated: true)
    }
}
