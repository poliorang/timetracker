//
//  Service.swift
//  timetracker
//
//  Created by Polina Egorova on 16.03.2024.
//

final class ServiceImpl {

    static let shared = ServiceImpl()
    
    var data: [Project : Set<Action>] = [
        "work" : ["solve problems on the leetcode", "create UI"],
        "life" : ["food"],
        "fitness" : ["run for 15 min / day"],
        "read" : ["Stephen Hawking, A Brief History Of Time"]
    ]
    
    // MARK: - Private properties
    
    
    
    // MARK: - Init

    private init() {
        
    }
}
