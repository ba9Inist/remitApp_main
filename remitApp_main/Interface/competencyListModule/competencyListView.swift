//
//  competencyListView.swift
//  remitApp_main
//
//  Created by Егор Голубев on 17.10.2025.
//

import UIKit
import SnapKit

class competencyListView: UIView {
    
    private let safeZone: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let competencyTable: UITableView = {
        let table = UITableView()
        table.estimatedRowHeight = 40
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    private let customHeaderView: customHeaderCompetencyListView = {
        let header = customHeaderCompetencyListView()
        return header
    }()
    
    
    lazy var competencyEmpty: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .darkGray
        label.text = "Список компетенций пуст"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setubUI()
        competencyTable.tableHeaderView = customHeaderView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setubUI() {
        
        self.backgroundColor = .systemBackground
        
        [competencyTable, safeZone].forEach{addSubview($0)}
        
        competencyTable.snp.makeConstraints {
            $0.top.equalTo(safeZone.snp.bottom)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.bottom.equalTo(self.snp.bottom)
        }
        
        safeZone.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.top)
        }
        
    }
    
    func setubCompetencyEmpty() {
        addSubview(competencyEmpty)
        
        competencyEmpty.snp.makeConstraints {
            $0.centerX.equalTo(self.snp.centerX)
            $0.centerY.equalTo(self.snp.centerY)
        }
    }
    
}
