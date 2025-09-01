//
//  VacationView.swift
//  remitApp_main
//
//  Created by Егор Голубев on 06.06.2025.
//

import UIKit
import SnapKit

class VacationView: UIView {
    
    weak var delegate: VacationViewDelegate?
    
    private let backgroundSafeZone: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let vacationTable: UITableView = {
        let table = UITableView()
        table.rowHeight = 40
        return table
    }()
    
    let backgroundStatement: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private lazy var labelDateKey: UILabel = {
        let label = UILabel()
        label.text = "Дата начала:"
        label.textColor = .black
        label.font = UIFont(name: "", size: 16)
        return label
    }()
    
    private let headView: UILabel = {
        let label = UILabel()
        label.text = "ЗАЯВЛЕНИЕ НА ОТПУСК"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    
    private lazy var buttonDate: UIButton = {
        let config = ButtonConfig(title: nil,
                                  backgroundColor: nil,
                                  systemIconName: "calendar",
                                  tintColor: .black,
                                  imageEdgeInsets: nil,
                                  contentHorizontalAlignment: nil,
                                  contentVerticalAlignment: nil,
                                  targetSelectorPair: (target: self, selector: #selector(tapCalendar)),
                                  cornerRadius: 10, tag: nil)
        let button = CustomButton(config: config)
        return button
    }()
    
    
    lazy var labelDateValue: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "", size: 16)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackDate: UIStackView = {
        let config = stackConfig(axis: .horizontal,
                                 spacing: 5,
                                 distribution: .fillEqually,
                                 arrangedSubviews: [labelDateKey, buttonDate, labelDateValue])
        let stack = CustomStackView(config:  config)
        return stack
    }()
    
    private lazy var labelQuantDay: UILabel = {
        let label = UILabel()
        label.text = "Количество дней:"
        label.textColor = .black
        label.font = UIFont(name: "", size: 16)
        return label
    }()
    
    lazy var quantDay: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.inputAccessoryView = createInputAccessoryView()
        textField.borderStyle = .none
        return textField
    }()
    
    private lazy var stackQuant: UIStackView = {
        let config = stackConfig(axis: .horizontal,
                                 spacing: 5,
                                 distribution: .fillEqually,
                                 arrangedSubviews: [labelQuantDay, quantDay])
        let stack = CustomStackView(config: config)
        return stack
    }()
    
    private lazy var buttonVacation: UIButton = {
        let config = ButtonConfig(title: "Отправить на согласование",
                                  backgroundColor: .red,
                                  systemIconName: nil,
                                  tintColor: nil,
                                  imageEdgeInsets: nil,
                                  contentHorizontalAlignment: nil,
                                  contentVerticalAlignment: nil,
                                  targetSelectorPair: (target: self, selector: #selector(tapButtonVacation)),
                                  cornerRadius: 10, tag: nil)
        let button = CustomButton(config: config)
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
        
        self.backgroundColor = .systemBackground
        
        [vacationTable, backgroundStatement, backgroundSafeZone].forEach{addSubview($0)}
        [headView, stackDate, stackQuant, buttonVacation].forEach {backgroundStatement.addSubview($0)}
        
        vacationTable.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.bottom.equalTo(backgroundStatement.snp.top)
        }
        
        backgroundStatement.snp.makeConstraints {
            $0.top.equalTo(vacationTable.snp.bottom)
            $0.bottom.equalTo(self.snp.bottom)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
        }
        
        backgroundSafeZone.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.top)
        }
        
        headView.snp.makeConstraints {
            $0.top.equalTo(backgroundStatement.snp.top).inset(10)
            $0.centerX.equalTo(backgroundStatement.snp.centerX)
        }
        
        stackDate.snp.makeConstraints {
            $0.top.equalTo(headView.snp.bottom).inset(-10)
            $0.left.equalTo(backgroundStatement.snp.left).inset(20)
            $0.right.equalTo(backgroundStatement.snp.right).inset(20)
        }
        
        stackQuant.snp.makeConstraints {
            $0.top.equalTo(stackDate.snp.bottom).inset(-10)
            $0.left.equalTo(backgroundStatement.snp.left).inset(20)
            $0.right.equalTo(backgroundStatement.snp.right).inset(20)
        }
        
        buttonVacation.snp.makeConstraints {
            $0.top.equalTo(stackQuant.snp.bottom).inset(-10)
            $0.left.equalTo(backgroundStatement.snp.left).inset(20)
            $0.right.equalTo(backgroundStatement.snp.right).inset(20)
            $0.bottom.equalTo(backgroundStatement.snp.bottom).inset(50)
        }
        
    }
    
    @objc private func tapCalendar() {
        
        delegate?.didSelectDate()
    }
    
    @objc private func tapButtonVacation() {
        delegate?.didSelectButtonVacation()
    }
    
    @objc private func doneButtonTapped() {
        delegate?.didSelectButtonDoneKeyboard()
    }
    
    private func createInputAccessoryView() -> UIView {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        return toolbar
    }
    
}
