//
//  restoranView.swift
//  remitApp_main
//
//  Created by Егор Голубев on 01.11.2025.
//

import UIKit
import SnapKit

class restoranView: UIView {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let safeView: UIView = {
        let titleSafeView = UIView()
        titleSafeView.backgroundColor = .red
        return titleSafeView
    }()
    
    private lazy var headSection: UILabel = {
        let label = UILabel()
        label.text = "МЕНЮ РЕСТОРАНА"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    
    private lazy var headLine: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    lazy var yesterdayButton: UIButton = {
        let button = UIButton()
        button.setTitle("Вчера", for: .normal)
        button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        button.tintColor  = .white
        button.layer.cornerRadius = 10
        button.tag = 1
        return button
    }()
    
    lazy var todayButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сегодня", for: .normal)
        button.backgroundColor = .red
        button.tintColor  = .white
        button.layer.cornerRadius = 10
        button.tag = 2
        return button
    }()
    
    lazy var tomorrowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Завтра", for: .normal)
        button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        button.tintColor  = .white
        button.layer.cornerRadius = 10
        button.tag = 3
        return button
    }()
    
    private lazy var stackUiButton: UIStackView = {
        
        let config = stackConfig(axis: .horizontal,
                                 spacing: 20,
                                 distribution: .fillEqually,
                                 arrangedSubviews: [yesterdayButton, todayButton, tomorrowButton])
        let stack = CustomStackView(config: config)
        return stack
    }()
    
    private let headView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setubUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setubUI() {
        
        [safeView, headView, scrollView].forEach { addSubview($0) }
        scrollView.addSubview(contentView)
        [headSection, headLine, stackUiButton].forEach { headView.addSubview($0) }
        
        safeView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.top)
        }
        
        headView.snp.makeConstraints {
            $0.top.equalTo(safeView.snp.bottom)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.height.equalTo(100)
        }
        
        headSection.snp.makeConstraints {
            $0.top.equalTo(headView.snp.top).inset(5)
            $0.centerX.equalTo(headView.snp.centerX)
        }
        
        headLine.snp.makeConstraints {
            $0.top.equalTo(headSection.snp.bottom).inset(-5)
            $0.left.equalTo(headView.snp.left)
            $0.right.equalTo(headView.snp.right)
            $0.height.equalTo(3)
        }
        
        stackUiButton.snp.makeConstraints {
            $0.top.equalTo(headLine.snp.bottom).inset(-10)
            $0.left.equalTo(headView.snp.left).inset(10)
            $0.right.equalTo(headView.snp.right).inset(10)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(headView.snp.bottom)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.bottom.equalTo(self.snp.bottom)
        }

        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView.snp.width)
        }
        
    }
    
    func createUI(arrayMenu: [menuItemResponseSheme]) {
        
        contentView.subviews.forEach { $0.removeFromSuperview() }
        
        guard !arrayMenu.isEmpty else { return }
        
        let desiredOrder = ["Завтраки", "Салаты", "Гарниры, каши", "Супы", "Мясо-рыбные изделия", "Напитки"]
        let groupedByType = Dictionary(grouping: arrayMenu, by: { $0.typeFood })
        let orderedKeys = Set(groupedByType.keys).sorted { keyA, keyB in
            if let indexA = desiredOrder.firstIndex(of: keyA),
               let indexB = desiredOrder.firstIndex(of: keyB) {
                return indexA < indexB
            }
            return true
        }
        
        var lastView: UIView? = nil
        
        for category in orderedKeys where category != "Вторые мясные блюда" {
            let headerLabel = UILabel()
            headerLabel.text = category
            headerLabel.font = UIFont.boldSystemFont(ofSize: 18)
            headerLabel.textAlignment = .center
            headerLabel.textColor = .black
            contentView.addSubview(headerLabel)
            
            headerLabel.snp.makeConstraints {
                if let lastView = lastView {
                    $0.top.equalTo(lastView.snp.bottom).offset(20)
                } else {
                    $0.top.equalTo(contentView.snp.top).offset(10)
                }
                $0.centerX.equalTo(contentView.snp.centerX)
            }
            
            var productsInCategory = groupedByType[category]!
            
            var previousProductLabel: UIView? = headerLabel
            
            for product in productsInCategory {
                let productLabel = UILabel()
                productLabel.text = product.product
                productLabel.font = UIFont.systemFont(ofSize: 16)
                productLabel.textColor = .black
                contentView.addSubview(productLabel)
                
                productLabel.snp.makeConstraints {
                    $0.top.equalTo(previousProductLabel?.snp.bottom ?? headerLabel.snp.bottom).offset(10)
                    $0.left.equalTo(contentView.snp.left).inset(10)
                    $0.right.equalTo(contentView.snp.right).inset(10)
                }
                
                previousProductLabel = productLabel
            }
            
            lastView = previousProductLabel ?? headerLabel
        }

        if let lastView = lastView {
            lastView.snp.makeConstraints {
                $0.bottom.equalTo(contentView.snp.bottom).offset(-20)
            }
        }
    }
    
}

