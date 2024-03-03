//
//  NavigationViewController.swift
//  timetracker
//
//  Created by Polina Egorova on 03.03.2024.
//

import UIKit

class NavigationViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupViewControllers()
    }

    func setupViewControllers() {
            viewControllers = [createNavigationsController(for: AnalyticsViewController(),
                                                           title: NSLocalizedString("analytics", comment: ""),
                                                           image: UIImage(systemName: "chart.xyaxis.line")!),
                               createNavigationsController(for: TimerViewController(),
                                                           title: NSLocalizedString("timer", comment: ""),
                                                           image: UIImage(systemName: "hourglass.bottomhalf.filled")!),
                               createNavigationsController(for: GoalsViewController(),
                                                           title: NSLocalizedString("goals", comment: ""),
                                                           image: UIImage(systemName: "pin.fill")!)]

    }

    func createNavigationsController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        
        return navigationController
    }
}
