//
//  infoUserManager.swift
//  remitApp_main
//
//  Created by Егор Голубев on 11.09.2025.
//

import Foundation
import UIKit

//Схема json отправки запроса  информации пользователя из 1С

struct informationUserRequestScheme: Encodable {
    let uuidUser1C: String
}

//Схема json получение ответа информации пользователя из 1С

struct informationUserResponeScheme: ResultProtocol {
    let result: Bool
    let error: String
    let UUIDUser: String
    let surname: String
    let name: String
    let patronymic: String
    let dateOfBirth: Date
    let loyaltyCardNumber: String
    let mentor: Bool
    let gender: String
    let phoneNumber: String
    let director: String
    let department: String
    let experience: Float
    let post: String
    let driver: Bool
    let photoUser: String
    let countTonar: String
    let employeeRating: Int?
    let competention: Int?
    let listСompetencies: [listCompetenciesResponeScheme]?
    let News: [NewsResponeScheme]?
    let vacation: [vacationResponseScheme]?
    let currentVersionApp: Int
    let daysVacation: Int
    let welcomeTextDms: String
    let historyChat: [historyChatResponceScheme]?
    let dms: [dmsResponceScheme]?
}

//Схема json получение ответа листа компетенций из 1С

struct listCompetenciesResponeScheme: Decodable{
    let ratingPercent: Int
    let dateСertification: Date
    let area: String
    let admittedWork: Bool
}

//Схема json получение ответа списка новостей из 1С

struct NewsResponeScheme: Decodable {
    let nameNews: String
    let textNews: String
    let colorHex: String
    let date: Date
}

struct vacationResponseScheme: Decodable {
    let startOfVacation: Date
    let endOfVacation: Date
    let pastVacation: Bool
    let days: Int
}

//Схема json получение ответа отпуска из 1С

struct historyChatResponceScheme: Decodable {
    let code: Int
    let textMessage: String
    let anonim: Bool
    let inputMessage: Bool
    //let dateMessage: Date
}

//Схема json получение ответа ДМС из 1С

struct  dmsResponceScheme: Decodable {
    let name: String
    let type: String
    let instruction: String
    let organization: String
    let code: String
    let startDate: Date
    let endDate: Date
    let count: Int
    let issued: Bool
}

//Схема отправки JSON в 1С заявление на отпуск

struct StatmentVacationRequestScheme: Encodable {
    let methodName: String = "applyForVacation"
    let dayStartVacation: String
    let quantDay: String
    let UUIDUser: String
    init(UUIDUser: String, dayStartVacation: String, quntDay: String) {
        self.UUIDUser = UUIDUser
        self.dayStartVacation = dayStartVacation
        self.quantDay = quntDay
    }
}

//Схема отправки  чата JSON в 1С заявление на отпуск

struct jobChatRequestScheme: Encodable {
    let methodName: String = "chat"
    let UUIDUser: String
    let textMessage: String
    init(UUIDUser: String, textMessage: String) {
        self.UUIDUser = UUIDUser
        self.textMessage = textMessage
    }
}

//Схема json получение ответа информации пользователя из 1С

struct jobChatResponeScheme: ResultProtocol {
    var result: Bool
    var error: String
    let UUIDUser: String
    let historyChat: [historyChatResponceScheme]?
}


//Универсальная схема отправки json в 1С
struct uneversalRequestScheme: Encodable {
    let methodName: String
    let UUIDUser: String
    init(UUIDUser: String, methodName: String) {
        self.UUIDUser = UUIDUser
        self.methodName = methodName
    }
}



