//
//  GoalsInteractorInput.swift
//  timetracker
//
//  Created by Polina Egorova on 31.03.2024.
//

protocol GoalsInteractorInput: AnyObject {
    func getGoals(id: Int, completion: @escaping ([GoalModel]) -> Void)
    
    func getProjects(completion: @escaping ([ProjectModel]) -> Void)
}
