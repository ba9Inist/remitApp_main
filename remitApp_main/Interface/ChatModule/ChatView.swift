//
//  ChatView.swift
//  remitApp_main
//
//  Created by Егор Голубев on 17.06.2025.
//

import UIKit
import SnapKit

class ChatView: UIView {
    
    private let safeView: UIView = {
        let titleSafeView = UIView()
        titleSafeView.backgroundColor = .red
        return titleSafeView
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 40
        return tableView
    }()
    
    private var backgroundMessage: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    var textMessage : UITextField = {
        let textField = UITextField()
        textField.placeholder = "  Введите сообщение"
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.keyboardType = .default
        textField.backgroundColor = .systemGray3
        return textField
    }()
    
    var sendMessage: UIButton = {
        var config = ButtonConfig(title: "",
                                  backgroundColor: .red,
                                  systemIconName: "arrow.up.circle",
                                  tintColor: .white,
                                  imageEdgeInsets: nil,
                                  contentHorizontalAlignment: .fill,
                                  contentVerticalAlignment: .fill,
                                  targetSelectorPair: nil,
                                  cornerRadius: 15,
                                  tag: nil)
        let button = CustomButton(config: config)
        button.clipsToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setubUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setubUI() {
        backgroundColor = .systemBackground
        [tableView, backgroundMessage, safeView].forEach { addSubview($0)}
        [textMessage, sendMessage].forEach {backgroundMessage.addSubview($0)}
        
        safeView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.top)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.bottom.equalTo(backgroundMessage.snp.top)
        }
        
        backgroundMessage.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom)
            $0.bottom.equalTo(self.snp.bottom)
            $0.right.equalTo(self.snp.right)
            $0.left.equalTo(self.snp.left)
            $0.height.equalTo(100)
        }
        
        textMessage.snp.makeConstraints {
            $0.centerY.equalTo(backgroundMessage.snp.centerY)
            $0.left.equalTo(backgroundMessage.snp.left).inset(15)
            $0.right.equalTo(backgroundMessage.snp.right).inset(60)
            $0.height.equalTo(40)
        }
        
        sendMessage.snp.makeConstraints {
            $0.centerY.equalTo(backgroundMessage.snp.centerY)
            $0.left.equalTo(textMessage.snp.right).inset(-5)
            $0.right.equalTo(backgroundMessage.snp.right).inset(5)
            $0.height.equalTo(40)
            $0.width.equalTo(40)
        }
        
    }
    
}
