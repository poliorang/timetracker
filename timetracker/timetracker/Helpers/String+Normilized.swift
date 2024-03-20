//
//  String+Normilized.swift
//  timetracker
//
//  Created by Polina Egorova on 17.03.2024.
//

extension String {
    var trimmedAndNormalized: String {
        return split(separator: " ").joined(separator: " ")
    }
}
