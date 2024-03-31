//
//  CreateGoalPresenter.swift
//  timetracker
//
//  Created by Polina Egorova on 31.03.2024.
//


import UIKit

final class CreateGoalPresenter {
    
    weak var view: CreateGoalViewInput?
    
    // MARK: - Private properties
    
    private enum Constants {
        
    }
    
    private let interactor: CreateGoalInteractorInput
    private let assemblyFactory = AssemblyFactoryImpl.shared

    private var projects = [ProjectModel]()
    private var goals = [GoalModel]()

    // MARK: - Init

    init(interactor: CreateGoalInteractorInput) {
        self.interactor = interactor
        setProjects()
    }
    
    // MARK: - Private functions

//    private func getGoals(id: Int) {
//        interactor.getGoals(id: id) { [weak self] data in
//            self?.goals = data
//            DispatchQueue.main.async {
//                self?.view?.configureTableView(data: data)
//            }
//        }
//    }
}

extension CreateGoalPresenter: CreateGoalViewOutput {
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
}

extension CreateGoalPresenter: CreateGoalInteractorOutput {
//    func setGoalsForProject(projectName: String) {
//        if let project = projects.first(where: { $0.name == projectName } ) {
//            getGoals(id: project.id)
//        }
//    }
}
