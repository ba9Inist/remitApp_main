//
//  restoranModule.swift
//  remitApp_main
//
//  Created by Егор Голубев on 01.11.2025.
//

import Foundation

//Схема ответа json из 1С меню ресторана

struct menuRestoranResponseSheme: ResultProtocol {
    let result: Bool
    let error: String
    let UUIDUser: String
    var yesterdaysMenu: [menuItemResponseSheme]?
    var todayMenu: [menuItemResponseSheme]?
    var tomorrowMenu: [menuItemResponseSheme]?
}

struct menuItemResponseSheme: Codable {
    let line: Int
    let product: String
    let quantity: Double
    let caloric: Double
    let typeFood: String
}


