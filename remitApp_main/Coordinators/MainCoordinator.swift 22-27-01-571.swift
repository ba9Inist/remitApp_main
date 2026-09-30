a//
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
        
        var nextVC: UIViewController?
        
        switch typeVC {
        case .vacation:
            nextVC = VacationVC()
        case .question:
            nextVC = ChatViewController()
        case .bus:
            nextVC = transortVC()
        case .calendar:
            nextVC = pageDevelopmentVC()
        case .setting:
            nextVC = settingVC()
        case .competence:
            nextVC = competencyListVC()
        case .franchise:
            nextVC = loyalityVC()
            (nextVC as? loyalityVC)?.coordinator = self
        case .food:
            nextVC = restoranVC()
        case .student:
            nextVC = pageDevelopmentVC()
        case .teacher:
            nextVC = pageDevelopmentVC()
        case .sber:
            nextVC = SberVC()
        case .tonar: break
        }
        
        if nextVC != nil {
            //navigationController.present(nextVC ?? pageDevelopmentVC(), animated: true, completion: nil)
            navigationController.pushViewController(nextVC ?? pageDevelopmentVC(), animated: true)
        }
        
    }
    
    func openProductDetails(dataCell: dataCheck) {
       let nextVC = checkVC(dataCheck: dataCell)
        navigationController.present(nextVC , animated: true, completion: nil)
        //navigationController.pushViewController(nextVC, animated: true)
    }
    
}
