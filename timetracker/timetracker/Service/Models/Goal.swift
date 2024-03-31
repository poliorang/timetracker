//
//  GoalModel.swift
//  timetracker
//
//  Created by Polina Egorova on 31.03.2024.
//

struct GoalModel: Codable {
    let id: Int
    let projectID: Int
    let userID: Int
    let timeSeconds: Int
    let name: String
    let dateStart: String
    let dateEnd: String
    let durationInSeconds: Int
    let percent: Double
    
    private enum CodingKeys: String, CodingKey {
        case id
        case projectID = "project_id"
        case userID = "user_id"
        case timeSeconds = "time_seconds"
        case name
        case dateStart = "date_start"
        case dateEnd = "date_end"
        case durationInSeconds = "duration_seconds"
        case percent
    }
}

struct PostGoalModel: Codable {
    let dateEnd: String
    let dateStart: String
    let name: String
    let projectID: Int
    let timeSeconds: Int
    
    private enum CodingKeys: String, CodingKey {
        case dateEnd = "date_end"
        case dateStart = "date_start"
        case name
        case projectID = "project_id"
        case timeSeconds = "time_seconds"
    }
}
