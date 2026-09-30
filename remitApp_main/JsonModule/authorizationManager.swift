//
//  authorizationManager.swift
//  remitApp_main
//
//  Created by Егор Голубев on 08.09.2025.
//

import Foundation
import UIKit

protocol ResultProtocol: Decodable {
    var result: Bool { get }
    var error: String { get }
}

//С0хема json ошибка из базы

struct errorResponceScheme: ResultProtocol {
    let result: Bool
    let error: String
}

//Схема получения стартового фото из 1С

struct startImgResponceScheme: ResultProtocol {
    let result: Bool
    let error: String
    let urlPhoto: String
}

//Схема json отправка запроса в 1С

struct authorizationRequestScheme: Encodable {
    let numberPhone: String
    let methodName: String = "GenerateAnAuthorizationCode"
    let phoneModel: String = UIDevice.modelName()
    let systemVersion: String = UIDevice.current.systemVersion
    let codeAuthorization: String
    
    init(numberPhone: String, codeAuthorization: String) {
        self.numberPhone = numberPhone
        self.codeAuthorization = codeAuthorization
    }
}

//Схема json получение ответа из 1С

struct authorizationResponeScheme: ResultProtocol {
    let result: Bool
    let error: String
    let UUIDUser: String
}

//Схема json отправка запроса  проверки кода в 1С

struct checkCodeRequestScheme: Encodable {
    let numberPhone: String
    let methodName: String = "CheckCodeАuthorization"
    let UUIDUser: String
    let codeAuthorization: String
    
    init(numberPhone: String, codeAuthorization: String, UUIDUser: String) {
        self.numberPhone = numberPhone
        self.codeAuthorization = codeAuthorization
        self.UUIDUser = UUIDUser
    }
}

