//
//  ActionsViewOutput.swift
//  timetracker
//
//  Created by Поли Оранж on 14.03.2024.
//

protocol ActionsViewOutput: AnyObject {
    func actionsCount() -> Int
    
    func actions() -> [String]
}

