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
    func getAnalytics(id: Int?, completion: @escaping ([AnalyticModel]) -> Void) {
        Task {
            let requestType: GetRequestArgs = id == nil ? .statistics : .detailStatistics(id!)

            guard let data = await service.getDataFromServer(type: requestType) else {
                print("Failed | get statistics")
                completion([])
                return
            }
            
            var analytics: [AnalyticModel] = []
            
            do {
                switch requestType {
                case .statistics:
                    let data = try JSONDecoder().decode(AnalyticsProjectsModel.self, from: data)
                    analytics = data.projects
                case .detailStatistics(id):
                    let data = try JSONDecoder().decode(AnalyticsActionsModel.self, from: data)
                    analytics = data.entries
                default:
                    break
                }
            } catch {
                print("Failed | decode statistics")
            }
            
            completion(analytics)
        }
    }
}
