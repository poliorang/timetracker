//
//  ActionsInteractor.swift
//  timetracker
//
//  Created by Polina Egorova on 15.03.2024.
//

final class ActionsInteractor {
    private let service = ServiceImpl.shared
    weak var output: ActionsInteractorOutput?
}

extension ActionsInteractor: ActionsInteractorInput {
    func getActionsCount() -> Int {
        var actionsCount = 0
        for (_, val) in service.data {
            actionsCount += val.count
        }
        
        return actionsCount
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
