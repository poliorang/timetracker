//
//  AnalyticsInteractorInput.swift
//  timetracker
//
//  Created by Polina Egorova on 29.03.2024.
//

protocol AnalyticsInteractorInput: AnyObject {
    func getAnalytics(completion: @escaping (AnalyticsModel?) -> Void)
}
