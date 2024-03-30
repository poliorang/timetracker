//
//  AnalyticsPresenter.swift
//  timetracker
//
//  Created by Polina Egorova on 12.03.2024.
//

import UIKit

final class AnalyticsPresenter {

    weak var view: AnalyticsViewInput?

    // MARK: - Private properties
    
    private enum Constants {
        
    }
    
    private var analytics: AnalyticsModel?
    
    private let interactor: AnalyticsInteractorInput
    private let assemblyFactory = AssemblyFactoryImpl.shared

    // MARK: - Init

    init(interactor: AnalyticsInteractorInput) {
        self.interactor = interactor
        setAnalytics()
    }
    
    // MARK: - Private functions

    private func generateColors(data: inout AnalyticsModel) {
        for i in 0..<data.projects.count {
            data.projects[i].color = UIColor.customColors[i % UIColor.customColors.count]
        }
    }
}

extension AnalyticsPresenter: AnalyticsViewOutput {
    func setAnalytics() {
        interactor.getAnalytics { [weak self] data in
            guard var data = data else {
                return
            }
            self?.generateColors(data: &data)
            DispatchQueue.main.async {
                self?.view?.configureChart(data: data.projects)
                self?.view?.configureTableView(data: data.projects)
            }
        }
    }
}

extension AnalyticsPresenter: AnalyticsInteractorOutput {
    
}

