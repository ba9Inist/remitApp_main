//
//  SberVC.swift
//  remitApp_main
//
//  Created by Егор Голубев on 16.10.2025.
//

import UIKit
import RealmSwift

class SberVC: UIViewController {
    
    let realm = realmManager()
    private var sberView: SberView
    init() {
        self.sberView = SberView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        view = sberView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        loadDataRealm()
    }
    
    private func loadDataRealm() {
        if let dataUser = realm.fetchUser() {
            sberView.welcomeTextDms.text = dataUser.welcomeTextDms
            if !dataUser.dms.isEmpty {
                let dataDms = dataUser.dms[0]
                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM.yyyy"
                let dateStringStart = formatter.string(from: dataDms.startDate)
                let dateStringFinish = formatter.string(from: dataDms.endDate)
                sberView.promoDms.text = "Ваш промокод: \(dataDms.code.description)"
                sberView.startDateDms.text = "Дата активации ДМС: \(dateStringStart)"
                sberView.finishDateDms.text = "Дата действия ДМС: \(dateStringFinish)"
                sberView.instructionDms.text = dataDms.instruction
                sberView.setubPromoUIUser()
            }
        }
    }
    
}
