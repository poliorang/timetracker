//
//  TimerInteractor.swift
//  timetracker
//
//  Created by Polina Egorova on 16.03.2024.
//

final class TimerInteractor {
    var data: [Project : [Action]] = [
        "work" : ["solve problems on the leetcode", "create UI"],
        "life" : ["food"],
        "fitness" : ["run for 15 min / day"],
        "read" : ["Stephen Hawking, A Brief History Of Time"]
    ]
    weak var output: TimerInteractorOutput?
}

extension TimerInteractor: TimerInteractorInput {
    func getProjects() -> [String] {
        return Array(data.keys)
    }
}
