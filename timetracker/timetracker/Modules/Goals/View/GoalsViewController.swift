//
//  GoalsViewController.swift
//  timetracker
//
//  Created by Polina Egorova on 03.03.2024.
//

import UIKit

class GoalsViewController: UIViewController {

    // MARK: - Private properties
    
    private enum Constants {
        static let cellIdentifier: String = "GoalsTableViewCell"
    }
    
    private let output: GoalsViewOutput
    private let tableViewDataSource: GoalsTableViewDataSource
   
    private var projectsTabControl: TabControl
    private var plusButton: UIButton
    private var tableView: UITableView
    
    // MARK: - Init
    
    init(output: GoalsViewOutput,
         tableViewDataSource: GoalsTableViewDataSource) {
        self.output = output
        self.tableViewDataSource = tableViewDataSource
        
        self.projectsTabControl = TabControl().autolayout()
        self.plusButton = UIButton().autolayout()
        self.tableView = UITableView().autolayout()
        
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
        output.setProjects()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.setProjects()
        if let goal = projectsTabControl.selectedLabel,
           let text = goal.text {
            output.setGoalsForProject(projectName: text)
        }
    }
    
    // MARK: - Private functions
    
    private func setUpUI() {
        view.addSubview(projectsTabControl)
        NSLayoutConstraint.activate([
            projectsTabControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            projectsTabControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            projectsTabControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            projectsTabControl.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        view.addSubview(plusButton)
        NSLayoutConstraint.activate([
            plusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusButton.topAnchor.constraint(equalTo: projectsTabControl.bottomAnchor, constant: 20),
            plusButton.heightAnchor.constraint(equalToConstant: 32),
            plusButton.widthAnchor.constraint(equalToConstant: 32)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: plusButton.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setUpAppearance() {
        view.backgroundColor = .white
        
        projectsTabControl.contentInset.left = 16
        projectsTabControl.onTap = { [weak self] tabText in
            self?.output.setGoalsForProject(projectName: tabText)
        }
        
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.tintColor = .systemGray
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        tableView.register(GoalsTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.delegate = tableViewDataSource
        tableView.dataSource = tableViewDataSource
        tableView.separatorColor = .systemGray2
    }
    
    @objc private func plusButtonTapped() {
        output.openCreateGoals()
    }
}

extension GoalsViewController: GoalsViewInput {
    func didGetProjects(projectNames: [Project]) {
        DispatchQueue.main.async { [weak self] in
            self?.projectsTabControl.labels = projectNames
            if projectNames.count >= 1 {
                self?.projectsTabControl.setSelectedLabel(text: projectNames[0])
                self?.output.setGoalsForProject(projectName: projectNames[0])
            }
        }
    }
    
    func configureTableView(data: [GoalModel]) {
        tableViewDataSource.update(
            with: data,
            tableView: tableView,
            delegate: self
        )
    }
    
    func present(module: UIViewController) {
        guard let childViewController = module as? CreateGoalViewController else { return }
        present(childViewController, animated: true)
    }
}

extension GoalsViewController: GoalsTableViewDataSourceDelegate {
    
}
