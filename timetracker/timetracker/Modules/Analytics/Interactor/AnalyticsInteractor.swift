//
//  AnalyticsInteractor.swift
//  timetracker
//
//  Created by Polina Egorova on 29.03.2024.
//

import Foundation

struct AnalyticsParams {
    let id: Int?
    let startDate: Date
    let finishDate: Date
}

final class AnalyticsInteractor {

    weak var output: AnalyticsInteractorOutput?
    
    private let service = ServiceImpl.shared
}

extension AnalyticsInteractor: AnalyticsInteractorInput {
    func getAnalytics(analyticsParams: AnalyticsParams?, completion: @escaping ([AnalyticModel]) -> Void) {
        Task {
            let requestType: GetRequestArgs = analyticsParams?.id == nil
                        ? .statistics
                        : .detailStatistics(analyticsParams!.id!)

            guard let data = await service.getDataFromServer(type: requestType, queryItem: analyticsParams) else {
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
                case .detailStatistics(analyticsParams?.id):
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
