//
//  Date+Format.swift
//  timetracker
//
//  Created by Polina Egorova on 20.03.2024.
//

import Foundation

extension Date {
    func toString(isFinish: Bool?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        /// Если прилетела дата с временем
        guard let isFinish = isFinish else {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            return dateFormatter.string(from: self) + "Z"
        }

        /// Если прилетела дата без времени (начальная - начало дня)
        if isFinish {
            let endOfDay = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: self)!
            return dateFormatter.string(from: endOfDay) + "Z"
        /// Если прилетела дата без времени (конечная - конец дня)
        } else {
            let startOfDay = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
            return dateFormatter.string(from: startOfDay) + "Z"
        }
    }
}

extension Date {
    func isAfter(_ date: Date) -> Bool {
        return self.compare(date) == .orderedDescending
    }
    
    func isBefore(_ date: Date) -> Bool {
        return self.compare(date) == .orderedAscending
    }
    
    func isEqualTo(_ date: Date) -> Bool {
        return self.compare(date) == .orderedSame
    }
}


extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        return dateFormatter.date(from: self)
    }
    
    func toStringDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "dd.MM.yy"
            return dateFormatter.string(from: date)
        }
        
        return nil
    }
}
