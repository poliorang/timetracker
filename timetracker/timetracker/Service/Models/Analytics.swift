//
//  Analytics.swift
//  timetracker
//
//  Created by Polina Egorova on 29.03.2024.
//

import UIKit

struct AnalyticsProjectsModel: Codable {
    let totalDuration: Int
    var projects: [AnalyticModel]
    
    private enum CodingKeys: String, CodingKey {
        case totalDuration = "total_duration_in_sec"
        case projects
    }
}

struct AnalyticsActionsModel: Codable {
    let totalDuration: Int
    var entries: [AnalyticModel]
    
    private enum CodingKeys: String, CodingKey {
        case totalDuration = "total_duration_in_sec"
        case entries
    }
}

struct AnalyticModel: Codable {
    var id: Int?
    var name: String
    let durationInSeconds: Int?
    let percentDuration: Double?
    var color: UIColor?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case durationInSeconds = "duration_in_sec"
        case percentDuration = "percent_duration"
    }
}
