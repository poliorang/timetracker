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
        
//        let collectionViewDataSource = OmgCollectionViewDataSourceImpl()
        
//        let tableViewDataSource = OmgTableViewDataSourceImpl(collectionViewDataSource: collectionViewDataSource)
        
        let controller = TimerViewController(
//            output: presenter,
//            tableViewDataSource: tableViewDataSource
        )

//        presenter.view = controller
//        model.output = presenter

        return (
            view: controller,
            moduleInput: presenter
        )
    }
}
