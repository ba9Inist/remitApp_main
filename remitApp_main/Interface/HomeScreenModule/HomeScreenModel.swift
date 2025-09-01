//
//  HomeScreenModel.swift
//  remitApp_main
//
//  Created by Егор Голубев on 23.05.2025.
//

import Foundation
import UIKit

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

final class HomeScreenModel {
    
    func oneRow() -> [UIButton]{
        
        return [
            CustomButton(config: ButtonConfig(title: nil,
                                              backgroundColor: .red,
                                              systemIconName: "beach.umbrella.fill",
                                              tintColor: .white,
                                              imageEdgeInsets: UIEdgeInsets(top: 15, left: 10, bottom: 20, right: 20),
                                              contentHorizontalAlignment: .fill,
                                              contentVerticalAlignment: .fill,
                                              targetSelectorPair: (target: self, #selector(HomeScreenVC.handleButtonTap(sender:))),
                                              cornerRadius: 10,
                                              tag: ButtonName.vacation.rawValue)),
            
            CustomButton(config: ButtonConfig(title: nil,
                                              backgroundColor: .systemGreen,
                                              systemIconName: "message",
                                              tintColor: .white,
                                              imageEdgeInsets: UIEdgeInsets(top: 15, left: 10, bottom: 20, right: 15),
                                              contentHorizontalAlignment: .fill,
                                              contentVerticalAlignment: .fill,
                                              targetSelectorPair: (target: self, #selector(HomeScreenVC.handleButtonTap(sender:))),
                                              cornerRadius: 10,
                                              tag: ButtonName.question.rawValue)),
            
            CustomButton(config: ButtonConfig(title: nil,
                                              backgroundColor: .systemYellow,
                                              systemIconName: "bus.fill",
                                              tintColor: .white,
                                              imageEdgeInsets: UIEdgeInsets(top: 15, left: 10, bottom: 20, right: 20),
                                              contentHorizontalAlignment: .fill,
                                              contentVerticalAlignment: .fill,
                                              targetSelectorPair: (target: self, #selector(HomeScreenVC.handleButtonTap(sender:))),
                                              cornerRadius: 10,
                                              tag: ButtonName.bus.rawValue)),
            
            CustomButton(config: ButtonConfig(title: nil,
                                              backgroundColor: .systemBlue,
                                              systemIconName: "calendar",
                                              tintColor: .white,
                                              imageEdgeInsets: UIEdgeInsets(top: 15, left: 10, bottom: 20, right: 20),
                                              contentHorizontalAlignment: .fill,
                                              contentVerticalAlignment: .fill,
                                              targetSelectorPair: (target: self, #selector(HomeScreenVC.handleButtonTap(sender:))),
                                              cornerRadius: 10,
                                              tag: ButtonName.calendar.rawValue)),
            
        ]
        
    }
    
    func twoRow() -> [UIButton]{
        
        return [
            CustomButton(config: ButtonConfig(title: nil,
                                              backgroundColor: .brown,
                                              systemIconName: "gear",
                                              tintColor: .white,
                                              imageEdgeInsets: UIEdgeInsets(top: 15, left: 10, bottom: 20, right: 15),
                                              contentHorizontalAlignment: .fill,
                                              contentVerticalAlignment: .fill,
                                              targetSelectorPair: (target: self, #selector(HomeScreenVC.handleButtonTap(sender:))),
                                              cornerRadius: 10,
                                              tag: ButtonName.setting.rawValue)),
            
            CustomButton(config: ButtonConfig(title: nil,
                                              backgroundColor: .purple,
                                              systemIconName: "book",
                                              tintColor: .white,
                                              imageEdgeInsets: UIEdgeInsets(top: 15, left: 10, bottom: 20, right: 20),
                                              contentHorizontalAlignment: .fill,
                                              contentVerticalAlignment: .fill,
                                              targetSelectorPair: (target: self, #selector(HomeScreenVC.handleButtonTap(sender:))),
                                              cornerRadius: 10,
                                              tag: ButtonName.competence.rawValue)),
            
            CustomButton(config: ButtonConfig(title: "Лояльность",
                                              backgroundColor: .lightGray,
                                              systemIconName: nil,
                                              tintColor: .white,
                                              imageEdgeInsets: nil,
                                              contentHorizontalAlignment: nil,
                                              contentVerticalAlignment: nil,
                                              targetSelectorPair: (target: self, #selector(HomeScreenVC.handleButtonTap(sender:))),
                                              cornerRadius: 10,
                                              tag: ButtonName.franchise.rawValue)),
            
            CustomButton(config: ButtonConfig(title: nil,
                                              backgroundColor: .cyan,
                                              systemIconName: "fork.knife.circle",
                                              tintColor: .white,
                                              imageEdgeInsets: UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 20),
                                              contentHorizontalAlignment: .fill,
                                              contentVerticalAlignment: .fill,
                                              targetSelectorPair: (target: self, #selector(HomeScreenVC.handleButtonTap(sender:))),
                                              cornerRadius: 10,
                                              tag:  ButtonName.food.rawValue)),
            
        ]
        
        
    }
    
    func threeRow() -> [UIButton]{
        
        return [
            CustomButton(config: ButtonConfig(title: "Дневник ученика",
                                              backgroundColor: .orange,
                                              systemIconName: nil,
                                              tintColor: .white,
                                              imageEdgeInsets: nil,
                                              contentHorizontalAlignment: nil,
                                              contentVerticalAlignment: nil,
                                              targetSelectorPair: (target: self, #selector(HomeScreenVC.handleButtonTap(sender:))),
                                              cornerRadius: 10,
                                              tag: ButtonName.student.rawValue)),
            
            CustomButton(config: ButtonConfig(title: "Дневник наставника",
                                              backgroundColor: .blue,
                                              systemIconName: nil,
                                              tintColor: .white,
                                              imageEdgeInsets: nil,
                                              contentHorizontalAlignment: nil,
                                              contentVerticalAlignment: nil,
                                              targetSelectorPair: (target: self, #selector(HomeScreenVC.handleButtonTap(sender:))),
                                              cornerRadius: 10,
                                              tag: ButtonName.teacher.rawValue)),
            
            CustomButton(config: ButtonConfig(title: "Сбер здоровье",
                                              backgroundColor: .green,
                                              systemIconName: nil,
                                              tintColor: .white,
                                              imageEdgeInsets: nil,
                                              contentHorizontalAlignment: nil,
                                              contentVerticalAlignment: nil,
                                              targetSelectorPair: (target: self, #selector(HomeScreenVC.handleButtonTap(sender:))),
                                              cornerRadius: 10,
                                              tag: ButtonName.sber.rawValue)),
            
            CustomButton(config: ButtonConfig(title: "Тонар",
                                              backgroundColor: .darkGray,
                                              systemIconName: nil,
                                              tintColor: .white,
                                              imageEdgeInsets: nil,
                                              contentHorizontalAlignment: nil,
                                              contentVerticalAlignment: nil,
                                              targetSelectorPair: (target: self, #selector(HomeScreenVC.handleButtonTap(sender:))),
                                              cornerRadius: 10,
                                              tag: ButtonName.tonar.rawValue)),
            
        ]
        
    }
    
}
