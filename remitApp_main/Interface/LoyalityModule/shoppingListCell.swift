//
//  shoppingListCellTableViewCell.swift
//  remitApp_main
//
//  Created by Егор Голубев on 25.02.2026.
//

import UIKit

class ShoppingListCell: UITableViewCell {
    
    static let reuseIdentifier = "CustomTableViewCell"
    
    var dataCheckInstance: dataCheck = dataCheck(checkАmount: 0,
                                                 dateCheck: Date(),
                                                 likeCount: 0,
                                                 addressStore: "",
                                                 products: [])
    
    weak var delegate: ShoppingListCellDelegate?
    
    private let viewMain: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 10
        view.layer.masksToBounds = false
        return view
    }()
    
    private let addressStore: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private let dateCheck: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private lazy var buttonCheckProducts: UIButton = {
        let button = UIButton()
        button.setTitle("Подробнее", for: .normal)
        button.addTarget(self, action: #selector(checkProducts), for: .touchUpInside)
        button.backgroundColor = .customGray
        button.layer.cornerRadius = 10
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        contentView.backgroundColor = .white
        contentView.addSubview(viewMain)
        
        [addressStore, dateCheck, buttonCheckProducts].forEach
        { viewMain.addSubview($0)}
        
        viewMain.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).inset(10)
            $0.left.equalTo(contentView.snp.left).inset(10)
            $0.right.equalTo(contentView.snp.right).inset(10)
            $0.bottom.equalTo(contentView.snp.bottom).inset(10)
            $0.height.equalTo(150)
            
        }
        
        addressStore.snp.makeConstraints {
            $0.top.equalTo(viewMain.snp.top).inset(30)
            $0.left.equalTo(viewMain.snp.left).inset(10)
            $0.height.equalTo(16)
        }
        
        dateCheck.snp.makeConstraints {
            $0.top.equalTo(addressStore.snp.bottom).inset(-20)
            $0.left.equalTo(viewMain.snp.left).inset(10)
            $0.height.equalTo(16)
        }
        
        buttonCheckProducts.snp.makeConstraints {
            $0.top.equalTo(dateCheck.snp.bottom).inset(-20)
            $0.left.equalTo(contentView.snp.left).inset(50)
            $0.right.equalTo(contentView.snp.right).inset(50)
            $0.bottom.equalTo(viewMain.snp.bottom).inset(10)
            //$0.height.equalTo(25)
        }
        
    }
    
    func configure(dataCell: dataCheck ) {
        
        addressStore.text = dataCell.addressStore
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy HH:mm"
        let formattedDate = formatter.string(from: dataCell.dateCheck)
        dateCheck.text   = "Дата покупки: \(formattedDate)"
        dataCheckInstance = dataCell
        
    }
    
    @objc private func checkProducts() {
        
        if !dataCheckInstance.products.isEmpty {
            delegate?.didSelectProductDetails(dataCell: dataCheckInstance)
        }
        
    }
    
}

protocol ShoppingListCellDelegate: AnyObject {
    func didSelectProductDetails(dataCell: dataCheck)
}
