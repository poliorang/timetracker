//
//  Requests.swift
//  timetracker
//
//  Created Polina Egorova on 21.03.2024.
//

import Foundation

enum GetRequestArgs {
    case action
    case project
    
    var request: String {
        switch self {
        case .action:
            return "me/entries"
        case .project:
            return "me/projects"
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
