//
//  loyalityModel.swift
//  remitApp_main
//
//  Created by Егор Голубев on 21.02.2026.
//

import Foundation
import CoreImage
import UIKit

struct dataCheck {
    var checkАmount: Double
    var dateCheck: Date
    var likeCount: Double
    var addressStore: String
    var products: [ProductSheme]
}

final class loyalityModel {
    
    let realm = realmManager()
    private let networkManager = NetworkManager.shared

    func qrCodeLoyalityCard(codeCard: String, size: CGFloat) -> UIImage? {

        let filter = CIFilter(name: "CICode128BarcodeGenerator")
        
        guard let data = codeCard.data(using: .ascii, allowLossyConversion: false) else { return nil }
        
        filter?.setValue(data, forKey: "inputMessage")
        
        if let outputCIImage = filter?.outputImage {
            
            let scaleFactor: CGFloat = size
            let scaledSize = CGSize(width: outputCIImage.extent.width * scaleFactor,
                                   height: outputCIImage.extent.height * scaleFactor)
            
            let transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
            let transformedOutput = outputCIImage.transformed(by: transform)
            

            let context = CIContext()
            if let cgImage = context.createCGImage(transformedOutput, from: CGRect(origin: CGPoint.zero, size: scaledSize)) {
                return UIImage(cgImage: cgImage)
            }
        }
        
        return nil
        
    }
    
    func getLoyalityData(updateCheck: Bool, completion: @escaping (loyalityDataResponceScheme) -> Void) {

#if DEBUG
        let urlString = roadServer.testRoadWorkApp.rawValue
#else
        let urlString = roadServer.prodRoadWorkApp.rawValue
#endif
        
        let UUID1C = realm.fetchUUID1C()
        
        let loyalData = loyalityDataResponceScheme(result: false,
                                                   error: "",
                                                   UUIDUser: UUID1C,
                                                   discountСard: "",
                                                   ownerName: "", 
                                                   balanceLikes: 0,
                                                   balanceLikesRub: 0,
                                                   ShoppingList: [])
        
        // Пользователь не авторизован — возвращаем заглушку с текстом, иначе вызывающий не получит ответ
        guard !UUID1C.isEmpty else {
            completion(loyalityDataResponceScheme(result: false,
                                                  error: "Для отображения данных, необходимо авторизироваться в приложении",
                                                  UUIDUser: "",
                                                  discountСard: "",
                                                  ownerName: "",
                                                  balanceLikes: 0,
                                                  balanceLikesRub: 0,
                                                  ShoppingList: []))
            return
        }
        let requestData = loyalityDataRequestScheme(UUIDUser: UUID1C, updateCheck: updateCheck)
        
        guard let jsonRequest = try? JSONEncoder().encode(requestData) else {
            CustomAlert().showFastAlertError(textError: "Не удалось инициализировать тело запроса")
            completion(loyalData)
            return
        }
        
        guard let url = URL(string: urlString) else {
            CustomAlert().showFastAlertError(textError: "Не корректный URL")
            completion(loyalData)
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
                                completion(loyalData)
                            } catch {
                                CustomAlert().showFastAlertError(textError: "Код ответа сервера: \(statusCode) Ошибка: \(responseString)")
                                completion(loyalData)
                            }
                        } else {
                            CustomAlert().showFastAlertError(textError: "Не удалось преобразовать данные в строку.")
                            completion(loyalData)
                        }
                    } else {
                        do {
                            let decoder = CustomDecoder().getCustomDecoder()
                            let data1C = try decoder.decode(loyalityDataResponceScheme.self, from: data)
                            
                            if !data1C.result {
                                CustomAlert().showFastAlertError(textError: data1C.error)
                                completion(loyalData)
                            } else {
                                completion(data1C)
                            }
                        } catch {
                            CustomDecoder().decoderErrorDescription(error)
                            CustomAlert().showFastAlertError(textError: "При декодировании ответа произошла ошибка: \(error.localizedDescription)")
                            completion(loyalData)
                        }
                    }
                } else {
                    // Пустое тело ответа: без этой ветки completion не вызывался и экран оставался заблокированным
                    CustomAlert().showFastAlertError(textError: "Сервер вернул пустой ответ (код \(statusCode))")
                    completion(loyalData)
                }

            case .failure(let error):
                CustomAlert().showFastAlertError(textError: "Ответ сервере не положительный: \(error.localizedDescription)")
                completion(loyalData)
            }
        }
    }
    
}




