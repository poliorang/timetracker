//
//  AnalyticsInteractorInput.swift
//  timetracker
//
//  Created by Polina Egorova on 29.03.2024.
//

protocol AnalyticsInteractorInput: AnyObject {
    func getAnalytics(id: Int?, completion: @escaping ([AnalyticModel]) -> Void)
}
