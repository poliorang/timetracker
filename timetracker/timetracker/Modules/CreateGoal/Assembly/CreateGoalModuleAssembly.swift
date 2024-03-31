//
//  CreateGoalModuleAssembly.swift
//  timetracker
//
//  Created by Polina Egorova on 31.03.2024.
//

import UIKit

final class CreateGoalModuleAssembly {

    func module() -> (view: UIViewController, presenter: CreateGoalPresenter) {
        let interactor = CreateGoalInteractor()
        
        let presenter = CreateGoalPresenter(interactor: interactor)
        
        let controller = CreateGoalViewController(output: presenter)
        
        presenter.view = controller
        interactor.output = presenter

        return (
            view: controller,
            presenter: presenter
        )
    }
}
