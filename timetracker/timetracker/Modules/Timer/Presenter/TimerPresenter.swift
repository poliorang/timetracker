//
//  TimerPresenter.swift
//  timetracker
//
//  Created by Polina Egorova on 12.03.2024.
//

final class TimerPresenter {

    weak var view: TimerViewInput?

    // MARK: - Private properties

    private let interactor: TimerInteractorInput
    private let assemblyFactory = AssemblyFactoryImpl.shared

    // MARK: - Init

    init(interactor: TimerInteractorInput) {
        self.interactor = interactor
    }
    
}

extension TimerPresenter: TimerViewOutput {
    func didTapOpenActions() {
        view?.present(module: assemblyFactory.actionsModuleAssembly().module().view)
    }
    
    func projects() -> [String] {
        return interactor.getProjects()
    }
}

extension TimerPresenter: TimerInteractorOutput {
    
}
