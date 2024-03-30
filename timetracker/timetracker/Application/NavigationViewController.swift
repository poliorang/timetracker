//
//  NavigationViewController.swift
//  timetracker
//
//  Created by Polina Egorova on 03.03.2024.
//

import UIKit

class NavigationViewController: UITabBarController {
    
    private let assemblyFactory = AssemblyFactoryImpl.shared

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupViewControllers()
        setTabBarAppearance()
    }

    private func setupViewControllers() {
        viewControllers = [createNavigationsController(for: assemblyFactory.analyticsModuleAssembly().module().view,
                                                       title: NSLocalizedString("analytics", comment: ""),
                                                       image: UIImage(systemName: "chart.xyaxis.line")!),
                           createNavigationsController(for: assemblyFactory.timerModuleAssembly().module().view,
                                                       title: NSLocalizedString("timer", comment: ""),
                                                       image: UIImage(systemName: "hourglass.bottomhalf.filled")!),
                           createNavigationsController(for: assemblyFactory.goalsModuleAssembly().module().view,
                                                       title: NSLocalizedString("goals", comment: ""),
                                                       image: UIImage(systemName: "pin.fill")!)]
        self.selectedViewController = viewControllers?[1]
    }

    private func createNavigationsController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image

        return navigationController
    }

    private func setTabBarAppearance() {
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
        tabBar.layer.borderWidth = 0.5
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.backgroundColor = .white
    }
}
