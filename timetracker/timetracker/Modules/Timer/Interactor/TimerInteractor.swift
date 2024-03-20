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
    func getProjects(completion: @escaping ([Project]) -> Void) {
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

            var projectNames = [Project]()
            for i in 0..<projects.count {
                projectNames.append(projects[i].name)
            }

            completion(projects.map { $0.name })
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

    func сreateAction(action: Action, project: Project) {
        service.data[project, default: []].insert(action)
        print("action was created")
        output?.updateProject()
    }
}
