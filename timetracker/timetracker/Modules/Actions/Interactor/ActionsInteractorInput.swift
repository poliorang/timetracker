//
//  ActionsInteractorInput.swift
//  timetracker
//
//  Created by Polina Egorova on 15.03.2024.
//

protocol ActionsInteractorInput: AnyObject {
    func getActionsCount()
    
    func getAction(index: Int) -> ActionProject?
}
