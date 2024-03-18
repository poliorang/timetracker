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

    private var seconds = 0
    private var timer: Timer?
    
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

        view?.updateTime(time: String(format: "%02d:%02d:%02d", hours, minutes, secs))
    }
}

extension TimerPresenter: TimerViewOutput {
    func сreateAction(action: Action, project: Project) {
        interactor.сreateAction(action: action, project: project)
    }
    
    func didTapOpenActions() {
        view?.present(module: assemblyFactory.actionsModuleAssembly().module().view)
    }
    
    func projects() -> [String] {
        return interactor.getProjects()
    }
    
    func didStartTime() {
        Task {
            await printFetchedData()
        }

        view?.updateTime(time: String(format: "%02d:%02d:%02d", 0, 0, 0))
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                          target: self,
                                          selector: #selector(didUpdateTime),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    func didStopTime() {
        timer?.invalidate()
        seconds = 0
    }
    
    
    
    func fetchDataFromServer() async throws -> Data {
        let url = URL(string: "http://89.208.231.169:8080/me/projects")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }

    func printFetchedData() async {
        do {
            let data = try await fetchDataFromServer()
            if let string = String(data: data, encoding: .utf8) {
                print(string)
            } else {
                print("Failed to convert data to string")
            }
        } catch {
            print("Error fetching data: \(error)")
        }
    }

}

extension TimerPresenter: TimerInteractorOutput {
    func updateProject() {
        view?.updateProject(projects: projects())
    }
}
