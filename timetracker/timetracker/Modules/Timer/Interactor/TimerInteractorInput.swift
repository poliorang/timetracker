//
//  TimerInteractorInput.swift
//  timetracker
//
//  Created by Polina Egorova on 16.03.2024.
//

protocol TimerInteractorInput: AnyObject {
    func getProjects() -> [String]
    
    func сreateAction(action: Action, project: Project)
}
