//
//  TimerInteractorInput.swift
//  timetracker
//
//  Created by Polina Egorova on 16.03.2024.
//

protocol TimerInteractorInput: AnyObject {
    func getProjects(completion: @escaping ([ProjectModel]) -> Void)
    
    func getActions(completion: @escaping ([ActionModel]) -> Void)
    
    func postProject(project: PostProjectModel,
                     completion: @escaping (Int?) -> Void)
    
    func postAction(action: PostActionModel,
                     completion: @escaping (Int?) -> Void)
}
