//
//  AnalyticsViewOutput.swift
//  timetracker
//
//  Created by Polina Egorova on 12.03.2024.
//

protocol AnalyticsViewOutput: AnyObject {
    func setAnalytics()
    
    func openDetailAnalytics(id: Int, projectName: String)
    
    func setDatesAndAnalytics(start: String, finish: String) 
}
