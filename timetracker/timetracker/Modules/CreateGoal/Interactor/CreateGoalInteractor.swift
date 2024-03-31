//
//  CreateGoalInteractor.swift
//  timetracker
//
//  Created by Polina Egorova on 31.03.2024.
//

import Foundation

final class CreateGoalInteractor {

    weak var output: CreateGoalInteractorOutput?
    
    private let service = ServiceImpl.shared
}

extension CreateGoalInteractor: CreateGoalInteractorInput {
//    func getGoals(id: Int, completion: @escaping ([GoalModel]) -> Void) {
//        Task {
//            guard let data = await service.getDataFromServer(type: .goals(id), queryItem: nil) else {
//                print("Failed | get goals")
//                completion([])
//                return
//            }
//            
//            var goals = [GoalModel]()
//            do {
//                goals = try JSONDecoder().decode([GoalModel].self, from: data)
//            } catch {
//                print("Failed | decode goals")
//            }
//            
//            completion(goals)
//        }
//    }
//    
    func getProjects(completion: @escaping ([ProjectModel]) -> Void) {
        Task {
            guard let data = await service.getDataFromServer(type: .project, queryItem: nil) else {
                print("Failed | get projects")
                completion([])
                return
            }
            
            var projects = [ProjectModel]()
            do {
                projects = try JSONDecoder().decode([ProjectModel].self, from: data)
            } catch {
                print("Failed | decode projects")
            }

            completion(projects)
        }
    }
    
    func postGoal(goal: PostGoalModel, completion: @escaping (Int?) -> Void) {
        Task {
            print(goal)
            guard let data = await service.postDataToServer(object: goal, type: .goal) else {
                print("Failed | post goal")
                completion(nil)
                return
            }
            
            let response = try JSONDecoder().decode(IDModel.self, from: data)
            completion(response.id)
        }
    }
    
    func postProject(project: PostProjectModel,
                     completion: @escaping (Int?) -> Void) {
        Task {
            guard let data = await service.postDataToServer(object: project, type: .project) else {
                print("Failed | post project")
                completion(nil)
                return
            }
            
            let response = try JSONDecoder().decode(IDModel.self, from: data)
            completion(response.id)
        }
    }
}


