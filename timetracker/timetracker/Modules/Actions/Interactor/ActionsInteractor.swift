//
//  ActionsInteractor.swift
//  timetracker
//
//  Created by Поли Оранж on 15.03.2024.
//

final class ActionsInteractor {
    var actions: [String] = ["solve problems on the leetcode", "create UI for app ", "prepare MCT"]
    weak var output: ActionsInteractorOutput?
}

extension ActionsInteractor: ActionsInteractorInput {
    func getActionsCount() -> Int {
        return actions.count
    }
    
    func getActions() -> [String] {
        return actions
    }
}
