//
//  Int+Seconds.swift
//  timetracker
//
//  Created by Polina Egorova on 31.03.2024.
//

extension Int {
    func wordsStringFromSeconds() -> String {
        var seconds = self
        let days = seconds / (24 * 60 * 60)
        seconds %= 24 * 60 * 60
        let hours = seconds / (60 * 60)
        seconds %= 60 * 60
        let minutes = seconds / 60
        seconds %= 60
        
        var components: [String] = []
        if days > 0 {
            components.append("\(days) day\(days == 1 ? "" : "s")")
        }
        if hours > 0 {
            components.append("\(hours) hour\(hours == 1 ? "" : "s")")
        }
        if minutes > 0 {
            components.append("\(minutes) minute\(minutes == 1 ? "" : "s")")
        }
        if seconds > 0 {
            components.append("\(seconds) second\(seconds == 1 ? "" : "s")")
        }
        
        return components.joined(separator: ", ")
    }
}

extension Int {
    func clockFaceStringFromSeconds() -> String {
        if self <= 0 {
            return String(format: "%02d:%02d:%02d", 0, 0, 0)
        }
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        let seconds = (self % 3600) % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
