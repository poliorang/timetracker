//
//  Service.swift
//  timetracker
//
//  Created by Polina Egorova on 19.03.2024.
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

protocol Service: AnyObject {
    func getDataFromServer(type: GetRequestArgs) async throws -> Data?
}
