//
//  CustomTableViewCellVacation.swift
//  remitApp_main
//
//  Created by Егор Голубев on 02.10.2025.
//

import UIKit
import SnapKit


class CustomTableViewCellVacation: UITableViewCell {
    
    static let reuseIdentifier = "CustomTableViewCell"
    
    private lazy var headVacation: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
   
    private lazy var backheadVacation: UIView = {
        let view = UIView()
        return view
    }()
   
    private lazy var startVacationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
   
    private lazy var endVacationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
   
    private lazy var stackUiLabel: UIStackView = {
        let config = stackConfig(axis: .vertical,
                                 spacing: 10,
                                 distribution: .fillEqually,
                                 arrangedSubviews: [startVacationLabel, endVacationLabel])
        let stack = CustomStackView(config: config)
        return stack
    }()
    
    private lazy var daysVacation: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundView?.backgroundColor = .white
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        [backheadVacation,headVacation, stackUiLabel, daysVacation].forEach{contentView.addSubview($0)}
        
        let contentSnp = contentView.snp
        
        backheadVacation.snp.makeConstraints {
            $0.top.equalTo(contentSnp.top)
            $0.left.equalTo(contentSnp.left)
            $0.right.equalTo(contentSnp.right)
            $0.height.equalTo(16)
        }
        
        headVacation.snp.makeConstraints {
            $0.left.equalTo(backheadVacation.snp.left)
            $0.right.equalTo(backheadVacation.snp.right)
            $0.top.equalTo(backheadVacation.snp.top)
            $0.bottom.equalTo(backheadVacation.snp.bottom)
        }
    
        stackUiLabel.snp.makeConstraints {
            $0.top.equalTo(backheadVacation.snp.bottom).inset(-10)
            $0.left.equalTo(contentSnp.left)
            $0.right.equalTo(contentSnp.right).inset(50)
            $0.bottom.equalTo(contentSnp.bottom).inset(10)
        }
        daysVacation.snp.makeConstraints {
            $0.centerY.equalTo(contentSnp.centerY)
            $0.left.equalTo(stackUiLabel.snp.right)
            $0.right.equalTo(contentSnp.right)
        }
        
    }

    func configure(startDate: Date, endDate: Date, vacationDays: Int, pastVacation: Bool) {
        
        backheadVacation.backgroundColor = pastVacation == true ? .systemGray : UIColor(named: "customGreen")
        headVacation.text = pastVacation == true ? "Запланированный отпуск" : "Прошедший отпуск"
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let formattedDateStart = formatter.string(from: startDate)
        let formattedDateEnd = formatter.string(from: endDate)
        startVacationLabel.text = "Начало отпуска: " + formattedDateStart
        endVacationLabel.text   = "Конец отпуска: " + formattedDateEnd
        daysVacation.text = vacationDays.description + " дн."
    }
}
