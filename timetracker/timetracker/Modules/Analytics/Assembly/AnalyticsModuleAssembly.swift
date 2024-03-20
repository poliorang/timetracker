//
//  AnalyticsModuleAssembly.swift
//  timetracker
//
//  Created by Polina Egorova on 12.03.2024.
//

import UIKit

protocol BaseAssembly {
    func module() async -> (view: UIViewController, moduleInput: AnyObject)
}

final class AnalyticsModuleAssembly: BaseAssembly {

    func module() -> (view: UIViewController, moduleInput: AnyObject) {
//        let interactor = OmgModel()
        
        let presenter = AnalyticsPresenter()//(model: model)
        
//        let collectionViewDataSource = OmgCollectionViewDataSourceImpl()
        
//        let tableViewDataSource = OmgTableViewDataSourceImpl(collectionViewDataSource: collectionViewDataSource)
        
        let controller = AnalyticsViewController(
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
