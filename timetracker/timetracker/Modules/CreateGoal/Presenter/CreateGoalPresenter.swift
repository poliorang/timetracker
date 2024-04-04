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
    
    private let interactor: CreateGoalInteractorInput
    private let assemblyFactory = AssemblyFactoryImpl.shared

    private var projects = [ProjectModel]()
    private var newGoal: PostGoalModel?
    // MARK: - Init

    init(interactor: CreateGoalInteractorInput) {
        self.interactor = interactor
        setProjects()
    }
    
    // MARK: - Private functions
    
    private func getProjectID(project: Project, completion: @escaping (Int?) -> Void) {
        // if the project already exists
        for i in 0..<projects.count {
            if projects[i].name == project {
                completion(projects[i].id)
                return
            }
        }
        
        // if the project does not exist yet
        interactor.postProject(project: PostProjectModel(name: project),
                               completion: { [weak self] id in
            self?.setProjects()
            completion(id)
        })
    }
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
        
    func createGoal(description: String?,
                    project: String?,
                    durationTime: String?,
                    durationValue: String?,
                    startDate: String?,
                    finishDate: String?) {
        guard let description = description, 
                !description.isEmpty else {
            view?.didErrorData(dataType: .description)
            return
        }
        guard let projectName = project,
                !projectName.isEmpty else {
            view?.didErrorData(dataType: .project)
            return
        }
        guard let durationTime = durationTime, !durationTime.isEmpty,
              let durationValue = durationValue,
              let duration = "\(durationTime) \(durationValue)".timeIntervalInSeconds() else {
            view?.didErrorData(dataType: .duration)
            return
        }
        guard let startDateText = startDate,
              !startDateText.isEmpty else {
            view?.didErrorData(dataType: .startDate)
            return
        }
        guard let finishDateText = finishDate,
              !finishDateText.isEmpty else {
            view?.didErrorData(dataType: .finishDate)
            return
        }
        
        if isCorrectDate(start: startDateText, finish: finishDateText) {
            
            getProjectID(project: projectName,
                         completion: { [weak self] projectId in
                
                guard let projectId = projectId,
                let start = startDateText.toDate()?.toString(isFinish: true),
                      let finish = finishDateText.toDate()?.toString(isFinish: false)else { return }
                let newGoal = PostGoalModel(
                    dateEnd: finish,
                    dateStart: start,
                    name: description,
                    projectID: projectId,
                    timeSeconds: duration)
                self?.interactor.postGoal(goal: newGoal, completion: { id in
                    self?.view?.dismiss()
                })
                
            })
        } else {
            view?.didErrorData(dataType: .finishDate)
            view?.didErrorData(dataType: .startDate)
        }
    }
    
    private func isCorrectDate(start: String, finish: String) -> Bool {
        guard let startDate = start.toDate(),
              let finishDate = finish.toDate() else {
            return false
        }
        
        if startDate.isAfter(finishDate) {
            return false
        }
        
        return true
    }
}
