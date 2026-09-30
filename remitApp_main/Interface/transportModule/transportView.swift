//
//  transortView.swift
//  remitApp_main
//
//  Created by Егор Голубев on 21.10.2025.
//

import UIKit
import SnapKit

class transportView: UIView {

    private let safeView: UIView = {
        let titleSafeView = UIView()
        titleSafeView.backgroundColor = .red
        return titleSafeView
    }()
    
    private lazy var headSection: UILabel = {
        let label = UILabel()
        label.text = "РАСПИСАНИЕ ТРАНСПОРТА"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    
    private lazy var headLine: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    lazy var transportTable: UITableView = {
       let table = UITableView()
        table.estimatedRowHeight = 40
        table.rowHeight = UITableView.automaticDimension
        table.backgroundColor = .white
        return table
    }()
    
    lazy var busButton: UIButton = {
       let button = UIButton()
        button.setTitle("Автобус", for: .normal)
        button.backgroundColor = .red
        button.tintColor  = .white
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var microBusButton: UIButton = {
       let button = UIButton()
        button.setTitle("Микроавтобус", for: .normal)
        button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        button.tintColor  = .white
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var geoBusButton: UIButton = {
       let button = UIButton()
        button.setTitle("Узнать местоположение", for: .normal)
        button.backgroundColor = .red
        button.tintColor  = .white
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var stackUiButton: UIStackView = {
        
        let config = stackConfig(axis: .horizontal,
                                 spacing: 20,
                                 distribution: .fillEqually,
                                 arrangedSubviews: [busButton, microBusButton])
        let stack = CustomStackView(config: config)
        return stack
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
        
        [safeView, transportTable, stackUiButton, geoBusButton, headSection, headLine].forEach
        { addSubview($0) }
        
        safeView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.top)
        }
        
        headSection.snp.makeConstraints {
            $0.top.equalTo(safeView.snp.bottom).inset(-5)
            $0.centerX.equalTo(self.snp.centerX)
        }
        
        headLine.snp.makeConstraints {
            $0.top.equalTo(headSection.snp.bottom).inset(-5)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.height.equalTo(3)
        }
        
        stackUiButton.snp.makeConstraints {
            $0.top.equalTo(headLine.snp.bottom).inset(-10)
            $0.left.equalTo(self.snp.left).inset(10)
            $0.right.equalTo(self.snp.right).inset(10)
        }
        
        transportTable.snp.makeConstraints {
            $0.top.equalTo(stackUiButton.snp.bottom).inset(-10)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
        }
        
        geoBusButton.snp.makeConstraints {
            $0.top.equalTo(transportTable.snp.bottom).inset(-10)
            $0.left.equalTo(transportTable.snp.left).inset(15)
            $0.right.equalTo(transportTable.snp.right).inset(15)
            $0.bottom.equalTo(self.snp.bottom).inset(25)
        }
        
    }
    

}
