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
    
    func openChildVC(typeVC: ButtonName, userRealm: InformationUserRealm?, completion: @escaping () -> Void) {
        
        var nextVC: UIViewController?
        
        switch typeVC {
        case .vacation:
            nextVC = VacationVC()
        case .question:
            nextVC = ChatViewController()
        case .bus:
            nextVC = transortVC()
        case .calendar:

            if userRealm != nil {
                let salaryModelInstance = salaryModel()
                salaryModelInstance.getSalaryData { salaryData in
                        nextVC = salaryVC(salaryData: salaryData)
                        self.navigationController.pushViewController(nextVC ?? pageDevelopmentVC(), animated: true)
                        completion()
                    }
                }
             else {
                nextVC = salaryVC(salaryData: salaryResponceScheme(actionName: "", additionsSalaryLastMonths: totalValueMonth(incentives: 0, mentoring: 0, deductions: 0, brigadiers: 0, hoursWorked: 0, totalPayment: 0), additionsSalaryCurrentMonths: totalValueMonth(incentives: 0, mentoring: 0, deductions: 0, brigadiers: 0, hoursWorked: 0, totalPayment: 0), LastMonthsSalary: [], CurrentMonthsSalary: []))
            }
            
        case .setting:
            nextVC = settingVC()
        case .competence:
            nextVC = competencyListVC()
        case .franchise:
            
            if userRealm != nil {
                let loyalityModelInstance = loyalityModel()
                loyalityModelInstance.getLoyalityData(updateCheck: false) { infoloyality in
                    if !infoloyality.result {
                        CustomAlert().showFastAlertError(textError: infoloyality.error)
                    } else {
                        nextVC = loyalityVC(info: infoloyality, user: userRealm, coordinator: self)
                        self.navigationController.pushViewController(nextVC ?? pageDevelopmentVC(), animated: true)
                    }
                    completion()
                }
            } else {
                nextVC = loyalityVC(info: loyalityDataResponceScheme(result: false, error: "Для отображения данных, необходимо авторизироваться в приложении", UUIDUser: "", discountСard: "", ownerName: "", balanceLikes: 0, balanceLikesRub: 0, ShoppingList: []), user: nil, coordinator: self)
            }
            
        case .food:

            if userRealm != nil {
                let restoranModelInstance = restoranModel()
                restoranModelInstance.loadDataMenu { menu1C in
                    if !menu1C.result {
                        CustomAlert().showFastAlertError(textError: menu1C.error)
                    } else {
                        nextVC = restoranVC(menu1С: menu1C)
                        self.navigationController.pushViewController(nextVC ?? pageDevelopmentVC(), animated: true)
                    }
                    completion()
                }
            } else {
                nextVC = restoranVC(menu1С: menuRestoranResponseSheme(result: false, error: "Для отображения данных, необходимо авторизироваться в приложении", UUIDUser: ""))
            }
            
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                completion()
            }
            
        }
        
        
        
    }
    
    func openProductDetails(dataCell: dataCheck) {
        let nextVC = checkVC(dataCheck: dataCell)
        navigationController.present(nextVC , animated: true, completion: nil)
        //navigationController.pushViewController(nextVC, animated: true)
    }
    
    func openBarcodeFullScreen(barcodeImg: UIImage, originalBreght: CGFloat) {
        let nextVC = barcodeVC(bacrodeCard: barcodeImg, originalBrightness: originalBreght)
        nextVC.modalPresentationStyle = .fullScreen
        navigationController.present(nextVC , animated: true)
    }
    
}
