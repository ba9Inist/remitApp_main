//
//  restoranVC.swift
//  remitApp_main
//
//  Created by Егор Голубев on 01.11.2025.
//

import UIKit

class restoranVC: UIViewController {

    private var restoranViewInstance = restoranView()
    private let restoranModelInstance =  restoranModel()
    private var dateMenu = menuDate.self.today.rawValue
    private var menu: menuRestoranResponseSheme
    
    init(menu1С: menuRestoranResponseSheme ) {
        self.menu = menu1С
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = restoranViewInstance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        restoranViewInstance.yesterdayButton.addTarget(self, action: #selector(setubUI), for: .touchUpInside)
        restoranViewInstance.todayButton.addTarget(self, action: #selector(setubUI), for: .touchUpInside)
        restoranViewInstance.tomorrowButton.addTarget(self, action: #selector(setubUI), for: .touchUpInside)
        
        if !menu.error.isEmpty {
            CustomAlert().showFastAlertError(textError: menu.error)
        } else {
            createUI(tag: dateMenu)
        }
        
    }
    
    @objc private func setubUI(sender: UIButton) {
        dateMenu = sender.tag
        guard menuDate(rawValue: dateMenu) != nil else { return }
        createUI(tag: dateMenu)
    }
    
    private func createUI(tag: Int) {
        
        let buttons: [Int: UIButton] = [
            1: restoranViewInstance.yesterdayButton,
            2: restoranViewInstance.todayButton,
            3: restoranViewInstance.tomorrowButton
        ]
        
        
        let arrayMenu = menuResponse(yesterdaysMenu: menu.yesterdaysMenu ?? [menuItemResponseSheme](),
                                     todayMenu: menu.todayMenu ?? [menuItemResponseSheme](),
                                     tomorrowMenu: menu.tomorrowMenu ?? [menuItemResponseSheme]())
        
        
        let menu: [Int: [menuItemResponseSheme]] = [
            1: arrayMenu.yesterdaysMenu,
            2: arrayMenu.todayMenu,
            3: arrayMenu.tomorrowMenu
        ]

        for (_, button) in buttons {
            button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        }
        
        if let activeButton = buttons[tag] {
            activeButton.backgroundColor = .red
        }
        
        if let selectedMenu = menu[dateMenu] {
            restoranViewInstance.createUI(arrayMenu: selectedMenu)
        }
        
        
        
        
    }
    

}
