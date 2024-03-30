//
//  TimerModuleAssembly.swift
//  timetracker
//
//  Created by Polina Egorova on 12.03.2024.
//

import UIKit

final class TimerModuleAssembly {

    func module() -> (view: UIViewController, moduleInput: AnyObject) {
        let interactor = TimerInteractor()
        
        let presenter = TimerPresenter(interactor: interactor)

        let controller = TimerViewController(output: presenter)

        presenter.view = controller
        interactor.output = presenter

        return (
            view: controller,
            moduleInput: presenter
        )
    }
}
