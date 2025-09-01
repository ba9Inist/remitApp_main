//
//  LoginCoordinator.swift
//  remitApp_main
//
//  Created by Егор Голубев on 11.06.2025.
//

import Foundation
import UIKit

class LoginCoordinator {
    private let navigationController: UINavigationController
    private let appCoordinator: AppCoordinator 

    init(navigationController: UINavigationController, appCoordinator: AppCoordinator) {
        self.navigationController = navigationController
        self.appCoordinator = appCoordinator
    }

    func start() {
        let loginVC = LoginVC()
        loginVC.coordinator = self
        navigationController.setViewControllers([loginVC], animated: false)
    }

    func showHomeScreenVC() {
        appCoordinator.showHomeScreenVC()
    }
}

