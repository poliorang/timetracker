//
//  CreateGoalInteractorInput.swift
//  timetracker
//
//  Created by Polina Egorova on 31.03.2024.
//

protocol CreateGoalInteractorInput: AnyObject {
    func getProjects(completion: @escaping ([ProjectModel]) -> Void)
    
    func postGoal(goal: PostGoalModel, completion: @escaping (Int?) -> Void)
    
    func postProject(project: PostProjectModel, completion: @escaping (Int?) -> Void)
}
