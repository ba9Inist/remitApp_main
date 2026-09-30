//
//  customHeaderCompetencyListView.swift
//  remitApp_main
//
//  Created by Егор Голубев on 17.10.2025.
//

import UIKit
import SnapKit

class customHeaderCompetencyListView: UIView {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Список компетенций сотрудника"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .systemGray2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setubUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setubUI() {
        self.addSubview(titleLabel)
        self.backgroundColor = .systemBackground
        
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(self.snp.bottom)
        }
        
    }
}
