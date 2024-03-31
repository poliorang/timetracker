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
    
    private var projectLabel: UILabel
    private var pieChartView: PieChartView
    private var tableView: UITableView
    private var startDateLabel: DateTextField
    private var finishDateLabel: DateTextField
    private var toolbar: UIToolbar
    
    // MARK: - Init
    
    init(output: AnalyticsViewOutput,
         tableViewDataSource: AnalyticsTableViewDataSource) {
        self.output = output
        self.tableViewDataSource = tableViewDataSource
        
        self.projectLabel = UILabel().autolayout()
        self.pieChartView = PieChartView().autolayout()
        self.tableView = UITableView().autolayout()
        self.startDateLabel = DateTextField().autolayout()
        self.finishDateLabel = DateTextField().autolayout()
        self.toolbar = UIToolbar().autolayout()
        
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
        setupToolbar()
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
        
        view.addSubview(projectLabel)
        NSLayoutConstraint.activate([
            projectLabel.leadingAnchor.constraint(equalTo: pieChartView.leadingAnchor, constant: 16),
            projectLabel.topAnchor.constraint(equalTo: pieChartView.topAnchor, constant: 18)
        ])
        
        view.addSubview(startDateLabel)
        NSLayoutConstraint.activate([
            startDateLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            startDateLabel.topAnchor.constraint(equalTo: pieChartView.topAnchor, constant: 8)
        ])
        
        view.addSubview(finishDateLabel)
        NSLayoutConstraint.activate([
            finishDateLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            finishDateLabel.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor)
        ])
    }
    
    private func setUpAppearance() {
        view.backgroundColor = .white
        tableView.register(AnalyticsTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.delegate = tableViewDataSource
        tableView.dataSource = tableViewDataSource
        tableView.separatorColor = .systemGray2
        
        projectLabel.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    private func setupToolbar() {
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexSpace, flexSpace, doneBtn]
        toolbar.sizeToFit()
        
        startDateLabel.inputAccessoryView = toolbar
        finishDateLabel.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
        if let start = startDateLabel.text, let finish = finishDateLabel.text,
           !start.isEmpty, !finish.isEmpty, startDateLabel.isCorrect, finishDateLabel.isCorrect {
            output.setDatesAndAnalytics(start: start, finish: finish)
        }
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
    
    func configureProjectName(_ name: String) {
        projectLabel.text = name
    }
    
    func configureDates(start: String, finish: String) {
        startDateLabel.text = start
        finishDateLabel.text = finish
    }
    
    func present(module: UIViewController) {
        guard let childViewController = module as? AnalyticsViewController else { return }
        present(childViewController, animated: true) { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension AnalyticsViewController: AnalyticsTableViewDataSourceDelegate {
    func openDetailAnalytics(id: Int, projectName: String) {
        output.openDetailAnalytics(id: id, projectName: projectName)
    }
}


extension AnalyticsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == startDateLabel.text {
            startDateLabel.placeholder = startDateLabel.text
            startDateLabel.text = ""
        }
        if textField.text == finishDateLabel.text {
            finishDateLabel.placeholder = finishDateLabel.text
            finishDateLabel.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
