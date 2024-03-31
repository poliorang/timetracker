//
//  CreateGoalViewOutput.swift
//  timetracker
//
//  Created by Polina Egorova on 31.03.2024.
//

protocol CreateGoalViewOutput: AnyObject {
    func setProjects()
    
    func createGoal(description: String?,
                    project: String?,
                    durationTime: String?,
                    durationValue: String?,
                    startDate: String?,
                    finishDate: String?)
}
