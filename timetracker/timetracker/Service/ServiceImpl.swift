//
//  ServiceImpl.swift
//  timetracker
//
//  Created by Polina Egorova on 16.03.2024.
//

import Foundation

final class ServiceImpl: Service {
    
    static let shared = ServiceImpl()
    
    // MARK: - Private properties
    
    private let url = "http://89.208.231.169:8080/"
    
    // MARK: - Init

    private init() { }
    
    // MARK: - Functions
    
    func getDataFromServer(type: GetRequestArgs, queryItem: AnalyticsParams?) async -> Data? {
        var urlComponents = URLComponents(string: url + type.request)!
        if let queryItem = queryItem {
            urlComponents.queryItems = [
                URLQueryItem(name: "time_start", value: queryItem.startDate.toString(isFinish: false)),
                URLQueryItem(name: "time_end", value: queryItem.finishDate.toString(isFinish: true))
            ]
        }
        
        do {
            guard let url = urlComponents.url else {
                print("Error get url")
                return nil
            }
            print(url)
            let (data, _) = try await URLSession.shared.data(from: url)
            print("Received data: \(data)")
            return data
        } catch {
            print("Error fetching data: \(error)")
            return nil
        }
    }
    
    func postDataToServer(object: Encodable, type: PostRequestArgs) async -> Data? {
        
        let url = URL(string: url + type.request)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        print(url)
        do {
            let jsonData = try JSONEncoder().encode(object)
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
                
                guard let responseData = String(data: data, encoding: .utf8) else {
                    return nil
                }
                print("Response data: \(responseData)")
            }
            return data
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
}
