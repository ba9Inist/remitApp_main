//
//  salaryModel.swift
//  remitApp_main
//
//  Created by Егор Голубев on 14.03.2026.
//

import Foundation

final class salaryModel {
    
    let realm = realmManager()
    private let networkManager = NetworkManager.shared
    
    func getSalaryData(completion: @escaping (salaryResponceScheme) -> Void) {

#if DEBUG
        let urlString = roadServer.testRoadWorkApp.rawValue
#else
        let urlString = roadServer.prodRoadWorkApp.rawValue
#endif
        
        let UUID1C = realm.fetchUUID1C()
        
      let salaryData = salaryResponceScheme(actionName: "", additionsSalaryLastMonths: totalValueMonth(incentives: 0, mentoring: 0, deductions: 0, brigadiers: 0, hoursWorked: 0, totalPayment: 0), additionsSalaryCurrentMonths: totalValueMonth(incentives: 0, mentoring: 0, deductions: 0, brigadiers: 0, hoursWorked: 0, totalPayment: 0), LastMonthsSalary: [], CurrentMonthsSalary: [])
        
        // Пользователь не авторизован — возвращаем заглушку, иначе вызывающий навсегда останется без ответа
        guard !UUID1C.isEmpty else {
            completion(salaryData)
            return
        }
        let requestData = uneversalRequestScheme(UUIDUser: UUID1C, methodName: "salaryData")
        
        guard let jsonRequest = try? JSONEncoder().encode(requestData) else {
            CustomAlert().showFastAlertError(textError: "Не удалось инициализировать тело запроса")
            completion(salaryData)
            return
        }
        
        guard let url = URL(string: urlString) else {
            CustomAlert().showFastAlertError(textError: "Не корректный URL")
            completion(salaryData)
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
                                CustomAlert().showFastAlertError(textError: "Код ответа сервера: \(statusCode) Ошибка: \(errorResponse.error)")
                                completion(salaryData)
                            } catch {
                                CustomAlert().showFastAlertError(textError: "Код ответа сервера: \(statusCode) Ошибка: \(responseString)")
                                completion(salaryData)
                            }
                        } else {
                            CustomAlert().showFastAlertError(textError: "Не удалось преобразовать данные в строку.")
                            completion(salaryData)
                        }
                    } else {
                        do {
                            let decoder = CustomDecoder().getCustomDecoder()
                            let data1C = try decoder.decode(salaryResponceScheme.self, from: data)
                                completion(data1C)
                        } catch {
                            CustomDecoder().decoderErrorDescription(error)
                            CustomAlert().showFastAlertError(textError: "При декодировании ответа произошла ошибка: \(error.localizedDescription)")
                            completion(salaryData)
                        }
                    }
                } else {
                    // Пустое тело ответа: без этой ветки completion не вызывался и экран оставался заблокированным
                    CustomAlert().showFastAlertError(textError: "Сервер вернул пустой ответ (код \(statusCode))")
                    completion(salaryData)
                }

            case .failure(let error):
                CustomAlert().showFastAlertError(textError: "Ответ сервере не положительный: \(error.localizedDescription)")
                completion(salaryData)
            }
        }
    }
    
}
