//
//  ActionsViewInput.swift
//  timetracker
//
//  Created by Polina Egorova on 14.03.2024.
//

protocol ActionsViewInput: AnyObject {
    func didGetActions(actions: [ActionModel])
}
