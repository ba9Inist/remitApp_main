//
//  ChatVC.swift
//  remitApp_main
//
//  Created by Егор Голубев on 17.06.2025.
//

import UIKit

class ChatVC: UIViewController {

    private let chatView = ChatView()
    
    override func loadView() {
        view = chatView
    }
    
    override func viewDidLoad() {
        navigationController?.navigationBar.tintColor = .white
    }
}
