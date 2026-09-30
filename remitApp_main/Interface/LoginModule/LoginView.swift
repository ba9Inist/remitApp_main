//
//  LoginView.swift
//  remitApp_main
//
//  Created by Егор Голубев on 10.06.2025.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    private let safeView: UIView = {
        let titleSafeView = UIView()
        titleSafeView.backgroundColor = .red
        return titleSafeView
    }()
    
    var numberUser: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "  Номер телефона"
        textfield.keyboardType = .phonePad
        textfield.returnKeyType = .next
        textfield.layer.cornerRadius = 10
        textfield.layer.borderWidth = 1.0
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.text = "79779643315"
        textfield.textColor = .black
        return textfield
    }()
    
    var codeAuth: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "  Код смс"
        textfield.keyboardType = .numberPad
        textfield.returnKeyType = .done
        textfield.layer.cornerRadius = 10
        textfield.layer.borderWidth = 1.0
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.autocapitalizationType = .none
        textfield.textContentType = .oneTimeCode
        textfield.text = "testpass"
        textfield.textColor = .black
        return textfield
    }()
    
    lazy var buttonAuth: UIButton = {
        let config = ButtonConfig(title: "Прислать код",
                                  backgroundColor: .red,
                                  systemIconName: nil,
                                  tintColor: .white,
                                  imageEdgeInsets: nil,
                                  contentHorizontalAlignment: nil,
                                  contentVerticalAlignment: nil,
                                  targetSelectorPair: nil,
                                  cornerRadius: 10,
                                  tag: nil)
        let button = CustomButton(config: config)
        return button
    }()
    
    var messageRepeatCode: UITextField = {
        let textfield = UITextField()
        return textfield
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setubUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setubUI() {
        
        self.backgroundColor = .white
        [numberUser, buttonAuth, safeView, messageRepeatCode, codeAuth].forEach { addSubview($0) }
        
        safeView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.top)
        }
        
        numberUser.snp.makeConstraints {
            $0.centerX.equalTo(self.snp.centerX)
            $0.centerY.equalTo(self.snp.centerY)
            $0.left.equalTo(self.snp.left).inset(20)
            $0.right.equalTo(self.snp.right).inset(20)
            $0.height.equalTo(40)
        }
        
        codeAuth.snp.updateConstraints {
            $0.top.equalTo(numberUser.snp.bottom).inset(-20)
            $0.left.equalTo(self.snp.left).inset(20)
            $0.right.equalTo(self.snp.right).inset(20)
            $0.height.equalTo(40)
        }
        
        buttonAuth.snp.makeConstraints {
            $0.top.equalTo(codeAuth.snp.bottom).inset(-20)
            $0.left.equalTo(self.snp.left).inset(20)
            $0.right.equalTo(self.snp.right).inset(20)
        }
        
        messageRepeatCode.snp.makeConstraints {
            $0.top.equalTo(buttonAuth.snp.bottom).inset(-10)
            $0.centerX.equalTo(self.snp.centerX)
        }
    }

}
