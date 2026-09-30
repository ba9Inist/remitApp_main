//
//  LoginModel.swift
//  remitApp_main
//
//  Created by Егор Голубев on 10.06.2025.
//

import Foundation
import UIKit

final class LoginModel {
    
    private let networkManager = NetworkManager.shared
    private var userID = ""
    private let realm = realmManager()
    
    //Запись лога и формирование кода авторизации в 1С
    
    func generateAnAuthorizationCode(number: String, codeAuth: String, completion: @escaping (Bool) -> Void) {
#if DEBUG
        let urlString = roadServer.testRoadAuthorization.rawValue
#else
        let urlString = roadServer.prodRoadAuthorization.rawValue
#endif
        
        let requestData = authorizationRequestScheme(numberPhone: number, codeAuthorization: codeAuth)
        
        guard let jsonRequest = try? JSONEncoder().encode(requestData) else {
            let config = ConfigAlert(title: "Ошибка", message: "Не удалось закодировать запрос!", type: .alert, actions: [])
            CustomAlert().showAlert(config: config)
            completion(false)
            return
        }
        
        guard let url = URL(string: urlString) else {
            let config = ConfigAlert(title: "Ошибка", message: "Некорректный URL!", type: .alert, actions: [])
            CustomAlert().showAlert(config: config)
            completion(false)
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
                                completion(false)
                            } catch {
                                let config = ConfigAlert(title: "Ошибка", message: responseString, type: .alert, actions: [])
                                CustomAlert().showAlert(config: config)
                                completion(false)
                            }
                        } else {
                            let config = ConfigAlert(title: "Ошибка", message: "Не удалось преобразовать данные в строку.", type: .alert, actions: [])
                            CustomAlert().showAlert(config: config)
                            completion(false)
                        }
                    } else {
                        do {
                            let decoder = JSONDecoder()
                            let data1C = try decoder.decode(authorizationResponeScheme.self, from: data)
                            
                            if !data1C.result {
                                let config = ConfigAlert(title: "Ошибка", message: data1C.error, type: .alert, actions: [])
                                CustomAlert().showAlert(config: config)
                                completion(false)
                            } else {
                                self.userID = data1C.UUIDUser
                                completion(true)
                            }
                        } catch {
                            let config = ConfigAlert(title: "Ошибка", message: error.localizedDescription, type: .alert, actions: [])
                            CustomAlert().showAlert(config: config)
                            completion(false)
                        }
                    }
                } else {
                    // Пустое тело ответа: без этой ветки completion не вызывался и кнопка входа оставалась заблокированной
                    let config = ConfigAlert(title: "Ошибка", message: "Сервер вернул пустой ответ (код \(statusCode))", type: .alert, actions: [])
                    CustomAlert().showAlert(config: config)
                    completion(false)
                }

            case .failure(let error):
                let config = ConfigAlert(title: "Ошибка", message: error.localizedDescription, type: .alert, actions: [])
                CustomAlert().showAlert(config: config)
                completion(false)
            }
        }
    }
    
    //Проверка кода авторизации и запрос информации по пользователю из 1С
    
    func checkCodeAuthorization(number: String, codeApple: String, completion: @escaping (Bool) -> Void) {
#if DEBUG
        let urlString = roadServer.testRoadAuthorization.rawValue
#else
        let urlString = roadServer.prodRoadAuthorization.rawValue
#endif
        
        let checkRequest = checkCodeRequestScheme(numberPhone: number, codeAuthorization: codeApple, UUIDUser: userID)
        
        guard let jsonRequest = try? JSONEncoder().encode(checkRequest) else {
            let config = ConfigAlert(title: "Ошибка", message: "Не удалось закодировать запрос!", type: .alert, actions: [])
            CustomAlert().showAlert(config: config)
            completion(false)
            return
        }
        
        guard let url = URL(string: urlString) else {
            let config = ConfigAlert(title: "Ошибка", message: "Некорректный URL!", type: .alert, actions: [])
            CustomAlert().showAlert(config: config)
            completion(false)
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
                                completion(false)
                            } catch {
                                let config = ConfigAlert(title: "Ошибка", message: responseString, type: .alert, actions: [])
                                CustomAlert().showAlert(config: config)
                                completion(false)
                            }
                        } else {
                            let config = ConfigAlert(title: "Ошибка", message: "Не удалось преобразовать данные в строку.", type: .alert, actions: [])
                            CustomAlert().showAlert(config: config)
                            completion(false)
                        }
                    } else {
                        do {

                            let decoder = CustomDecoder().getCustomDecoder()

                            let data1C = try decoder.decode(informationUserResponeScheme.self, from: data)
                            if !data1C.result {
                                let config = ConfigAlert(title: "Ошибка", message: data1C.error, type: .alert, actions: [])
                                CustomAlert().showAlert(config: config)
                                completion(false)
                            } else {
                                UserDefaults.standard.set( self.userID, forKey: "uuidUser1C")
                                self.realm.addDataUser(userInfo: data1C)
                                completion(true)
                            }
                        } catch {
                            print(error.localizedDescription)
                            let config = ConfigAlert(title: "Ошибка", message: error.localizedDescription, type: .alert, actions: [])
                            CustomAlert().showAlert(config: config)
                            completion(false)
                        }
                    }
                } else {
                    // Пустое тело ответа: без этой ветки completion не вызывался и кнопка входа оставалась заблокированной
                    let config = ConfigAlert(title: "Ошибка", message: "Сервер вернул пустой ответ (код \(statusCode))", type: .alert, actions: [])
                    CustomAlert().showAlert(config: config)
                    completion(false)
                }

            case .failure(let error):
                let config = ConfigAlert(title: "Ошибка", message: error.localizedDescription, type: .alert, actions: [])
                CustomAlert().showAlert(config: config)
                completion(false)
            }
        }
    }
}


