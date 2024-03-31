//
//  GoalsPresenter.swift
//  timetracker
//
//  Created by Polina Egorova on 12.03.2024.
//

import UIKit

final class GoalsPresenter {
    
    weak var view: GoalsViewInput?
    
    // MARK: - Private properties
    
    private enum Constants {
        
    }
    
    private let interactor: GoalsInteractorInput
    private let assemblyFactory = AssemblyFactoryImpl.shared

    private var projects = [ProjectModel]()
    private var goals = [GoalModel]()
    private var id: Int?

    // MARK: - Init

    init(interactor: GoalsInteractorInput) {
        self.interactor = interactor
    }
    
    // MARK: - Private functions

    private func getGoals(id: Int) {
        interactor.getGoals(id: id) { [weak self] data in
            self?.goals = data
            DispatchQueue.main.async {
                self?.view?.configureTableView(data: data)
            }
        }
    }
}

extension GoalsPresenter: GoalsViewOutput {

    func setProjects() {
        interactor.getProjects { [weak self] projects in
            var projectNames = [Project]()
            for i in 0..<projects.count {
                projectNames.append(projects[i].name)
            }
            self?.view?.didGetProjects(projectNames: projectNames)
            self?.projects = projects
        }
    }
    
    func openCreateGoals() {
        view?.present(module: assemblyFactory.createGoalModuleAssembly().module().view)
    }
}

extension GoalsPresenter: GoalsInteractorOutput {
    func setGoalsForProject(projectName: String) {
        if let project = projects.first(where: { $0.name == projectName } ) {
            id = project.id
            getGoals(id: project.id)
        }
    }
}

extension GoalsPresenter: GoalsModuleInput {

}

