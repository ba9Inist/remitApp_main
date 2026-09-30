//
//  transportModel.swift
//  remitApp_main
//
//  Created by Егор Голубев on 21.10.2025.
//

import Foundation

struct transportRoute {
    let routeName: String
    let idRoute1C: String
    let bus: Bool
    var dataRoute: [DataPoint]
    
    struct DataPoint {
        let numberLine: Int
        let time: Date
        let idTransportationStop1C: String
        let nameTransportationStop: String
        let latitude: String
        let longitude: String
        var countPeopleTransportationStop: Int
    }
}

struct coordinatesTransport {
    var transport: String
    //var lastDate: Date
    var longitude: Double
    var latitude: Double
    var bus: Bool
}


final class transportModel {
    
    
    private let networkManager = NetworkManager.shared
    private let realm = realmManager()
    
    func getScheduleBus(completion: @escaping ([transportRoute]) -> Void) {
#if DEBUG
        let urlString = roadServer.testRoadWorkApp.rawValue
#else
        let urlString = roadServer.prodRoadWorkApp.rawValue
#endif
        
        let UUID1C = realm.fetchUUID1C()
        
        // Пользователь не авторизован — возвращаем пустое расписание, иначе вызывающий не получит ответ
        guard !UUID1C.isEmpty else {
            completion([transportRoute]())
            return
        }
        let requestData = transportRequestScheme.init(UUIDUser: UUID1C)
        
        guard let jsonRequest = try? JSONEncoder().encode(requestData) else {
            let config = ConfigAlert(title: "Ошибка", message: "Не удалось закодировать запрос!", type: .alert, actions: [])
            CustomAlert().showAlert(config: config)
            completion([transportRoute]())
            return
        }
        
        guard let url = URL(string: urlString) else {
            let config = ConfigAlert(title: "Ошибка", message: "Некорректный URL!", type: .alert, actions: [])
            CustomAlert().showAlert(config: config)
            completion([transportRoute]())
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
                                completion([transportRoute]())
                            } catch {
                                let config = ConfigAlert(title: "Ошибка", message: responseString, type: .alert, actions: [])
                                CustomAlert().showAlert(config: config)
                                completion([transportRoute]())
                            }
                        } else {
                            let config = ConfigAlert(title: "Ошибка", message: "Не удалось преобразовать данные в строку.", type: .alert, actions: [])
                            CustomAlert().showAlert(config: config)
                            completion([transportRoute]())
                        }
                    } else {
                        do {
                            let decoder = CustomDecoder().getCustomDecoder()
                            let data1C = try decoder.decode(TransportResponseSheme.self, from: data)
                            
                            if !data1C.result {
                                let config = ConfigAlert(title: "Ошибка", message: data1C.error, type: .alert, actions: [])
                                CustomAlert().showAlert(config: config)
                                completion([transportRoute]())
                            } else {
                                let buses = self.convertToTransportRoute(array: data1C.arrayRouteBus)
                                let microBuses = self.convertToTransportRoute(array: data1C.arrayRouteMicroBus)
                                let allRoutes = buses + microBuses
                                completion(allRoutes)
                            }
                        } catch {
                            let config = ConfigAlert(title: "Ошибка", message: error.localizedDescription, type: .alert, actions: [])
                            CustomAlert().showAlert(config: config)
                            completion([transportRoute]())
                        }
                    }
                } else {
                    // Пустое тело ответа: без этой ветки completion не вызывался и расписание не загружалось молча
                    let config = ConfigAlert(title: "Ошибка", message: "Сервер вернул пустой ответ (код \(statusCode))", type: .alert, actions: [])
                    CustomAlert().showAlert(config: config)
                    completion([transportRoute]())
                }

            case .failure(let error):
                let config = ConfigAlert(title: "Ошибка", message: error.localizedDescription, type: .alert, actions: [])
                CustomAlert().showAlert(config: config)
                completion([transportRoute]())
            }
        }
    }
    
    private func convertToTransportRoute(array: [TransportRoute]) -> [transportRoute] {
        return array.map { route in
            transportRoute(
                routeName: route.routeName,
                idRoute1C: route.idRoute1C,
                bus: route.bus,
                dataRoute: route.dataRoute.map { stop in
                    transportRoute.DataPoint(
                        numberLine: stop.numberLine,
                        time: stop.time,
                        idTransportationStop1C: stop.idTransportationStop1C,
                        nameTransportationStop: stop.nameTransportationStop,
                        latitude: stop.latitude,
                        longitude: stop.longitude,
                        countPeopleTransportationStop: stop.countPeopleTransportationStop
                    )
                }
            )
        }
    }
    
    func signUpForStop(dataRoute:routeCellData, completion: @escaping (Int) -> Void) {
#if DEBUG
        let urlString = roadServer.testRoadWorkApp.rawValue
#else
        let urlString = roadServer.prodRoadWorkApp.rawValue
#endif
        
        let UUID1C = realm.fetchUUID1C()
        
        // Пользователь не авторизован — возвращаем нулевое число ожидающих, иначе вызывающий не получит ответ
        guard !UUID1C.isEmpty else {
            completion(0)
            return
        }
        let requestData = waitingForTransportRequestScheme.init(UUIDUser: UUID1C,
                                                                idRoute1C: dataRoute.idRoute1C,
                                                                idTransportationStop1C: dataRoute.idTransportationStop1C,
                                                                bus: dataRoute.bus)
        
        guard let jsonRequest = try? JSONEncoder().encode(requestData) else {
            let config = ConfigAlert(title: "Ошибка", message: "Не удалось закодировать запрос!", type: .alert, actions: [])
            CustomAlert().showAlert(config: config)
            completion(0)
            return
        }
        
        guard let url = URL(string: urlString) else {
            let config = ConfigAlert(title: "Ошибка", message: "Некорректный URL!", type: .alert, actions: [])
            CustomAlert().showAlert(config: config)
            completion(0)
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
                                completion(0)
                            } catch {
                                let config = ConfigAlert(title: "Ошибка", message: responseString, type: .alert, actions: [])
                                CustomAlert().showAlert(config: config)
                                completion(0)
                            }
                        } else {
                            let config = ConfigAlert(title: "Ошибка", message: "Не удалось преобразовать данные в строку.", type: .alert, actions: [])
                            CustomAlert().showAlert(config: config)
                            completion(0)
                        }
                    } else {
                        do {
                            let decoder = CustomDecoder().getCustomDecoder()
                            let data1C = try decoder.decode(waitingForTransportResponseSheme.self, from: data)
                            
                            if !data1C.result {
                                let config = ConfigAlert(title: "Ошибка", message: data1C.error, type: .alert, actions: [])
                                CustomAlert().showAlert(config: config)
                                completion(0)
                            } else {
                                completion(data1C.numberOfPeopleWaiting)
                            }
                        } catch {
                            let config = ConfigAlert(title: "Ошибка", message: error.localizedDescription, type: .alert, actions: [])
                            CustomAlert().showAlert(config: config)
                            completion(0)
                        }
                    }
                } else {
                    // Пустое тело ответа: без этой ветки completion не вызывался и запись на остановку молча терялась
                    let config = ConfigAlert(title: "Ошибка", message: "Сервер вернул пустой ответ (код \(statusCode))", type: .alert, actions: [])
                    CustomAlert().showAlert(config: config)
                    completion(0)
                }

            case .failure(let error):
                let config = ConfigAlert(title: "Ошибка", message: error.localizedDescription, type: .alert, actions: [])
                CustomAlert().showAlert(config: config)
                completion(0)
            }
        }
    }
    
    
    func coordinateTransport(bus: Bool, completion: @escaping (coordinatesTransport) -> Void) {
#if DEBUG
        let urlString = roadServer.testRoadWorkApp.rawValue
#else
        let urlString = roadServer.prodRoadWorkApp.rawValue
#endif
        
        let UUID1C = realm.fetchUUID1C()
        
        var coordinates = coordinatesTransport(transport: "",
                                               //lastDate: Date(),
                                               longitude: 0,
                                               latitude: 0,
                                               bus: false)
        
        // Пользователь не авторизован — возвращаем пустые координаты, иначе вызывающий не получит ответ
        guard !UUID1C.isEmpty else {
            completion(coordinates)
            return
        }
        let requestData = coordinatesTransportRequestScheme.init(UUIDUser: UUID1C)
        
        guard let jsonRequest = try? JSONEncoder().encode(requestData) else {
            let config = ConfigAlert(title: "Ошибка", message: "Не удалось закодировать запрос!", type: .alert, actions: [])
            CustomAlert().showAlert(config: config)
            completion(coordinates)
            return
        }
        
        guard let url = URL(string: urlString) else {
            let config = ConfigAlert(title: "Ошибка", message: "Некорректный URL!", type: .alert, actions: [])
            CustomAlert().showAlert(config: config)
            completion(coordinates)
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
                                completion(coordinates)
                            } catch {
                                let config = ConfigAlert(title: "Ошибка", message: responseString, type: .alert, actions: [])
                                CustomAlert().showAlert(config: config)
                                completion(coordinates)
                            }
                        } else {
                            let config = ConfigAlert(title: "Ошибка", message: "Не удалось преобразовать данные в строку.", type: .alert, actions: [])
                            CustomAlert().showAlert(config: config)
                            completion(coordinates)
                        }
                    } else {
                        do {
                            let decoder = JSONDecoder()
                            let data1C = try decoder.decode(coordinatesTransportResponseSheme.self, from: data)
                            
                            if !data1C.result {
                                let config = ConfigAlert(title: "Ошибка", message: data1C.error, type: .alert, actions: [])
                                CustomAlert().showAlert(config: config)
                                completion(coordinates)
                            } else {
                                let filteredElements = data1C.coordinates.filter { $0.bus == bus }
                                let finalData = filteredElements.first
                                
                                if let firstElement = finalData {
                                    coordinates.bus = firstElement.bus
                                    //coordinates.lastDate = firstElement.lastDate
                                    coordinates.latitude = firstElement.latitude
                                    coordinates.longitude = firstElement.longitude
                                    coordinates.transport = firstElement.transport
                                    completion(coordinates)
                                } else {
                                    completion(coordinates)
                                }
                            }
                        } catch {
                            let config = ConfigAlert(title: "Ошибка", message: error.localizedDescription, type: .alert, actions: [])
                            CustomAlert().showAlert(config: config)
                            completion(coordinates)
                        }
                    }
                } else {
                    // Пустое тело ответа: без этой ветки completion не вызывался и карта не открывалась молча
                    let config = ConfigAlert(title: "Ошибка", message: "Сервер вернул пустой ответ (код \(statusCode))", type: .alert, actions: [])
                    CustomAlert().showAlert(config: config)
                    completion(coordinates)
                }

            case .failure(let error):
                let config = ConfigAlert(title: "Ошибка", message: error.localizedDescription, type: .alert, actions: [])
                CustomAlert().showAlert(config: config)
                completion(coordinates)
            }
        }
    }
    
    
}

