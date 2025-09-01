//
//  AppCoordinator.swift
//  remitApp_main
//
//  Created by Егор Голубев on 17.06.2025.
//

import Foundation
import UIKit

final class AppCoordinator {
    
    private var window: UIWindow?
    private let navigationController: UINavigationController
    private var loginCoordinator: LoginCoordinator?
    private var mainCoordinator: MainCoordinator?

    init(window: UIWindow?) {
        self.window = window
        navigationController = UINavigationController()
    }

    func start() {
        let launchVC = LaunchScreenVC()
        launchVC.coordinator = self
        window?.rootViewController = launchVC
        window?.makeKeyAndVisible()
    }

    func showLoginVC() {
        loginCoordinator = LoginCoordinator(navigationController: navigationController, appCoordinator: self)
        loginCoordinator?.start()
        window?.rootViewController = navigationController
    }

    func showHomeScreenVC() {
        mainCoordinator = MainCoordinator(navigationController: navigationController, appCoordinator: self)
        mainCoordinator?.start()
        window?.rootViewController = navigationController
    }
}



