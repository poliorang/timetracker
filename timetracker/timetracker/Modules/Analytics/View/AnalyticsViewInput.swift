//
//  AnalyticsViewInput.swift
//  timetracker
//
//  Created by Polina Egorova on 12.03.2024.
//

protocol AnalyticsViewInput: AnyObject {
    func configureChart(data: [ProjectModel])
    
    func configureTableView(data: [ProjectModel])
}
