//
//  TimerViewOutput.swift
//  timetracker
//
//  Created by Polina Egorova on 12.03.2024.
//

protocol TimerViewOutput: AnyObject {
    func didTapOpenActions()
    
    func сreateActionWithProject(action: Action, project: Project)
    
//    func сreateAction(action: Action, projectID: Int?)
//    
//    func getProjectID(action: Action,
//                      project: Project,
//                      completion: @escaping (Action, Int?) -> Void)
    
    func setProjects()
    
    func didStartTime()
    
    func didStopTime()
}
