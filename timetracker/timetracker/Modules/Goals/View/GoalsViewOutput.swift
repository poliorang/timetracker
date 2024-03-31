//
//  GoalsViewOutput.swift
//  timetracker
//
//  Created by Polina Egorova on 12.03.2024.
//

protocol GoalsViewOutput: AnyObject {
    func setProjects()
    
    func setGoalsForProject(projectName: String)
    
    func openCreateGoals()
}
