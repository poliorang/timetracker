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
    
    func getActionsCount() {
        getActions { actions in
            self.output?.didGetActionsCount(actionsCount: actions.count)
        }
    }
    
    func getAction(index: Int) -> ActionProject? {
        var sum = -1
        for (key, val) in service.data {
            sum += val.count
            if sum < index { continue }
            sum -= val.count
            for value in val {
                sum += 1
                if sum == index {
                    return (value, key)
                }
            }
        }
        return nil
    }
}
