//
//  Analytics.swift
//  timetracker
//
//  Created by Polina Egorova on 29.03.2024.
//

struct AnalyticsModel: Codable {
    let totalDuration: Int
    var projects: [ProjectModel]
    
    private enum CodingKeys: String, CodingKey {
        case totalDuration = "total_duration_in_sec"
        case projects
    }
}

