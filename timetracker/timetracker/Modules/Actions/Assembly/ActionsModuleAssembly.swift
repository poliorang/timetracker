//
//  ActionsModuleAssembly.swift
//  timetracker
//
//  Created by Polina Egorova on 14.03.2024.
//

import UIKit

final class ActionsModuleAssembly {

    func module() -> (view: UIViewController, presenter: ActionsPresenter) {
        let interactor = ActionsInteractor()
        
        let presenter = ActionsPresenter(interactor: interactor)
        
        let tableViewDataSource = ActionsTableViewDataSourceImpl()
        
        let controller = ActionViewController(
            output: presenter,
            tableViewDataSource: tableViewDataSource
        )

        presenter.view = controller
        interactor.output = presenter

        return (
            view: controller,
            presenter: presenter
        )
    }
}
