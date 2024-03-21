//
//  TimerInteractor.swift
//  timetracker
//
//  Created by Polina Egorova on 16.03.2024.
//

import Foundation

final class TimerInteractor {

    weak var output: TimerInteractorOutput?
    
    private let service = ServiceImpl.shared
}

extension TimerInteractor: TimerInteractorInput {
    func getProjects(completion: @escaping ([ProjectModel]) -> Void) {
        Task {
            guard let data = await service.getDataFromServer(type: .project) else {
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
    
    func getActions(completion: @escaping ([ActionModel]) -> Void) {
        Task {
            guard let data = await service.getDataFromServer(type: .action) else {
                print("Failed | get actions")
                completion([])
                return
            }
            
            var actions = [ActionModel]()
            do {
                actions = try JSONDecoder().decode([ActionModel].self, from: data)
            } catch {
                print("Failed | decode actions")
            }
            
            completion(actions)
        }
    }

    func postAction(action: PostActionModel,
                    completion: @escaping (Int?) -> Void) {
        Task {
            guard let data = await service.postDataToServer(object: action, type: .action) else {
                print("Failed | post action")
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
