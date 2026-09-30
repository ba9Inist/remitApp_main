//
//  CustomDatePickerVC.swift
//  remitApp_main
//
//  Created by Егор Голубев on 05.06.2025.
//

import UIKit
import SnapKit

class CustomDatePickerVC: UIViewController {
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        if #available(iOS 14.0, *) {
            picker.preferredDatePickerStyle = .inline
        } else {
            picker.preferredDatePickerStyle = .wheels
            picker.setValue(UIColor.black, forKey: "textColor")
        }
        picker.layer.cornerRadius = 10
        picker.locale = Locale(identifier: "ru_RU")
        picker.minimumDate = Date()
        picker.maximumDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())
        picker.backgroundColor = .white
        return picker
    }()
    
    private lazy var buttonDone: UIButton = {
        let config = ButtonConfig(title: "Готово",
                                  backgroundColor: nil,
                                  systemIconName: nil,
                                  tintColor: nil,
                                  imageEdgeInsets: nil,
                                  contentHorizontalAlignment: nil,
                                  contentVerticalAlignment: nil,
                                  targetSelectorPair: (target: self, selector: #selector(tapButton(sender:))),
                                  cornerRadius: nil,
                                  tag: nil)
        let button = CustomButton(config: config)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var buttonCancel: UIButton = {
        let config = ButtonConfig(title: "Отмена",
                                  backgroundColor: nil,
                                  systemIconName: nil,
                                  tintColor: nil,
                                  imageEdgeInsets: nil,
                                  contentHorizontalAlignment: nil,
                                  contentVerticalAlignment: nil,
                                  targetSelectorPair: (target: self, selector: #selector(tapButton(sender:))),
                                  cornerRadius: nil,
                                  tag: nil)
        let button = CustomButton(config: config)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var stackButton: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [buttonCancel, buttonDone])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var viewBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    var completion: ((Date) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        addSubviews()
    }
    
    private func addSubviews() {
        view.addSubview(viewBackground)
        viewBackground.addSubview(datePicker)
        viewBackground.addSubview(stackButton)
        
        viewBackground.snp.makeConstraints {
            $0.left.equalTo(datePicker.snp.left)
            $0.right.equalTo(datePicker.snp.right)
            $0.top.equalTo(datePicker.snp.top)
            $0.bottom.equalTo(stackButton.snp.bottom)
        }
        
        datePicker.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY)
        }
        
        stackButton.snp.makeConstraints {
            $0.top.equalTo(datePicker.snp.bottom).inset(-10)
            $0.left.equalTo(viewBackground.snp.left).inset(5)
            $0.right.equalTo(viewBackground.snp.right).inset(5)
        }
    }
    
    @objc private func tapButton(sender: UIButton) {
        if sender.title(for: .normal) == "Готово" {
            completion?(datePicker.date)
            dismiss(animated: true, completion: nil)
        }else {
            dismiss(animated: true, completion: nil)
        }
    }    
}

