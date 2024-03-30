//
//  ActionsInteractor.swift
//  timetracker
//
//  Created by Polina Egorova on 15.03.2024.
//

import Foundation

final class ActionsInteractor {
    private let service = ServiceImpl.shared
    weak var output: ActionsInteractorOutput?
}

extension ActionsInteractor: ActionsInteractorInput {
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
    
    func getActions() {
        getActions { [weak self] actions in
            self?.output?.didGetActions(actions: actions)
        }
    }
}
