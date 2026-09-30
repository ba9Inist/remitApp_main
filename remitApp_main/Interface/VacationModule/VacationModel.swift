//
//  VacationModel.swift
//  remitApp_main
//
//  Created by Егор Голубев on 06.06.2025.
//

import Foundation
import UIKit
import RealmSwift

protocol VacationViewDelegate: AnyObject {
    func didSelectDate()
    func didSelectButtonVacation()
    func didSelectButtonDoneKeyboard()
}

struct vacation {
    let startOfVacation: Date
    let endOfVacation: Date
    let pastVacation: Bool
    let days: Int
}

final class VacationModel {
    
    private let realm = realmManager()
    private let networkManager = NetworkManager.shared
    
    func fetchArrayVacations() -> [vacation] {
        guard let userData = realm.fetchUser() else { return [vacation]() }
        
        var arrayVacations = [vacation]()
        
        arrayVacations = userData.vacation.map { item in
            vacation(startOfVacation: item.startOfVacation,
                     endOfVacation: item.endOfVacation,
                     pastVacation: item.pastVacation,
                     days: item.days)
        }
        return arrayVacations
    }
    
        
    func createStatementVacation(dateVacation: String, quantDay: String, completion: @escaping (Bool) -> Void) {
#if DEBUG
        let urlString = roadServer.testRoadWorkApp.rawValue
#else
        let urlString = roadServer.prodRoadWorkApp.rawValue
#endif
        // Раньше здесь был force unwrap UserDefaults — у неавторизованного пользователя приложение падало
        let uuidUser = realm.fetchUUID1C()
        
        guard !uuidUser.isEmpty else {
            CustomAlert().showFastAlertError(textError: "Для создания заявления необходимо авторизироваться в приложении")
            completion(false)
            return
        }
        
        let requestData = StatmentVacationRequestScheme(UUIDUser: uuidUser, dayStartVacation: dateVacation, quntDay: quantDay)
        
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
                            let data1C = try decoder.decode(errorResponceScheme.self, from: data)
                            
                            if !data1C.result {
                                let config = ConfigAlert(title: "Ошибка", message: data1C.error, type: .alert, actions: [])
                                CustomAlert().showAlert(config: config)
                                completion(false)
                            } else {
                                let config = ConfigAlert(title: "Заявление", message: "Заявка на отпуск создана", type: .alert, actions: [])
                                CustomAlert().showAlert(config: config)
                                completion(true)
                            }
                        } catch {
                            let config = ConfigAlert(title: "Ошибка", message: error.localizedDescription, type: .alert, actions: [])
                            CustomAlert().showAlert(config: config)
                            completion(false)
                        }
                    }
                }
                
            case .failure(let error):
                let config = ConfigAlert(title: "Ошибка", message: error.localizedDescription, type: .alert, actions: [])
                CustomAlert().showAlert(config: config)
                completion(false)
            }
        }
    }
    

}
