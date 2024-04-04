//
//  GoalsModuleAssembly.swift
//  timetracker
//
//  Created by Polina Egorova on 12.03.2024.
//

import UIKit

final class GoalsModuleAssembly {

    func module() -> (view: UIViewController, presenter: AnyObject) {
        let interactor = GoalsInteractor()
        
        let presenter = GoalsPresenter(interactor: interactor)
        
        let tableViewDataSource = GoalsTableViewDataSourceImpl()
        
        let controller = GoalsViewController(
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
