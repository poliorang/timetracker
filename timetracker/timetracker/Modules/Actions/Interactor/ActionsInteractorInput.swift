//
//  ActionsInteractorInput.swift
//  timetracker
//
//  Created by Поли Оранж on 15.03.2024.
//

protocol ActionsInteractorInput: AnyObject {
    func getActionsCount() -> Int
    
    func getActions() -> [String]
}
