//
//  AnalyticsInteractor.swift
//  timetracker
//
//  Created by Polina Egorova on 29.03.2024.
//

import Foundation

final class AnalyticsInteractor {

    weak var output: AnalyticsInteractorOutput?
    
    private let service = ServiceImpl.shared
}

extension AnalyticsInteractor: AnalyticsInteractorInput {
    func getAnalytics(completion: @escaping (AnalyticsModel?) -> Void) {
        Task {
            guard let data = await service.getDataFromServer(type: .statistics) else {
                print("Failed | get statistics")
                completion(nil)
                return
            }
            
            var analytics: AnalyticsModel?
            do {
                analytics = try JSONDecoder().decode(AnalyticsModel.self, from: data)
            } catch {
                print("Failed | decode statistics")
            }
            
            completion(analytics)
        }
    }
}
