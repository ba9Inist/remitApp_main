//
//  loyalityModule.swift
//  remitApp_main
//
//  Created by Егор Голубев on 23.02.2026.
//

import Foundation

//Схема запрос данных лояльности в 1С

struct loyalityDataRequestScheme: Encodable {
    let methodName: String = "getLoyaltyData"
    let UUIDUser: String
    let updateCheck: Bool
    init(UUIDUser: String, updateCheck: Bool) {
        self.UUIDUser = UUIDUser
        self.updateCheck = updateCheck
    }
}

//Схема ответа json из 1С данные лояльности

struct loyalityDataResponceScheme: ResultProtocol {
    let result: Bool
    let error: String
    let UUIDUser: String
    let discountСard: String
    let ownerName: String
    let balanceLikes: Double
    let balanceLikesRub: Double
    var ShoppingList: [ShoppingListSheme]
    }

struct ShoppingListSheme: Decodable {
    let discountСard: String
    let checkNumber: String
    let checkАmount: Double
    let dateCheck: Date
    let discount: Double
    let posNumber: Int
    let likeCount: Double
    let likeCountRub: Double
    let addressStore: String
    var products: [ProductSheme]
}

struct ProductSheme: Decodable {
    let product: String
    let codeProduct: String
    let quantity: Double
    let price: Int
    let amount: Double
    let refImgProduct: String
    let weight: Bool
}
