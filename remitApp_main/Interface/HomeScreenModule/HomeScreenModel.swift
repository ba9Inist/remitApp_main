//
//  HomeScreenModel.swift
//  remitApp_main
//
//  Created by Егор Голубев on 23.05.2025.
//

import Foundation
import UIKit
import RealmSwift
import SwiftUI
import SnapKit

enum ButtonName: Int {
    case vacation = 1
    case question
    case bus
    case calendar
    case setting
    case competence
    case franchise
    case food
    case student
    case teacher
    case sber
    case tonar
}

struct news {
    let nameNews: String
    let textNews: String
    let colorHex: String
    let date: Date
}


final class HomeScreenModel {
    
    let realm = realmManager()
    
    func UpdateUI(view: HomeScreenView) {
        
        if let dataUser = realm.fetchUser() {
            view.nameProfile.text = dataUser.name + " " + dataUser.patronymic
            view.surnameProfile.text = dataUser.surname
            view.rankProfile.text = dataUser.post
            view.experienceProfile.text = "Стаж: " + String(describing: dataUser.experience)
            view.competenceProfile.text = "Компетенции: " + String(describing: dataUser.competention ?? 0)
            view.imgProfile.image = imgProfileDecode(photoBase64: dataUser.photoUser)
            view.dayVacation.text = dataUser.daysVacation.description
            view.tonarWeight.text = dataUser.countTonar.description
            
            if dataUser.competention == 0 {
                view.competenceProfile.isHidden = true
            }
        }
    }
    
    func fetchNews() -> [news] {
        guard let userData = realm.fetchUser() else { return [news]() }
        var arrayNews = [news]()
        
        arrayNews = userData.News.map { item in
            news(nameNews: item.nameNews,
                 textNews: item.textNews,
                 colorHex: item.colorHex,
                 date: item.date)
        }
        return arrayNews
    }
    
    func imgProfileDecode(photoBase64: String) -> UIImage {
        guard let decodedData = Data(base64Encoded: photoBase64) else {
            print("Ошибка декодирования!")
            return UIImage(systemName: "person")!
        }

        guard let image = UIImage(data: decodedData) else {
            print("Ошибка создания изображения!")
            return UIImage(systemName: "person.fill")!
        }
        
        return image
    
    }
    
        
}
