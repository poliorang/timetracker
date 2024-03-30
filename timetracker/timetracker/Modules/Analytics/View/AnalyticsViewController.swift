//
//  AnalyticsViewController.swift
//  timetracker
//
//  Created by Polina Egorova on 03.03.2024.
//

import UIKit
import DGCharts

final class AnalyticsViewController: UIViewController {
    
    // MARK: - Private properties
    
    private enum Constants {
        static let cellIdentifier: String = "AnalyticsTableViewCell"
    }
    
    private let output: AnalyticsViewOutput
    private let tableViewDataSource: AnalyticsTableViewDataSource
    
    private var tableView: UITableView
    private var pieChartView: PieChartView
    
    // MARK: - Init
    
    init(output: AnalyticsViewOutput,
         tableViewDataSource: AnalyticsTableViewDataSource) {
        self.output = output
        self.tableViewDataSource = tableViewDataSource
        
        self.tableView = UITableView().autolayout()
        self.pieChartView = PieChartView().autolayout()
        
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.setAnalytics()
    }
    
    // MARK: - Private functions
    
    private func setUpUI() {
        view.addSubview(pieChartView)
        NSLayoutConstraint.activate([
            pieChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pieChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pieChartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pieChartView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 20)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: pieChartView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setUpAppearance() {
        view.backgroundColor = .white
        tableView.register(AnalyticsTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.delegate = tableViewDataSource
        tableView.dataSource = tableViewDataSource
        tableView.separatorColor = .systemGray2
    }
}

extension AnalyticsViewController: AnalyticsViewInput {
    
    func configureChart(data: [AnalyticModel]) {
        var chartData: [PieChartDataEntry] = []
        var colors: [UIColor] = []
        for project in data {
            let label = "\(Double(round(100 * project.percentDuration!) / 100))%"
            chartData.append(PieChartDataEntry(value: project.percentDuration!, label: label))
            colors.append(project.color ?? .red)
        }
        
        let chartDataSet = PieChartDataSet(entries: chartData)
        chartDataSet.colors = colors
        chartDataSet.drawValuesEnabled = false
        let pieChartData = PieChartData(dataSet: chartDataSet)
        pieChartData.setValueFont(UIFont.systemFont(ofSize: 9))
        pieChartData.setValueTextColor(UIColor.systemGray)

        pieChartView.data = pieChartData
        pieChartView.legend.enabled = false
    }
    
    func configureTableView(data: [AnalyticModel]) {
        tableViewDataSource.update(
            with: data,
            tableView: tableView,
            delegate: self
        )
    }
    
    func present(module: UIViewController) {
        guard let childViewController = module as? AnalyticsViewController else { return }
        present(childViewController, animated: true)
    }
}

extension AnalyticsViewController: AnalyticsTableViewDataSourceDelegate {
    func openDetailAnalytics(id: Int) {
        output.openDetailAnalytics(id: id)
    }
}
