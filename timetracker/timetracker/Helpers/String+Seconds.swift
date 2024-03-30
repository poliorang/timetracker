//
//  String+Seconds.swift
//  timetracker
//
//  Created by Поли Оранж on 30.03.2024.
//

extension String {
    static func timeString(fromSeconds seconds: Int?) -> String {
        guard let seconds = seconds else {
            return String(format: "%02d:%02d:%02d", 0, 0, 0)
        }
        
        let hours = seconds / 3600
        let mins = (seconds % 3600) / 60
        let secs = (seconds % 3600) % 60
        
        return String(format: "%02d:%02d:%02d", hours, mins, secs)
    }
}
