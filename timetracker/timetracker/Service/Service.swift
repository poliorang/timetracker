//
//  Service.swift
//  timetracker
//
//  Created by Polina Egorova on 19.03.2024.
//

import Foundation

protocol Service: AnyObject {
    func getDataFromServer(type: GetRequestArgs) async -> Data?
    
    func postDataToServer(object: Encodable, type: PostRequestArgs) async -> Data?
}
