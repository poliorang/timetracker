//
//  CreateGoalModuleAssembly.swift
//  timetracker
//
//  Created by Polina Egorova on 31.03.2024.
//

import UIKit

final class CreateGoalModuleAssembly {

    func module() -> (view: UIViewController, presenter: AnyObject) {
        let interactor = CreateGoalInteractor()
        
        let presenter = CreateGoalPresenter(interactor: interactor)
        
        let controller = CreateGoalViewController(output: presenter)
        
        presenter.view = controller

        return (
            view: controller,
            presenter: presenter
        )
    }
}
