//
//  TimerPresenter.swift
//  timetracker
//
//  Created by Polina Egorova on 12.03.2024.
//

final class TimerPresenter {

    weak var view: TimerViewInput?

    // MARK: - Private properties

    private let assemblyFactory = AssemblyFactoryImpl.shared

    // MARK: - Init

    init() { }
}

extension TimerPresenter: TimerViewOutput {
    func didTapOpenActions() {
        view?.present(module: assemblyFactory.actionsModuleAssembly().module().view)
    }
}
