//
//  ActionsPresenter.swift
//  timetracker
//
//  Created by Polina Egorova on 14.03.2024.
//

final class ActionsPresenter {
    
    weak var view: ActionsViewInput?

    // MARK: - Private properties

    private let interactor: ActionsInteractorInput

    // MARK: - Init

    init(interactor: ActionsInteractorInput) {
        self.interactor = interactor
    }
}

extension ActionsPresenter: ActionsViewOutput {
    func setActionsCount() {
        interactor.getActionsCount()
    }

    func actionsWithProjects(index: Int) -> ActionProject? {
        return interactor.getAction(index: index)
    }
}

extension ActionsPresenter: ActionsInteractorOutput {
    func didGetActionsCount(actionsCount: Int) {
        view?.didGetActionsCount(actionsCount: actionsCount)
    }
}

extension ActionsPresenter: ActionsModuleInput {
}
