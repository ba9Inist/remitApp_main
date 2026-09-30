//
//  realmManager.swift
//  remitApp_main
//
//  Created by Егор Голубев on 12.09.2025.
//

import Foundation
import RealmSwift
import UIKit

final class realmManager {
    
    //private let realmInstance = try! Realm()
    
    private lazy var realmInstance: Realm = {
        do {
            let config = Realm.Configuration(
                schemaVersion: 4, // Увеличиваем версию схемы
                migrationBlock: { migration, oldSchemaVersion in
                    if oldSchemaVersion < 1 {
                        migration.enumerateObjects(ofType: "InformationUserRealm") { oldObject, newObject in
                            guard let oldObject = oldObject else { return }
                            guard let newObject = newObject else { return }
                            
                            if let oldNews = oldObject["news"] as? List<NewsRealm> {
                                newObject["News"] = oldNews
                            } else {
                                newObject["News"] = List<NewsRealm>()
                            }
                        }
                    }
                    
                    if oldSchemaVersion < 2 {
                        migration.enumerateObjects(ofType: "InformationUserRealm") { oldObject, newObject in
                            guard let oldObject = oldObject else { return }
                            guard let newObject = newObject else { return }
                            
                            newObject["vacation"] = List<listVacationRealm>() // Добавляем новый список отпусков
                        }
                    }
                    
                    if oldSchemaVersion < 3 {
                        migration.enumerateObjects(ofType: "InformationUserRealm") { oldObject, newObject in
                            guard let oldObject = oldObject else { return }
                            guard let newObject = newObject else { return }
                            
                            newObject["daysVacation"] = 0                   // Новое поле дней отпуска
                            newObject["historyChat"] = List<listChatRealm>()// Новый список чата
                            newObject["currentVersionApp"] = 0              // Версия приложения
                            newObject["welcomeTextDms"] = ""                 // Приветственный текст
                            newObject["dms"] = List<listDmsRealme>()         // Список DMS
                        }
                    }
                    
                    if oldSchemaVersion < 4 {
                        migration.enumerateObjects(ofType: "listChatRealm") { oldChatObject, newChatObject in
                            guard let oldChatObject = oldChatObject else { return }
                            guard let newChatObject = newChatObject else { return }
                            
                            // Переводим string в int для поля code
                            if let oldCodeString = oldChatObject["code"] as? String,
                               let intValue = Int(oldCodeString) {
                                newChatObject["code"] = intValue
                            } else {
                                newChatObject["code"] = 0 // Устанавливаем default-значение
                            }
                            
                            // Переводим string в bool для полей anonim и inputMessage
                            if let oldAnonimString = oldChatObject["anonim"] as? String {
                                newChatObject["anonim"] = oldAnonimString.lowercased() == "true"
                            } else {
                                newChatObject["anonim"] = false
                            }
                            
                            if let oldInputMessageString = oldChatObject["inputMessage"] as? String {
                                newChatObject["inputMessage"] = oldInputMessageString.lowercased() == "true"
                            } else {
                                newChatObject["inputMessage"] = false
                            }
                        }
                    }
                }
            )
            
            do {
                return try Realm(configuration: config)
            } catch {
                // Повреждённый файл или несошедшаяся миграция раньше давали вечный краш на старте
                // без пути восстановления. Пересоздаём базу — данные всё равно перезапрашиваются из 1С.
                print("Не удалось открыть Realm, пересоздаём базу: \(error.localizedDescription)")
                
                if let fileURL = config.fileURL {
                    try? FileManager.default.removeItem(at: fileURL)
                }
                
                return try Realm(configuration: config)
            }
        } catch {
            fatalError("Ошибка инициализации Realm экземпляра: \(error.localizedDescription)")
        }
    }()
    
    //Добавление данных пользователя в Realm
    func addDataUser(userInfo: informationUserResponeScheme) {
        let realmUser = convertToRealm(userInfo: userInfo)
        
        do {
            try realmInstance.write {
                realmInstance.delete(realmInstance.objects(listChatRealm.self))
                realmInstance.add(realmUser, update: .modified)
            }
        } catch {
            // Раньше здесь был try! — любая ошибка записи роняла приложение
            print("Ошибка при сохранении данных пользователя: ", error.localizedDescription)
            CustomAlert().showFastAlertError(textError: "Не удалось сохранить данные пользователя")
        }
        
    }
    
    //Получение пользовательской информации из Realm
    func fetchUser () -> InformationUserRealm? {
        return realmInstance.objects(InformationUserRealm.self).first
    }
    
    //Получить сохраненный UUID пользователя в UserDefaults
    func fetchUUID1C() -> String {
        return UserDefaults.standard.string(forKey: "uuidUser1C") ?? ""
    }
    
