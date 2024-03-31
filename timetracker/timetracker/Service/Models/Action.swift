//
//  Action.swift
//  timetracker
//
//  Created by Polina Egorova on 17.03.2024.
//

struct ActionModel: Codable, Hashable {
    var id: Int
    var projectID: Int
    var projectName: String
    var name: String
    var timeStart: String
    var timeEnd: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case projectID = "project_id"
        case projectName = "project_name"
        case name
        case timeStart = "time_start"
        case timeEnd = "time_end"
    }
}

struct PostActionModel: Codable {
    var name: String
    var projectID: Int
    var timeEnd: String
    var timeStart: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case projectID = "project_id"
        case timeEnd = "time_end"
        case timeStart = "time_start"
    }
}
