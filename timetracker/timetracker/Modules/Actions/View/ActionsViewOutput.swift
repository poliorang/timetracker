//
//  ActionsViewOutput.swift
//  timetracker
//
//  Created by Polina Egorova on 14.03.2024.
//

protocol ActionsViewOutput: AnyObject {
    func actionsCount() -> Int
    
    func actionsWithProjects(index: Int) -> ActionProject?
}

