//
//  ActionsInteractorOutput.swift
//  timetracker
//
//  Created by Polina Egorova on 15.03.2024.
//

protocol ActionsInteractorOutput: AnyObject {
    func didGetActions(actions: [ActionModel])
}
