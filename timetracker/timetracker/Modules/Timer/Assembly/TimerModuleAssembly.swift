//
//  TimerModuleAssembly.swift
//  timetracker
//
//  Created by Polina Egorova on 12.03.2024.
//

import UIKit

final class TimerModuleAssembly: BaseAssembly {

    func module() -> (view: UIViewController, moduleInput: AnyObject) {
//        let interactor = OmgModel()
        
        let presenter = TimerPresenter()//(model: model)

        let controller = TimerViewController(output: presenter)

        presenter.view = controller
//        model.output = presenter

        return (
            view: controller,
            moduleInput: presenter
        )
    }
}
