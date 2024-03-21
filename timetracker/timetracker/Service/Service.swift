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

protocol Service: AnyObject {
    func getDataFromServer(type: GetRequestArgs) async throws -> Data?
    
    func postDataToServer(object: Encodable, type: PostRequestArgs) async -> Data?
}
