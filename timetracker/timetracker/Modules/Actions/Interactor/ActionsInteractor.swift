//
//  ActionsInteractor.swift
//  timetracker
//
//  Created by Polina Egorova on 15.03.2024.
//

final class ActionsInteractor {
    var data: [Project : [Action]] = [
        "work" : ["solve problems on the leetcode", "create UI"],
        "life" : ["food"],
        "fitness" : ["run for 15 min / day"],
        "read" : ["Stephen Hawking, A Brief History Of Time"]
    ]
    weak var output: ActionsInteractorOutput?
}

extension ActionsInteractor: ActionsInteractorInput {
    func getActionsCount() -> Int {
        var actionsCount = 0
        for (_, val) in data {
            actionsCount += val.count
        }
        
        return actionsCount
    }
    
    func getAction(index: Int) -> ActionProject? {
        var sum = -1
        for (key, val) in data {
            sum += val.count
            if sum < index { continue }
            sum -= val.count
            for i in 0..<val.count {
                sum += 1
                if sum == index {
                    return (val[i], key)
                }
            }
        }
        return nil
    }
}
