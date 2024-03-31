//
//  CreateGoalViewInput.swift
//  timetracker
//
//  Created by Polina Egorova on 31.03.2024.
//

import UIKit

protocol CreateGoalViewInput: AnyObject {
    func didGetProjects(projectNames: [Project])
}
