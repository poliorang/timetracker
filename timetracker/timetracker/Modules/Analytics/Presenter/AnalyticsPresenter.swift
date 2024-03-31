//
//  AnalyticsPresenter.swift
//  timetracker
//
//  Created by Polina Egorova on 12.03.2024.
//

import UIKit

final class AnalyticsPresenter {
    
    weak var view: AnalyticsViewInput?
    public var id: Int? = nil {
        didSet {
            configureDates()
        }
    }
    
    // MARK: - Private properties
    
    private enum Constants {
        
    }
    
    private var analytics: AnalyticsProjectsModel?
    
    private let interactor: AnalyticsInteractorInput
    private let assemblyFactory = AssemblyFactoryImpl.shared
    
    private var startDate: Date?
    private var finishDate: Date?

    // MARK: - Init

    init(interactor: AnalyticsInteractorInput) {
        self.interactor = interactor
    }
    
    // MARK: - Private functions

    private func generateColors(data: inout [AnalyticModel]) {
        for i in 0..<data.count {
            data[i].color = UIColor.customColors[i % UIColor.customColors.count]
        }
    }
    
    private func configureDates() {
        if startDate != nil && finishDate != nil {
            return
        }
        
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"

        if let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date()),
           let oneYearAgo = calendar.date(byAdding: .year, value: -1, to: Date()) {
            
            startDate = oneYearAgo
            finishDate = tomorrow
            view?.configureDates(start: dateFormatter.string(from: oneYearAgo),
                                 finish: dateFormatter.string(from: tomorrow)
            )
            
            getAnalytics()
        }
    }
    
    private func getAnalytics() {
        guard let startDate = startDate, let finishDate = finishDate else {
            return
        }
        
        let analyticsParams = AnalyticsParams(id: id, startDate: startDate, finishDate: finishDate)
        interactor.getAnalytics(analyticsParams: analyticsParams) { [weak self] data in
            var data = data
            self?.generateColors(data: &data)
            DispatchQueue.main.async {
                self?.view?.configureChart(data: data)
                self?.view?.configureTableView(data: data)
            }
        }
    }
}

extension AnalyticsPresenter: AnalyticsViewOutput {
    func setAnalytics() {
        if startDate == nil || finishDate == nil {
            configureDates()
            return
        }
        
        getAnalytics()
    }
    
    func openDetailAnalytics(id: Int, projectName: String) {
        let childModule = assemblyFactory.detailAnalyticsModuleAssembly().module()
        childModule.presenter.id = id
        childModule.presenter.configureProjectName(projectName)
        view?.present(module: childModule.view)
    }
    
    func setDatesAndAnalytics(start: String, finish: String) {
        startDate = start.toDate()
        finishDate = finish.toDate()
        setAnalytics()
    }
}

extension AnalyticsPresenter: AnalyticsInteractorOutput {
    
}

extension AnalyticsPresenter: AnalyticsModuleInput {
    func configureProjectName(_ name: String) {
        view?.configureProjectName(name)
    }
}
