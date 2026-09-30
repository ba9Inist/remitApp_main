//
//  CustomAlert.swift
//  remitApp_main
//
//  Created by Егор Голубев on 05.06.2025.
//

import Foundation
import UIKit

struct ConfigAlert {
    let title: String?
    let message: String?
    let type: UIAlertController.Style
    let actions: [UIAlertAction]?
}

final class CustomAlert {
    
    func showFastAlertError(textError: String) {
        let config = ConfigAlert(title: "Ошибка", message: textError, type: .alert, actions: [])
        showAlert(config: config)
    }

    func showAlert(config: ConfigAlert) {
        let alert = UIAlertController(title: config.title, message: config.message, preferredStyle: config.type)

        if let actions = config.actions, !actions.isEmpty {
            actions.forEach { alert.addAction($0) }
        } else {
            alert.addAction(UIAlertAction(title: "OK", style: .default))
        }

        findTopMostViewController()?.present(alert, animated: true, completion: nil)
    }
    
    private func findTopMostViewController() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate,
              let rootViewController = sceneDelegate.window?.rootViewController else {
            return nil
        }
        
        var currentController = rootViewController
        
        while let presentedController = currentController.presentedViewController {
            currentController = presentedController
        }
        
        return currentController
    }
}
