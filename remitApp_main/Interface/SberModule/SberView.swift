//
//  SberView.swift
//  remitApp_main
//
//  Created by Егор Голубев on 17.10.2025.
//

import UIKit
import SnapKit

class SberView: UIView {
    
    private let safeView: UIView = {
        let titleSafeView = UIView()
        titleSafeView.backgroundColor = .red
        return titleSafeView
    }()
    
    private let headSber: UIView = {
        let head = UIView()
        head.backgroundColor = UIColor(named: "customGreen")
        return head
    }()
    
    private var headLogo: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "headLogoSber")
        return img
    }()
    
    private let headSberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Корпоративное СберЗдоровье (ДМС)"
        return label
    }()
    
    private let headInstrView: UIView = {
        let head = UIView()
        head.backgroundColor = UIColor(named: "customGreen")
        return head
    }()
    
    private let headInstrLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Инструкция по активации"
        return label
    }()
    
    
    var welcomeTextDms: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    var startDateDms: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    var finishDateDms: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    var promoDms: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor     = .systemGreen
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    var instructionDms: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
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
        
        self.backgroundColor = .white
        [safeView, welcomeTextDms, headLogo].forEach
        { addSubview($0) }
        
        safeView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.top)
        }
        
        headLogo.snp.makeConstraints {
            $0.top.equalTo(safeView.snp.bottom)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.height.equalTo(100)
        }
        
        welcomeTextDms.snp.makeConstraints {
            $0.top.equalTo(headLogo.snp.bottom).inset(-10)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
        }
    }
    
    func setubPromoUIUser() {
        [startDateDms, finishDateDms, promoDms, headInstrView, instructionDms].forEach
        { addSubview($0) }
        headInstrView.addSubview(headInstrLabel)
        
        promoDms.snp.makeConstraints {
            $0.top.equalTo(welcomeTextDms.snp.bottom).inset(-10)
            $0.centerX.equalTo(self.snp.centerX)
            $0.centerY.equalTo(self.snp.centerY)
        }
        
        startDateDms.snp.makeConstraints {
            $0.top.equalTo(promoDms.snp.bottom).inset(-10)
            $0.centerX.equalTo(self.snp.centerX)
        }
        
        finishDateDms.snp.makeConstraints {
            $0.top.equalTo(startDateDms.snp.bottom).inset(-10)
            $0.centerX.equalTo(self.snp.centerX)
        }
        
        headInstrView.snp.makeConstraints {
            $0.top.equalTo(finishDateDms.snp.bottom).inset(-10)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.height.equalTo(40)
        }
        
        headInstrLabel.snp.makeConstraints {
            $0.centerX.equalTo(headInstrView.snp.centerX)
            $0.centerY.equalTo(headInstrView.snp.centerY)
        }
        
        instructionDms.snp.makeConstraints {
            $0.top.equalTo(headInstrView.snp.bottom).inset(-5)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.bottom.equalTo(self.snp.bottom)
        }
        
        
    }
    
}
