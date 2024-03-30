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
}

struct PostProjectModel: Codable {
    var name: String?
}
