//
//  Project.swift
//  timetracker
//
//  Created by Polina Egorova on 19.03.2024.
//

struct ProjectModel: Decodable {
    var id: Int
    var name: String
}

struct PostProjectModel: Encodable {
    var name: String
}
