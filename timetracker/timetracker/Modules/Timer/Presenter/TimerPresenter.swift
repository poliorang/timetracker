//
//  TimerPresenter.swift
//  timetracker
//
//  Created by Polina Egorova on 12.03.2024.
//

import UIKit

final class TimerPresenter {

    weak var view: TimerViewInput?

    // MARK: - Private properties
    private enum Constants {
        static let timeLabelFormat: String = "%02d:%02d:%02d"
    }
    
    private var projects = [ProjectModel]()

    private var seconds = 0
    private var timer: Timer?
    private var timeStart: String?
    private var timeEnd: String?
    
    private let interactor: TimerInteractorInput
    private let assemblyFactory = AssemblyFactoryImpl.shared

    // MARK: - Init

    init(interactor: TimerInteractorInput) {
        self.interactor = interactor
    }
    
    @objc private func didUpdateTime() {
        seconds += 1
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let secs = seconds % 60

        view?.updateTime(time: String(format: Constants.timeLabelFormat, hours, minutes, secs))
    }
}

extension TimerPresenter: TimerViewOutput {
    
    func didTapOpenActions() {
        view?.present(module: assemblyFactory.actionsModuleAssembly().module().view)
    }
    
    func setProjects() {
        interactor.getProjects { projects in
            var projectNames = [Project]()
            for i in 0..<projects.count {
                projectNames.append(projects[i].name)
            }
            self.view?.didGetProjects(projectNames: projectNames)
            self.projects = projects
        }
    }
    
    func didStartTime() {
        timeStart = Date().toString()
        view?.updateTime(time: String(format: Constants.timeLabelFormat, 0, 0, 0))
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                          target: self,
                                          selector: #selector(didUpdateTime),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    func didStopTime() {
        timeEnd = Date().toString()
        timer?.invalidate()
        seconds = 0
    }
    
    func сreateActionWithProject(action: Action, project: Project) {
        getProjectID(action: action, project: project, 
                     completion: { action, projectId in
            self.сreateAction(action: action, projectID: projectId)
        })
    }
    
    private func сreateAction(action: Action, projectID: Int?) {
        guard let projectID = projectID,
              let timeStart = timeStart,
              let timeEnd = timeEnd else {
            print("Failed | get timeStart, timeEnd, projectID")
            return
        }

        let newAction = PostActionModel(name: action, project_id: projectID, time_end: timeEnd, time_start: timeStart)
        interactor.postAction(action: newAction, completion: { _ in
            self.timeEnd = nil
            self.timeStart = nil
        })
    }
    
    private func getProjectID(action: Action,
                      project: Project,
                      completion: @escaping (Action, Int?) -> Void) {
        // if the project already exists
        for i in 0..<projects.count {
            if projects[i].name == project {
                completion(action, projects[i].id)
                return
            }
        }
        
        // if the project does not exist yet
        interactor.postProject(project: PostProjectModel(name: project),
                               completion: { id in
            self.setProjects()
            completion(action, id)
        })
    }
}

extension TimerPresenter: TimerInteractorOutput {
    
}
