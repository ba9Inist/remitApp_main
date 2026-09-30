//
//  checkVCViewController.swift
//  remitApp_main
//
//  Created by Егор Голубев on 27.02.2026.
//

import UIKit

class checkVC: UIViewController {
    
    var dataCheck: dataCheck
    private let checkViewInstance = checkView()
    private let loalityModel = loyalityModel()
    
    init(dataCheck: dataCheck) {
        self.dataCheck = dataCheck
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        let formattedDate = formatter.string(from: dataCheck.dateCheck)
        self.checkViewInstance.addressStore.text = "Адрес покупки: \n\(dataCheck.addressStore)"
        self.checkViewInstance.dateCheck.text = "Дата покупки \(formattedDate)"
        self.checkViewInstance.checkАmount.text = "Сумма покупки: \(dataCheck.checkАmount) руб."
        if dataCheck.likeCount < 0 {
            let likes  = -Int(dataCheck.likeCount)
            let sumRub = Int(Double(likes) * 2.5)
            self.checkViewInstance.likeCount.text = "Потрачено лайков: \(likes) (\(sumRub) руб.)"
        } else {
            let likes  = Int(dataCheck.likeCount)
            let sumRub = Int(Double(likes) * 2.5)
            self.checkViewInstance.likeCount.text = "Начислено лайков: \(likes) (\(sumRub) руб.)"
        }
        self.checkViewInstance.head.text = "Покупка от \(formattedDate)"
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = checkViewInstance
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        checkViewInstance.productsList.dataSource = self
        checkViewInstance.productsList.delegate = self
        
        checkViewInstance.productsList.register(productCell.self,
                                                forCellReuseIdentifier: productCell.reuseIdentifier)
    }
    
}

extension checkVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCheck.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: productCell.reuseIdentifier,
            for: indexPath
        ) as! productCell
        
        let elementTable = dataCheck.products[indexPath.row]
        cell.configure(dataCell: elementTable)
        
        return cell
    }
}

