//
//  ChatModel.swift
//  remitApp_main
//
//  Created by Егор Голубев on 17.06.2025.
//

import Foundation
import MessageKit
import UIKit
import RealmSwift

final class ChatModel {
    
    private let realm = realmManager()
    private let networkManager = NetworkManager.shared
    
    func fetchUserPhohto() -> UIImage {
        if let dataUser = realm.fetchUser() {
            return HomeScreenModel().imgProfileDecode(photoBase64: dataUser.photoUser)
        }
        return UIImage(systemName: "person")!
    }
    
    func fetchChat() -> [customMessage] {
        guard let userData = realm.fetchUser() else { return [customMessage]() }
        
        var arrayChat = [customMessage]()
        
        arrayChat = userData.historyChat.map { item in
            customMessage(anonim: item.anonim,
                          code: item.code,
                          inputMessage: item.inputMessage,
                          textMessage: item.textMessage,
                          dateMessage: item.dateMessage)
        }
        return arrayChat
    }
    
    
    func jobChatHttp(textMessage: String, completion: @escaping (Bool) -> Void) {
#if DEBUG
        let urlString = roadServer.testRoadWorkApp.rawValue
#else
        let urlString = roadServer.prodRoadWorkApp.rawValue
#endif
        
        let UUID1C = realm.fetchUUID1C()
        
        // Пользователь не авторизован — сообщаем вызывающему о неудаче, иначе он не получит ответ никогда
        guard !UUID1C.isEmpty else {
            completion(false)
            return
        }
        let requestData = jobChatRequestScheme(UUIDUser: UUID1C, textMessage: textMessage)
        
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
                            let data1C = try decoder.decode(jobChatResponeScheme.self, from: data)
                            
                            if !data1C.result {
                                let config = ConfigAlert(title: "Ошибка", message: data1C.error, type: .alert, actions: [])
                                CustomAlert().showAlert(config: config)
                                completion(false)
                            } else {
                                self.realm.loadChatRealm(chatData: data1C)
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


struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
    init(sender: SenderType, messageId: String, date: Date, text: String) {
        self.sender = sender
        self.messageId = messageId
        self.sentDate = date
        self.kind = .text(text)
    }
}

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct customMessage {
    let anonim :Bool
    let code: Int
    let inputMessage: Bool
    let textMessage: String
    let dateMessage: Date
    
}



extension Message {
    init(chatObject: customMessage) {
    
        let sender = Sender(senderId: chatObject.inputMessage ? "me": "he" , displayName: chatObject.anonim ? "me": "he")
        self.init(sender: sender, messageId: chatObject.code.description, date: chatObject.dateMessage, text: chatObject.textMessage)
    }
}

