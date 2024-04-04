//
//  String+Seconds.swift
//  timetracker
//
//  Created by Поли Оранж on 01.04.2024.
//

extension String {
    func timeIntervalInSeconds() -> Int? {
        let components = self.components(separatedBy: " ")
        guard components.count == 2, let value = Int(components[0]) else {
            return nil
        }
        
        let unit = components[1]
        var multiplier = 1
        
        switch unit {
        case "second", "seconds":
            multiplier = 1
        case "minute", "minutes":
            multiplier = 60
        case "hour", "hours":
            multiplier = 3600
        case "day", "days":
            multiplier = 86400
        default:
            return nil
        }
        
        return value * multiplier
    }
}

