//
//  Requests.swift
//  timetracker
//
//  Created Polina Egorova on 21.03.2024.
//

import Foundation

struct IDModel: Codable {
    var id: Int
}

enum GetRequestArgs {
    case action
    case project
    case statistics
    case detailStatistics(Int)
    
    var request: String {
        switch self {
        case .action:
            return "me/entries"
        case .project:
            return "me/projects"
        case .statistics:
            return "me/projects/stat"
        case .detailStatistics(let id):
            return "me/projects/\(id)/stat"
        }

    }
}

enum PostRequestArgs {
    case action
    case project
    
    var request: String {
        switch self {
        case .action:
            return "entries/create"
        case .project:
            return "projects/create"
        }
    }
}
