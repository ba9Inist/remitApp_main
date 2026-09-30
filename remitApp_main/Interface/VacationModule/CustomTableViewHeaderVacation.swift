//
//  CustomTableViewHeaderVacation.swift
//  remitApp_main
//
//  Created by Егор Голубев on 03.10.2025.
//

import UIKit
import SnapKit

class CustomTableViewHeaderVacation: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .systemGray2
        return label
    }()
    
    private let realm = realmManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setubUI()
        if let dataUser = realm.fetchUser() {
            titleLabel.text = "КОЛИЧЕСТВО ДОСТУПНЫХ ДНЕЙ: " + dataUser.daysVacation.description
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setubUI() {
        self.addSubview(titleLabel)
        self.backgroundColor = .white
        
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(self.snp.bottom)
        }
        
    }
    
}
