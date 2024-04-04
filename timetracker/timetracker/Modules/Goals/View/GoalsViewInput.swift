//
//  GoalsViewInput.swift
//  timetracker
//
//  Created by Polina Egorova on 12.03.2024.
//

import UIKit

protocol GoalsViewInput: AnyObject {
    func didGetProjects(projectNames: [Project])
    
    func configureTableView(data: [GoalModel])
    
    func present(module: UIViewController)
}
