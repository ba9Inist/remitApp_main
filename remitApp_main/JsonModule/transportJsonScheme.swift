//
//  transportModule.swift
//  remitApp_main
//
//  Created by Егор Голубев on 24.10.2025.
//

import Foundation
import UIKit

//Схема отправки расписания автобусов JSON в 1С

struct transportRequestScheme: Encodable {
    let methodName: String = "busSchedule"
    let UUIDUser: String
}

//Схема получение ответа из 1С расписание автобусов

struct TransportResponseSheme: ResultProtocol {
    let result: Bool
    let error: String
    let UUIDUser: String
    let arrayRouteBus: [TransportRoute]
    let arrayRouteMicroBus: [TransportRoute]
}

struct TransportRoute: Codable {
    let routeName: String
    let idRoute1C: String
    let bus: Bool
    let dataRoute: [TransportStop]
}

struct TransportStop: Codable {
    let numberLine: Int
    let time: Date
    let idTransportationStop1C: String
    let nameTransportationStop: String
    let latitude: String
    let longitude: String
    let countPeopleTransportationStop: Int
}

//Схема запись на остановку JSON в 1С

struct waitingForTransportRequestScheme: Encodable {
    let methodName: String = "waitingForTransport"
    let UUIDUser: String
    let idRoute1C: String
    let idTransportationStop1C: String
    let bus: Bool
    init(UUIDUser: String, idRoute1C: String, idTransportationStop1C: String, bus: Bool) {
        self.UUIDUser = UUIDUser
        self.idRoute1C = idRoute1C
        self.idTransportationStop1C = idTransportationStop1C
        self.bus = bus
    }
}

//Схема ответа json из 1С количество ожидающих

struct waitingForTransportResponseSheme: ResultProtocol {
    let result: Bool
    let error: String
    let UUIDUser: String
    let numberOfPeopleWaiting: Int
}

//Схема запроса в 1С получение координат транспорта
struct coordinatesTransportRequestScheme: Encodable {
    let methodName: String = "getCoordinatesBus"
    let UUIDUser: String
    init(UUIDUser: String) {
        self.UUIDUser = UUIDUser
    }
}


//Схема ответ из 1С Массив актуальных координат
struct coordinatesTransportResponseSheme: ResultProtocol {
    var result: Bool
    var error: String
    let UUIDUser: String
    let coordinates: [dataCoordinates]
}

struct dataCoordinates: Codable {
    let transport: String
    //let lastDate: Date
    let longitude: Double
    let latitude: Double
    let bus: Bool
}

