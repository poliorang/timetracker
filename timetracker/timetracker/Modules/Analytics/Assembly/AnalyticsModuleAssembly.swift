//
//  AnalyticsModuleAssembly.swift
//  timetracker
//
//  Created by Polina Egorova on 12.03.2024.
//

import UIKit

final class AnalyticsModuleAssembly {

    func module() -> (view: UIViewController, presenter: AnalyticsPresenter) {
        let interactor = AnalyticsInteractor()
        
        let presenter = AnalyticsPresenter(interactor: interactor)
        
        let tableViewDataSource = AnalyticsTableViewDataSourceImpl()
        
        let controller = AnalyticsViewController(
            output: presenter,
            tableViewDataSource: tableViewDataSource
        )
        
        presenter.view = controller
        
        return (
            view: controller,
            presenter: presenter
        )
    }
}
