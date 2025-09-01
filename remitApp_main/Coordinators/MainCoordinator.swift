//
//  MainCoordinator.swift
//  remitApp_main
//
//  Created by Егор Голубев on 17.06.2025.
//

import Foundation
import UIKit

class MainCoordinator {
    private let navigationController: UINavigationController
    private let appCoordinator: AppCoordinator
    
    init(navigationController: UINavigationController, appCoordinator: AppCoordinator) {
        self.navigationController = navigationController
        self.appCoordinator = appCoordinator
    }
    func start() {
        let homeVC = HomeScreenVC()
        homeVC.coordinator = self
        navigationController.setViewControllers([homeVC], animated: true)
    }
    
    func openChildVC(typeVC: ButtonName) {
        
        switch typeVC {
        case .vacation:
            let nextVC = VacationVC()
            navigationController.pushViewController(nextVC, animated: true)
        case .question:
            let nextVC = ChatVC()
            navigationController.pushViewController(nextVC, animated: true)
        case .bus:
            print(1)
        case .calendar:
            print(1)
        case .setting:
            print(1)
        case .competence:
            print(1)
        case .franchise:
            print(1)
        case .food:
            print(1)
        case .student:
            print(1)
        case .teacher:
            print(1)
        case .sber:
            print(1)
        case .tonar:
            print(1)
        }
        
    }
}
