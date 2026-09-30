//
//  transortVC.swift
//  remitApp_main
//
//  Created by Егор Голубев on 21.10.2025.
//

import UIKit

class transortVC: UIViewController {
    
    private var transportViewInstance: transportView
    weak var coordinator: MainCoordinator?
    private let transportModelInstance = transportModel()
    var busArray = [transportRoute]()
    var microBusArray = [transportRoute]()
    var busSchedule: Bool = true
    
    init() {
        self.transportViewInstance = transportView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = transportViewInstance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        
        transportViewInstance.transportTable.dataSource = self
        transportViewInstance.transportTable.delegate = self
        
        transportViewInstance.transportTable.register(transportTableCell.self,
                                                      forCellReuseIdentifier: transportTableCell.reuseIdentifier)
        
        transportModelInstance.getScheduleBus { [weak self] schedules in
            DispatchQueue.main.async {
                guard let self = self else { return }

                // Очищаем перед наполнением: иначе повторная загрузка дублировала строки
                self.busArray.removeAll()
                self.microBusArray.removeAll()

                for route in schedules {
                    if route.bus {
                        self.busArray.append(route)
                    } else {
                        self.microBusArray.append(route)
                    }
                }

                self.transportViewInstance.transportTable.reloadData()
            }
        }
        
        transportViewInstance.busButton.addTarget(self, action: #selector(setubBusTable), for: .touchUpInside)
        transportViewInstance.microBusButton.addTarget(self, action: #selector(setubMicroBusTable), for: .touchUpInside)
        transportViewInstance.geoBusButton.addTarget(self, action: #selector(slowMapBus), for: .touchUpInside)
        
    }
    
    
    @objc private func setubBusTable() {
        switchSchedule(bus: true)
    }
    
    
    @objc private func setubMicroBusTable() {
        switchSchedule(bus: false)
    }
    
    private func switchSchedule(bus: Bool) {
        busSchedule = bus
        if bus {
            transportViewInstance.busButton.backgroundColor =  .red
            transportViewInstance.microBusButton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        } else {
            transportViewInstance.busButton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            transportViewInstance.microBusButton.backgroundColor = .red
        }
        transportViewInstance.transportTable.reloadData()
    }
    
    
    @objc private func slowMapBus() {
        transportModelInstance.coordinateTransport(bus: busSchedule) { coordinates in
            DispatchQueue.main.async {
                if coordinates.latitude != 0 && coordinates.longitude != 0 {
                    let mapVC = mapTransport(latitude: coordinates.latitude, longitude: coordinates.longitude)
                    let navController = UINavigationController(rootViewController: mapVC)
                    navController.navigationBar.prefersLargeTitles = false
                    let closeItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(self.dismissMapVC))
                    mapVC.navigationItem.leftBarButtonItem = closeItem
                    navController.modalPresentationStyle = .pageSheet
                    navController.modalTransitionStyle = .coverVertical
                    self.present(navController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func dismissMapVC() {
        dismiss(animated: true, completion: nil)
    }
    
}


extension transortVC: UITableViewDelegate {
    
}

extension transortVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countTable: Int = 0
        if busSchedule {
            if !busArray.isEmpty {
                countTable = busArray[0].dataRoute.count
            }
            
        } else {
            if !microBusArray.isEmpty {
                countTable = microBusArray[0].dataRoute.count
            }
        }
        return countTable
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: transportTableCell.reuseIdentifier,
            for: indexPath
        ) as! transportTableCell
        
        var elementSchedule: transportRoute?
        
        if busSchedule {
            elementSchedule = busArray.first
        } else {
            elementSchedule = microBusArray.first
        }
        
        guard let elementSchedule = elementSchedule else {
            return cell
        }
        
        let elementRoute = elementSchedule.dataRoute[indexPath.row]
        let dataCell = routeCellData(
            idRoute1C: elementSchedule.idRoute1C,
            bus: elementSchedule.bus,
            idTransportationStop1C: elementRoute.idTransportationStop1C,
            nameTransportationStop: elementRoute.nameTransportationStop,
            countPeopleTransportationStop: elementRoute.countPeopleTransportationStop,
            time: elementRoute.time
        )
        
        cell.configure(dataCell: dataCell)
        cell.delegate = self

        return cell
    }


}

// MARK: - TransportCellDelegate

extension transortVC: TransportCellDelegate {

    func didConfirmWaiting(for cell: transportTableCell, dataRoute: routeCellData) {
        guard let indexPath = transportViewInstance.transportTable.indexPath(for: cell) else { return }

        transportModelInstance.signUpForStop(dataRoute: dataRoute) { [weak self] waitingPeople in
            DispatchQueue.main.async {
                guard let self = self else { return }

                // Обновляем только ту остановку, на которую записались.
                // Раньше ячейка обнуляла счётчик у всех остальных остановок во всех
                // маршрутах, хотя это число всех ожидающих, а не только текущего
                // пользователя, — данные по другим остановкам просто исчезали с экрана.
                let routeIndex = 0
                if self.busSchedule {
                    guard self.busArray.indices.contains(routeIndex),
                          self.busArray[routeIndex].dataRoute.indices.contains(indexPath.row) else { return }
                    self.busArray[routeIndex].dataRoute[indexPath.row].countPeopleTransportationStop = waitingPeople
                } else {
                    guard self.microBusArray.indices.contains(routeIndex),
                          self.microBusArray[routeIndex].dataRoute.indices.contains(indexPath.row) else { return }
                    self.microBusArray[routeIndex].dataRoute[indexPath.row].countPeopleTransportationStop = waitingPeople
                }

                self.transportViewInstance.transportTable.reloadRows(at: [indexPath], with: .none)
            }
        }
    }
}
