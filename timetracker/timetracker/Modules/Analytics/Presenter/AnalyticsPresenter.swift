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
            setAnalytics()
        }
    }
    
    // MARK: - Private properties
    
    private enum Constants {
        
    }
    
    private var analytics: AnalyticsProjectsModel?
    
    private let interactor: AnalyticsInteractorInput
    private let assemblyFactory = AssemblyFactoryImpl.shared

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
}

extension AnalyticsPresenter: AnalyticsViewOutput {
    func setAnalytics() {
        
        interactor.getAnalytics(id: id) { [weak self] data in
            var data = data
            self?.generateColors(data: &data)
            DispatchQueue.main.async {
                self?.view?.configureChart(data: data)
                self?.view?.configureTableView(data: data)
            }
        }
    }
    
    func openDetailAnalytics(id: Int) {
        let childModule = assemblyFactory.detailAnalyticsModuleAssembly().module()
        childModule.presenter.id = id
        view?.present(module: childModule.view)
    }
}

extension AnalyticsPresenter: AnalyticsInteractorOutput {
    
}
