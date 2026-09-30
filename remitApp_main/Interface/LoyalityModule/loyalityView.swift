//
//  loyalityView.swift
//  remitApp_main
//
//  Created by Егор Голубев on 21.02.2026.
//

import UIKit
import SnapKit

class loyalityView: UIView {
    
    private let safeView: UIView = {
        let titleSafeView = UIView()
        titleSafeView.backgroundColor = .red
        return titleSafeView
    }()
    
    private let headViev: UILabel = {
        let label = UILabel()
        label.text = "ЛОЯЛЬНОСТЬ"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    
    private let headLine: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    var barcodeCard: UIImageView = {
        let img = UIImageView()
        img.isUserInteractionEnabled = true
        return img
    }()
    
    var numberCard: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    var balanceCard: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Баланс лайков: "
        return label
    }()
    
//    var headShoppingList: UILabel = {
//        let label = UILabel()
//        label.textColor = .black
//        label.font = UIFont.boldSystemFont(ofSize: 20)
//        label.text = "ВАШИ ПОКУПКИ"
//        return label
//    }()
    
    var shoppingList: UITableView = {
        let table = UITableView()
        table.estimatedRowHeight = 150
        table.rowHeight = UITableView.automaticDimension
        table.backgroundColor = .white
        table.separatorStyle = .none
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
        [safeView, barcodeCard, headViev, headLine, numberCard, balanceCard, shoppingList].forEach
        { addSubview($0) }
        
        safeView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.top)
        }
        
        headViev.snp.makeConstraints {
            $0.top.equalTo(safeView.snp.bottom).inset(-5)
            $0.centerX.equalTo(self.snp.centerX)
        }
        
        headLine.snp.makeConstraints {
            $0.top.equalTo(headViev.snp.bottom).inset(-5)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.height.equalTo(3)
        }
        
        balanceCard.snp.makeConstraints {
            $0.top.equalTo(headLine.snp.bottom).inset(-20)
            $0.left.equalTo(self.snp.left).inset(20)
            $0.height.equalTo(20)
        }
        
        barcodeCard.snp.makeConstraints {
            $0.top.equalTo(balanceCard.snp.bottom)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.height.equalTo(100)
        }
        
        numberCard.snp.makeConstraints {
            $0.top.equalTo(barcodeCard.snp.bottom).inset(5)
            $0.centerX.equalTo(self.snp.centerX)
        }
        

//        headShoppingList.snp.makeConstraints {
//            $0.top.equalTo(balanceCard.snp.bottom).inset(-5)
//            $0.centerX.equalTo(self.snp.centerX)
//        }
        
        shoppingList.snp.makeConstraints {
            $0.top.equalTo(numberCard.snp.bottom)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.bottom.equalTo(self.snp.bottom)
        }
        
        
        
    }
    
}
