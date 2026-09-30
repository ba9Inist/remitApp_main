//
//  checkView.swift
//  remitApp_main
//
//  Created by Егор Голубев on 27.02.2026.
//

import UIKit
import SnapKit

class checkView: UIView {
    
    let head: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .black
        return label
    }()
    
    private let headLine: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let addressStore: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    let dateCheck: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.isHidden = true
        return label
    }()
    
    let checkАmount: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    let likeCount: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    var productsList: UITableView = {
        let table = UITableView()
        table.estimatedRowHeight = 140
        table.rowHeight = UITableView.automaticDimension
        table.backgroundColor = .white
        //table.separatorStyle = .none
        return table
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
        [addressStore, checkАmount, likeCount, productsList, head, headLine].forEach
        { addSubview($0) }

        head.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(10)
            $0.centerX.equalTo(self.snp.centerX)
        }
        
        addressStore.snp.makeConstraints {
            $0.top.equalTo(head.snp.bottom).inset(-25)
            $0.left.equalTo(self.snp.left).inset(10)
            $0.right.equalTo(self.snp.right).inset(10)
        }
        
        checkАmount.snp.makeConstraints {
            $0.top.equalTo(addressStore.snp.bottom).inset(-15)
            $0.left.equalTo(self.snp.left).inset(10)
            $0.height.equalTo(20)
        }
        
        likeCount.snp.makeConstraints {
            $0.top.equalTo(checkАmount.snp.bottom).inset(-15)
            $0.left.equalTo(self.snp.left).inset(10)
            $0.height.equalTo(20)
        }
        
        headLine.snp.makeConstraints {
            $0.top.equalTo(likeCount.snp.bottom).inset(-10)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.height.equalTo(3)
        }
        
        productsList.snp.makeConstraints {
            $0.top.equalTo(headLine.snp.bottom)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.bottom.equalTo(self.snp.bottom)
        }
        
    }
    
    
    
}
