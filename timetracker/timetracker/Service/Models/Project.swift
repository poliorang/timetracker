//
//  Project.swift
//  timetracker
//
//  Created by Polina Egorova on 19.03.2024.
//

import UIKit

struct ProjectModel: Codable {
    var id: Int
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

struct PostProjectModel: Codable {
    var name: String?
}
