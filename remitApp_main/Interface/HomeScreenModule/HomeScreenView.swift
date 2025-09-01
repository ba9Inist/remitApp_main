//
//  HomeScreenView.swift
//  remitApp_main
//
//  Created by Егор Голубев on 23.05.2025.
//

import UIKit
import SnapKit

final class HomeScreenView: UIView {
    
    private let safeView: UIView = {
        let titleSafeView = UIView()
        titleSafeView.backgroundColor = .red
        return titleSafeView
    }()
    
    private let backgroundColorProfile : UIView = {
        let colorProfile = UIView()
        colorProfile.backgroundColor = .systemGray5
        return colorProfile
    }()
    
    var imgProfile: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .lightGray
        img.clipsToBounds = true
        img.layer.cornerRadius = 10
        return img
    }()
    
    lazy var surnameProfile: UILabel = {
        let surname = UILabel()
        surname.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        surname.textColor = .darkGray
        surname.text = "Голубев"
        return surname
    }()
    
    lazy var nameProfile: UILabel = {
        let nameProfile = UILabel()
        nameProfile.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        nameProfile.textColor = .darkGray
        nameProfile.text = "Егор Дмитриевич"
        return nameProfile
    }()
    
    private let lineTitle : UIView = {
        let lineTitle = UIView()
        lineTitle.backgroundColor = .systemGray2
        return lineTitle
    }()
    
    lazy var rankProfile: UILabel = {
        let rankProfile = UILabel()
        rankProfile.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        rankProfile.textColor = .darkGray
        rankProfile.text = "Инженер - программист"
        return rankProfile
    }()
    
    lazy var experienceProfile: UILabel = {
        let experienceProfile = UILabel()
        experienceProfile.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        experienceProfile.textColor = .darkGray
        experienceProfile.text = "Стаж: 3"
        return experienceProfile
    }()
    
    lazy var competenceProfile: UILabel = {
        let competenceProfile = UILabel()
        competenceProfile.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        competenceProfile.textColor = .darkGray
        competenceProfile.text = "Компетенции: 0"
        return competenceProfile
    }()
    
    private let stackUiButton1: UIStackView = {
        let config = stackConfig(axis: .horizontal,
                                 spacing: 10,
                                 distribution: .fillEqually,
                                 arrangedSubviews: HomeScreenModel().oneRow())
        let stack = CustomStackView(config: config)
        return stack
    }()
    
    private let stackUiButton2: UIStackView = {
        let config = stackConfig(axis: .horizontal,
                                 spacing: 10,
                                 distribution: .fillEqually,
                                 arrangedSubviews: HomeScreenModel().twoRow())
        let stack = CustomStackView(config: config)
        return stack
    }()
    
    private let stackUiButton3: UIStackView = {
        let config = stackConfig(axis: .horizontal,
                                 spacing: 10,
                                 distribution: .fillEqually,
                                 arrangedSubviews: HomeScreenModel().threeRow())
        let stack = CustomStackView(config: config)
        return stack
    }()
    
    private let lineFeed : UIView = {
        let lineTitle = UIView()
        lineTitle.backgroundColor = .orange
        return lineTitle
    }()
    
    private let titleFeed: UILabel = {
        let titleFeed = UILabel()
        titleFeed.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleFeed.textColor = .white
        titleFeed.text = "Лента новостей:"
        return titleFeed
    }()
    
    private lazy var stackUiMain: UIStackView = {
        let config = stackConfig(axis: .vertical,
                                 spacing: 0,
                                 distribution: .fillEqually,
                                 arrangedSubviews: [surnameProfile, nameProfile])
        let stack = CustomStackView(config: config)
        return stack
    }()
    
    private lazy var stackUiSub: UIStackView = {
        
        let config = stackConfig(axis: .vertical,
                                 spacing: 0,
                                 distribution: .fillEqually,
                                 arrangedSubviews: [rankProfile, experienceProfile, competenceProfile])
        let stack = CustomStackView(config: config)
        return stack
    }()
    
    lazy var feedTable: UITableView = {
       let table = UITableView()
        table.rowHeight = 40
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
        
        self.backgroundColor = .systemBackground
        
        [safeView, backgroundColorProfile,stackUiButton1, stackUiButton2, stackUiButton3, lineFeed, feedTable].forEach
        { addSubview($0) }
        [imgProfile, lineTitle, stackUiMain, stackUiSub].forEach { backgroundColorProfile.addSubview($0) }
        lineFeed.addSubview(titleFeed)
        
        safeView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.top)
        }
        
        backgroundColorProfile.snp.makeConstraints{
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.height.equalTo(130)
        }
        
        imgProfile.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(15)
            $0.left.equalTo(backgroundColorProfile.snp.left).inset(10)
            $0.height.equalTo(100)
            $0.width.equalTo(100)
        }
        
        stackUiMain.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(10)
            $0.left.equalTo(imgProfile.snp.right).inset(-20)
        }
        
        lineTitle.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(65)
            $0.height.equalTo(3)
            $0.left.equalTo(imgProfile.snp.right)
            $0.right.equalTo(backgroundColorProfile.snp.right)
        }
        
        stackUiSub.snp.makeConstraints {
            $0.top.equalTo(lineTitle.snp.bottom).inset(-10)
            $0.left.equalTo(imgProfile.snp.right).inset(-20)
        }
        
        stackUiButton1.snp.makeConstraints {
            $0.top.equalTo(backgroundColorProfile.snp.bottom).inset(-15)
            $0.left.equalTo(self.snp.left).inset(20)
            $0.right.equalTo(self.snp.right).inset(20)
            $0.height.equalTo(100)
        }
        
        stackUiButton2.snp.makeConstraints {
            $0.top.equalTo(stackUiButton1.snp.bottom).inset(-15)
            $0.left.equalTo(self.snp.left).inset(20)
            $0.right.equalTo(self.snp.right).inset(20)
            $0.height.equalTo(100)
        }
        
        stackUiButton3.snp.makeConstraints {
            $0.top.equalTo(stackUiButton2.snp.bottom).inset(-15)
            $0.left.equalTo(self.snp.left).inset(20)
            $0.right.equalTo(self.snp.right).inset(20)
            $0.height.equalTo(100)
        }
        
        lineFeed.snp.makeConstraints {
            
            $0.top.equalTo(stackUiButton3.snp.bottom).inset(-15)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.height.equalTo(25)
        }
        
        titleFeed.snp.makeConstraints {
            $0.centerX.equalTo(lineFeed.snp.centerX)
            $0.centerY.equalTo(lineFeed.snp.centerY)
        }
        
        feedTable.snp.makeConstraints {
            $0.top.equalTo(lineFeed.snp.bottom)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.bottom.equalTo(self.snp.bottom)
        }
        
    }
    
}
