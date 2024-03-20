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
    func setActions() {
        interactor.getActions()
    }

    func actionsWithProjects(index: Int) -> ActionProject? {
        return interactor.getAction(index: index)
    }
}

extension ActionsPresenter: ActionsInteractorOutput {
    func didGetActions(actions: [ActionModel]) {
        view?.didGetActions(actions: actions)
    }
}

extension ActionsPresenter: ActionsModuleInput {
}
