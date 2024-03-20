//
//  TimerInteractorInput.swift
//  timetracker
//
//  Created by Polina Egorova on 16.03.2024.
//

protocol TimerInteractorInput: AnyObject {
    func getProjects(completion: @escaping ([Project]) -> Void)
    
    func getActions(completion: @escaping ([ActionModel]) -> Void)
    
    func сreateAction(action: Action, project: Project)
}
