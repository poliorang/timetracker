//
//  AnalyticsViewInput.swift
//  timetracker
//
//  Created by Polina Egorova on 12.03.2024.
//

import UIKit

protocol AnalyticsViewInput: AnyObject {
    func configureChart(data: [AnalyticModel])
    
    func configureTableView(data: [AnalyticModel])
    
    func configureProjectName(_ name: String)
    
    func configureDates(start: String, finish: String)
    
    func present(module: UIViewController)
}
