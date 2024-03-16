//
//  ActionsPresenter.swift
//  timetracker
//
//  Created by Поли Оранж on 14.03.2024.
//

final class ActionsPresenter {
    
    weak var view: ActionsViewInput?

    // MARK: - Private properties

    private var actionSelectHandler: ((String?) -> Void)?
    private let interactor: ActionsInteractorInput

    // MARK: - Init

    init(interactor: ActionsInteractorInput) {
        self.interactor = interactor
    }
}

extension ActionsPresenter: ActionsViewOutput {
    func actionsCount() -> Int {
        return interactor.getActionsCount()
    }

    func actions() -> [String] {
        return interactor.getActions()
    }
}

extension ActionsPresenter: ActionsInteractorOutput {

}

extension ActionsPresenter: ActionsModuleInput {
}
