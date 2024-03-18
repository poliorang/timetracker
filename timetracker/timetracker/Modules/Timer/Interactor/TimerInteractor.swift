//
//  TimerInteractor.swift
//  timetracker
//
//  Created by Polina Egorova on 16.03.2024.
//

final class TimerInteractor {

    weak var output: TimerInteractorOutput?
    
    private let service = ServiceImpl.shared
}

extension TimerInteractor: TimerInteractorInput {
    func getProjects() -> [String] {
        return Array(service.data.keys)
    }

    func сreateAction(action: Action, project: Project) {
        service.data[project, default: []].insert(action)
        print("action was created")
        output?.updateProject()
    }
}
