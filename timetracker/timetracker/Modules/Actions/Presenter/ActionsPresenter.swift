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
}

extension ActionsPresenter: ActionsInteractorOutput {
    func didGetActions(actions: [ActionModel]) {
        var filteredActions = [ActionModel]()
        for action in actions {
            if filteredActions.firstIndex(where: { $0.name == action.name && $0.project_id == action.project_id } ) == nil {
                filteredActions.append(action)
            }
        }
        view?.didGetActions(actions: filteredActions)
    }
}

extension ActionsPresenter: ActionsModuleInput {
    
}
