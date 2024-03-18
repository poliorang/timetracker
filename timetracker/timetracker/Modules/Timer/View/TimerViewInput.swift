//
//  TimerViewInput.swift
//  timetracker
//
//  Created by Polina Egorova on 12.03.2024.
//

import UIKit

protocol TimerViewInput: AnyObject {
    func present(module: UIViewController)
    
    func updateProject(projects: [Project])
    
    func updateTime(time: String)
    
//    func didUpdateTime()
}