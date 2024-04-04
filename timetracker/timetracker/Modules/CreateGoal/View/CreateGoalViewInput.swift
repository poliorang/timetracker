//
//  CreateGoalViewInput.swift
//  timetracker
//
//  Created by Polina Egorova on 31.03.2024.
//

import UIKit

enum CreateGoalDataType {
    case description
    case project
    case duration
    case startDate
    case finishDate
    
}

protocol CreateGoalViewInput: AnyObject {
    func didGetProjects(projectNames: [Project])
    
    func didErrorData(dataType: CreateGoalDataType)
    
    func dismiss()
}