    func convertToRealm(userInfo: informationUserResponeScheme) -> InformationUserRealm {
        let realmUser = InformationUserRealm()
        realmUser.uuidUser = userInfo.UUIDUser
        realmUser.surname = userInfo.surname
        realmUser.name = userInfo.name
        realmUser.patronymic = userInfo.patronymic
        //realmUser.dateOfBirth = userInfo.dateOfBirth
        realmUser.loyaltyCardNumber = userInfo.loyaltyCardNumber
        realmUser.mentor = userInfo.mentor
        realmUser.gender = userInfo.gender
        realmUser.phoneNumber = userInfo.phoneNumber
        realmUser.director = userInfo.director
        realmUser.department = userInfo.department
        realmUser.experience = userInfo.experience
        realmUser.post = userInfo.post
        realmUser.driver = userInfo.driver
        realmUser.photoUser = userInfo.photoUser
        realmUser.countTonar = userInfo.countTonar
        realmUser.employeeRating = userInfo.employeeRating
        realmUser.competention = userInfo.competention
        realmUser.daysVacation = userInfo.daysVacation
        realmUser.currentVersionApp = userInfo.currentVersionApp
        realmUser.welcomeTextDms = userInfo.welcomeTextDms
        
        
        //Лист компетенций
        
        if let competencyList = userInfo.listСompetencies {
            let realmCompetencies = List<ListCompetenciesRealm>()
            for competency in competencyList {
                let realmCompetency = ListCompetenciesRealm()
                realmCompetency.ratingPercent = competency.ratingPercent
                realmCompetency.dateCertification = competency.dateСertification
                realmCompetency.area = competency.area
                realmCompetency.admittedWork = competency.admittedWork
                realmCompetencies.append(realmCompetency)
            }
            realmUser.listCompetencies.removeAll()
            realmUser.listCompetencies = realmCompetencies
            
            
        }
        
        // Новости
        
        if let newsList = userInfo.News {
            let realmNews = List<NewsRealm>()
            for newsItem in newsList {
                let realmNewsItem = NewsRealm()
                realmNewsItem.nameNews = newsItem.nameNews
                realmNewsItem.textNews = newsItem.textNews
                realmNewsItem.colorHex = newsItem.colorHex
                realmNewsItem.date = newsItem.date
                realmNews.append(realmNewsItem)
            }
            realmUser.News.removeAll()
            realmUser.News = realmNews
        }
        
        //Отпуск
        
        if let vacationList = userInfo.vacation {
            
            let realmVacation = List<listVacationRealm>()
            for vacationItem in vacationList {
                let realmVacationItem = listVacationRealm()
                realmVacationItem.startOfVacation = vacationItem.startOfVacation
                realmVacationItem.endOfVacation = vacationItem.endOfVacation
                realmVacationItem.pastVacation = vacationItem.pastVacation
                realmVacationItem.days = vacationItem.days
                realmVacation.append(realmVacationItem)
            }
            realmUser.vacation.removeAll()
            realmUser.vacation = realmVacation
        }
        
        //Чат
        
        if let chatList = userInfo.historyChat {
            
            let realmChat = List<listChatRealm>()
            for chatItem in chatList {
                let realmChatItem = listChatRealm()
                realmChatItem.anonim = chatItem.anonim
                realmChatItem.code = chatItem.code
                //realmChatItem.dateMessage = chatItem.dateMessage
                realmChatItem.inputMessage = chatItem.inputMessage
                realmChatItem.textMessage = chatItem.textMessage
                realmChat.append(realmChatItem)
            }
            realmUser.historyChat.removeAll()
            realmUser.historyChat = realmChat
        }
        
        if let dmsList = userInfo.dms {
            
            let realmDms = List<listDmsRealme>()
            for dmsItem in dmsList {
                let realmDmsItem = listDmsRealme()
                realmDmsItem.code = dmsItem.code
                realmDmsItem.count = dmsItem.count
                realmDmsItem.endDate = dmsItem.endDate
                realmDmsItem.instruction = dmsItem.instruction
                realmDmsItem.issued = dmsItem.issued
                realmDmsItem.name = dmsItem.name
                realmDmsItem.organization = dmsItem.organization
                realmDmsItem.startDate = dmsItem.startDate
                realmDms.append(realmDmsItem)
            }
            realmUser.dms.removeAll()
            realmUser.dms = realmDms
        }
        
        return realmUser
    }
    
    func loadChatRealm(chatData: jobChatResponeScheme) {
        guard let chatList = chatData.historyChat else { return }
        
        do {
            guard let user = fetchUser() else {
                return
            }
            
            let realmChat = List<listChatRealm>()
            for chatItem in chatList {
                let realmChatItem = listChatRealm()
                realmChatItem.anonim = chatItem.anonim
                realmChatItem.code = chatItem.code
                realmChatItem.inputMessage = chatItem.inputMessage
                realmChatItem.textMessage = chatItem.textMessage
                realmChat.append(realmChatItem)
            }
            
            try realmInstance.write {
                realmInstance.delete(realmInstance.objects(listChatRealm.self))
                user.historyChat.removeAll()
                user.historyChat = realmChat
                realmInstance.add(user, update: .modified)
            }
        } catch let error as NSError {
            print("Ошибка при обновлении истории чата: ", error.localizedDescription)
        }
    }
    
}


