//
//  CreateGoalInteractorInput.swift
//  timetracker
//
//  Created by Polina Egorova on 31.03.2024.
//

protocol CreateGoalInteractorInput: AnyObject {
    func getProjects(completion: @escaping ([ProjectModel]) -> Void)
}
