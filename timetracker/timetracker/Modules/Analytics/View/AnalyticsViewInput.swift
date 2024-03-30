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
    
    func present(module: UIViewController)
}
