//
//  restoranModel.swift
//  remitApp_main
//
//  Created by Егор Голубев on 01.11.2025.
//

import Foundation
import UIKit

struct menuResponse {
    var yesterdaysMenu: [menuItemResponseSheme]
    var todayMenu: [menuItemResponseSheme]
    var tomorrowMenu: [menuItemResponseSheme]
}

enum menuDate: Int {
    case yesterday = 1
    case today = 2
    case tomorrow = 3
}

final class restoranModel {
    
    private let realm = realmManager()
    private let networkManager = NetworkManager.shared
    
    func loadDataMenu(completion: @escaping (menuRestoranResponseSheme) -> Void) {
        
#if DEBUG
        let urlString = roadServer.testRoadWorkApp.rawValue
#else
        let urlString = roadServer.prodRoadWorkApp.rawValue
#endif
        
        let UUID1C = realm.fetchUUID1C()
        
        let requestData = uneversalRequestScheme(UUIDUser: UUID1C, methodName: "menuRestoranRemit")
        
        let menu1C = menuRestoranResponseSheme(result: false, error: "", UUIDUser: UUID1C)
        
        // Пользователь не авторизован — возвращаем заглушку с текстом, иначе вызывающий не получит ответ
        guard !UUID1C.isEmpty else {
            completion(menuRestoranResponseSheme(result: false,
                                                 error: "Для отображения данных, необходимо авторизироваться в приложении",
                                                 UUIDUser: ""))
            return
        }
        
        guard let jsonRequest = try? JSONEncoder().encode(requestData) else {
            let config = ConfigAlert(title: "Ошибка", message: "Не удалось закодировать запрос!", type: .alert, actions: [])
            CustomAlert().showAlert(config: config)
            completion(menu1C)
            return
        }
        
        guard let url = URL(string: urlString) else {
            let config = ConfigAlert(title: "Ошибка", message: "Некорректный URL!", type: .alert, actions: [])
            CustomAlert().showAlert(config: config)
            completion(menu1C)
            return
        }
        
        networkManager.universalRequstPost(jsonRequest: jsonRequest, url: url) { result in
            switch result {
            case .success(let (statusCode, data)):
                if let data = data {
                    if statusCode != 200 {
                        if let responseString = String(data: data, encoding: .utf8) {
                            let decoder = JSONDecoder()
                            do {
                                let errorResponse = try decoder.decode(errorResponceScheme.self, from: data)
                                let config = ConfigAlert(title: "Ошибка", message: errorResponse.error, type: .alert, actions: [])
                                CustomAlert().showAlert(config: config)
                                completion(menu1C)
                            } catch {
                                let config = ConfigAlert(title: "Ошибка", message: responseString, type: .alert, actions: [])
                                CustomAlert().showAlert(config: config)
                                completion(menu1C)
                            }
                        } else {
                            let config = ConfigAlert(title: "Ошибка", message: "Не удалось преобразовать данные в строку.", type: .alert, actions: [])
                            CustomAlert().showAlert(config: config)
                            completion(menu1C)
                        }
                    } else {
                        do {
                            let decoder = CustomDecoder().getCustomDecoder()
                            let data1C = try decoder.decode(menuRestoranResponseSheme.self, from: data)
                            
                            if !data1C.result {
                                let config = ConfigAlert(title: "Ошибка", message: data1C.error, type: .alert, actions: [])
                                CustomAlert().showAlert(config: config)
                                completion(menu1C)
                            } else {
                                completion(data1C)
                            }
                        } catch {
                            let config = ConfigAlert(title: "Ошибка", message: error.localizedDescription, type: .alert, actions: [])
                            CustomAlert().showAlert(config: config)
                            completion(menu1C)
                        }
                    }
                } else {
                    // Пустое тело ответа: без этой ветки completion не вызывался и экран оставался заблокированным
                    let config = ConfigAlert(title: "Ошибка", message: "Сервер вернул пустой ответ (код \(statusCode))", type: .alert, actions: [])
                    CustomAlert().showAlert(config: config)
                    completion(menu1C)
                }

            case .failure(let error):
                let config = ConfigAlert(title: "Ошибка", message: error.localizedDescription, type: .alert, actions: [])
                CustomAlert().showAlert(config: config)
                completion(menu1C)
            }
        }
    }
    
}
