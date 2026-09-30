//
//  productCell.swift
//  remitApp_main
//
//  Created by Егор Голубев on 27.02.2026.
//

import UIKit
import SnapKit

class productCell: UITableViewCell {
    
    static let reuseIdentifier = "CustomTableViewCell"
    private let networkManagerInstance = NetworkManager.shared
    
    private let imgProduct: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .lightGray
        img.clipsToBounds = true
        img.layer.cornerRadius = 10
        img.contentMode = .scaleToFill
        img.isUserInteractionEnabled = true
        return img
    }()
    
    private let nameProduct: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let quantity: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let price: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private  let amount: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
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
        
        [imgProduct, nameProduct, quantity, price, amount].forEach
        { contentView.addSubview($0)}
        
        imgProduct.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).inset(10)
            $0.left.equalTo(contentView.snp.left).inset(10)
            //$0.height.equalTo(125)
            $0.width.equalTo(125)
            //$0.centerY.equalTo(contentView.snp.centerY)
            $0.bottom.equalTo(contentView.snp.bottom).inset(10)
        }
        
        nameProduct.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).inset(10)
            $0.left.equalTo(imgProduct.snp.right).inset(-10)
            $0.right.equalTo(contentView.snp.right).inset(10)
        }
        
        quantity.snp.makeConstraints {
            $0.top.equalTo(nameProduct.snp.bottom).inset(-10)
            $0.left.equalTo(imgProduct.snp.right).inset(-10)
        }
        
        price.snp.makeConstraints {
            $0.top.equalTo(quantity.snp.bottom).inset(-10)
            $0.left.equalTo(imgProduct.snp.right).inset(-10)
        }
        
        amount.snp.makeConstraints {
            $0.top.equalTo(price.snp.bottom).inset(-10)
            $0.left.equalTo(imgProduct.snp.right).inset(-10)
            $0.bottom.equalTo(contentView.snp.bottom).inset(10)
        }
    }
    
    func configure(dataCell: ProductSheme ) {
        
        nameProduct.text = dataCell.product
        
        if dataCell.weight {
            quantity.text = "Количество: \(String(dataCell.quantity)) кг"
            price.text = "Цена за кг: \(String(dataCell.price)) ₽"
        } else {
            quantity.text = "Количество: \(String(dataCell.quantity)) шт"
            price.text = "Цена за шт: \(String(dataCell.price)) ₽"
        }

        amount.text = "Итоговая цена: \(String(dataCell.amount)) ₽"
        
        if !dataCell.refImgProduct.isEmpty {
            networkManagerInstance.setubHeadImageView(urlString: dataCell.refImgProduct) { img in
                DispatchQueue.main.async {
                    if img != nil {
                        self.imgProduct.image = img
                    } else {
                        self.imgProduct.image = UIImage(systemName: "xmark.seal.fill")
                        self.imgProduct.tintColor = .white
                    }
                }
            }
        } else {
            imgProduct.image = UIImage(systemName: "xmark.seal.fill")
            imgProduct.tintColor = .white
        }
        
    }
}


