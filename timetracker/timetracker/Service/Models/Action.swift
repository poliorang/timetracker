//
//  Action.swift
//  timetracker
//
//  Created by Polina Egorova on 17.03.2024.
//

struct ActionModel: Decodable, Hashable {
    var id: Int
    var project_id: Int
    var project_name: String
    var name: String
    var time_start: String
    var time_end: String
}

struct PostActionModel: Encodable {
    var name: String
    var project_id: Int
    var time_end: String
    var time_start: String
}
