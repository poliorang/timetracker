//
//  ServiceImpl.swift
//  timetracker
//
//  Created by Polina Egorova on 16.03.2024.
//

import Foundation

final class ServiceImpl: Service {
    
    static let shared = ServiceImpl()
    
    var data: [Project : Set<Action>] = [
        "work" : ["solve problems on the leetcode", "create UI"],
        "life" : ["food"],
        "fitness" : ["run for 15 min / day"],
        "read" : ["Stephen Hawking, A Brief History Of Time"]
    ]
    
    // MARK: - Private properties
    
    private let url = "http://89.208.231.169:8080/"//URL(string: "http://89.208.231.169:8080/")
    
    // MARK: - Init

    private init() { }
    
    // MARK: - Functions
    
    func getDataFromServer(type: GetRequestArgs) async -> Data? {
        let url = URL(string: url + type.request)!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            print("Received data: \(data)")
            return data
        } catch {
            print("Error fetching data: \(error)")
            return nil
        }
    }
    
    func postDataToServer() async {
        let url = URL(string: url)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let project = ProjectModel(id: 1, name: "Project Name")
        
        do {
            let jsonData = try JSONEncoder().encode(project)
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
                
                if let responseData = String(data: data, encoding: .utf8) {
                    print("Response data: \(responseData)")
                }
            }
        } catch {
            print("Error: \(error)")
        }
    }

}
