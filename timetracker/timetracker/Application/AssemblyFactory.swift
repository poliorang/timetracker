//
//  AssemblyFactory.swift
//  timetracker
//
//  Created by Polina Egorova on 14.03.2024.
//

protocol AssemblyFactory {
    
    func timerModuleAssembly() -> TimerModuleAssembly
    
    func goalsModuleAssembly() -> GoalsModuleAssembly
    
    func createGoalModuleAssembly() -> CreateGoalModuleAssembly
    
    func analyticsModuleAssembly() -> AnalyticsModuleAssembly
    
    func detailAnalyticsModuleAssembly() -> AnalyticsModuleAssembly
    
    func actionsModuleAssembly() -> ActionsModuleAssembly
}

final class AssemblyFactoryImpl {

    static let shared = AssemblyFactoryImpl()

    // MARK: - Private properties

    private let _timerModuleAssembly = TimerModuleAssembly()
    private let _goalsModuleAssembly = GoalsModuleAssembly()
    private let _createGoalModuleAssembly = CreateGoalModuleAssembly()
    private let _analyticsModuleAssembly = AnalyticsModuleAssembly()
    private let _detaiAnalyticsModuleAssembly = AnalyticsModuleAssembly()
    private let _actionsModuleAssembly = ActionsModuleAssembly()
    
    // MARK: - Init

    private init() { }
}

extension AssemblyFactoryImpl: AssemblyFactory {
    func timerModuleAssembly() -> TimerModuleAssembly {
        return _timerModuleAssembly
    }
    
    func goalsModuleAssembly() -> GoalsModuleAssembly {
        return _goalsModuleAssembly
    }
    
    func createGoalModuleAssembly() -> CreateGoalModuleAssembly {
        return _createGoalModuleAssembly
    }
    
    func analyticsModuleAssembly() -> AnalyticsModuleAssembly {
        return _analyticsModuleAssembly
    }
    
    func detailAnalyticsModuleAssembly() -> AnalyticsModuleAssembly {
        return _detaiAnalyticsModuleAssembly
    }
    
    func actionsModuleAssembly() -> ActionsModuleAssembly {
        return _actionsModuleAssembly
    }
}
