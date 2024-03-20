//
//  TimerViewOutput.swift
//  timetracker
//
//  Created by Polina Egorova on 12.03.2024.
//

protocol TimerViewOutput: AnyObject {
    func didTapOpenActions()
    
    func сreateAction(action: Action, project: Project)
    
    func setProjects()
    
    func didStartTime()
    
    func didStopTime()
}
