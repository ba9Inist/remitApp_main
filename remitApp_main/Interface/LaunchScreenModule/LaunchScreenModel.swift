//
//  LaunchScreenModel.swift
//  remitApp_main
//
//  Created by Егор Голубев on 11.09.2025.
//

import Foundation
import UIKit

final class LaunchScreenModel {
    
    private let networkManager = NetworkManager.shared
    
    func getHeadImageView(completion: @escaping (Result<UIImage?, Error>) -> Void) {
        #if DEBUG
            let firstUrlString = roadServer.testRoadAuthorization.rawValue
        #else
            let firstUrlString = roadServer.prodRoadAuthorization.rawValue
        #endif

        struct FirstRequestData: Encodable {
            let methodName = "loadSplashScreenImage"
        }

        let firstRequestInstance = FirstRequestData()
        let firstPreparedUrlAndRequest = networkManager.prepareURLRequest(urlString: firstUrlString, requestInstance: firstRequestInstance)

        if let firstUrl = firstPreparedUrlAndRequest.url, let firstJsonRequest = firstPreparedUrlAndRequest.jsonRequest {
            networkManager.universalRequstPost(jsonRequest: firstJsonRequest, url: firstUrl) { firstResult in
                switch firstResult {
                case .success(let (firstStatusCode, firstData)):
                    // Раньше здесь был force unwrap firstData — пустое тело ответа роняло приложение на старте
                    guard let firstData = firstData else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: ["message": "Сервер вернул пустой ответ (код \(firstStatusCode))"])))
                        return
                    }

                    self.networkManager.processingDataHttp(statusHttp: firstStatusCode, dataHttp: firstData, jsonScheme: startImgResponceScheme.self) { (firstResult, firstError) in
                        if let firstResult = firstResult {
                            let urlPhoto1C = firstResult.urlPhoto
                            self.networkManager.setubHeadImageView(urlString: urlPhoto1C) { image in
                                if let image = image {
                                    completion(.success(image))
                                } else {
                                    completion(.failure(NSError(domain: "", code: -1, userInfo: ["message": "Ошибка загрузки изображения"])))
                                }
                            }
                        } else {
                            completion(.failure(NSError(domain: "", code: -1, userInfo: ["message": firstError ?? "Ошибка обработки первого запроса"])))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: ["message": "Ошибка подготовки первого запроса"])))
        }
    }
    
    // Возвращает true, если сохранён UUID пользователя из 1С, то есть вход уже выполнялся.
    // Здесь стоял отладочный `return false`, из-за которого автовход и биометрия никогда
    // не срабатывали: каждый запуск уводил на экран входа.
    func checkAuthorization() -> Bool {
        return UserDefaults.standard.string(forKey: "uuidUser1C")?.isEmpty == false
    }
    
    func createUuidApple() {
        if UserDefaults.standard.object(forKey: "appleIdentificator") == nil {
            let appleIdentificator = UUID().uuidString
            UserDefaults.standard.set(appleIdentificator, forKey: "appleIdentificator")
        }
    }
    
}


