//
//  TimerInteractor.swift
//  timetracker
//
//  Created by Polina Egorova on 16.03.2024.
//

final class TimerInteractor {
    var projects: [String] = ["work", "life", "fitness", "read"]
    weak var output: TimerInteractorOutput?
}

extension TimerInteractor: TimerInteractorInput {
    func getProjects() -> [String] {
        return projects
    }
}
