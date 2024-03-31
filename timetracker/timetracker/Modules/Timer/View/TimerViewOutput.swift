//
//  TimerViewOutput.swift
//  timetracker
//
//  Created by Polina Egorova on 12.03.2024.
//

protocol TimerViewOutput: AnyObject {
    func openActions()
    
    func сreateActionWithProject(action: Action, project: Project)
    
    func setProjects()
    
    func startTime()
    
    func stopTime()
}
