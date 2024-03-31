//
//  AnalyticsInteractorInput.swift
//  timetracker
//
//  Created by Polina Egorova on 29.03.2024.
//

protocol AnalyticsInteractorInput: AnyObject {
    func getAnalytics(analyticsParams: AnalyticsParams?, completion: @escaping ([AnalyticModel]) -> Void)
}
