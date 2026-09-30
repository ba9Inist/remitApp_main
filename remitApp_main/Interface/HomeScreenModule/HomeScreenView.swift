//
//  HomeScreenView.swift
//  remitApp_main
//
//  Created by Егор Голубев on 23.05.2025.
//

import UIKit
import SnapKit


struct size {
    let centerX: Bool
    let centerY: Bool
    let top: Int?
    let left: Int?
    let right: Int?
    let bottom: Int?
}

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
        img.contentMode = .scaleToFill
        img.isUserInteractionEnabled = true
        return img
    }()
    
    lazy var surnameProfile: UILabel = {
        let surname = UILabel()
        surname.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        surname.textColor = .darkGray
        return surname
    }()
    
    lazy var nameProfile: UILabel = {
        let nameProfile = UILabel()
        nameProfile.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        nameProfile.textColor = .darkGray
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
        return rankProfile
    }()
    
    lazy var experienceProfile: UILabel = {
        let experienceProfile = UILabel()
        experienceProfile.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        experienceProfile.textColor = .darkGray
        return experienceProfile
    }()
    
    lazy var competenceProfile: UILabel = {
        let competenceProfile = UILabel()
        competenceProfile.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        competenceProfile.textColor = .darkGray
        return competenceProfile
    }()
    
    
    private lazy var stackUiButton1: UIStackView = {
        return initStackButton(arrayButton: [buttonVacation, buttonQuestion,buttonBus, buttonSalary])
    }()
    
    private lazy var stackUiButton2: UIStackView = {
        return initStackButton(arrayButton: [buttonGear, buttonCompetition, buttonLoyality, buttonRestoran])
    }()
    
    private lazy var stackUiButton3: UIStackView = {
        return initStackButton(arrayButton: [buttonStudent, buttonMentor, buttonSber, buttonTonar])
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
        table.backgroundColor = .white
        table.estimatedRowHeight = 40
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    var indicatorLoad: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .darkGray
        indicator.isHidden = true
        return indicator
    }()
    
    lazy var buttonVacation: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.tag = ButtonName.vacation.rawValue
        let img = UIImageView()
        img.image = .caseVacation
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        button.addSubview(img)
        let size = size(centerX: false, centerY: false, top: 2, left: 2, right: 2, bottom: 10)
        setubUniversalImgButton(button: button, imgView: img, size: size)
        button.addSubview(dayVacation)
        dayVacation.snp.makeConstraints {
            $0.centerX.equalTo(button.snp.centerX)
            $0.centerY.equalTo(button.snp.centerY)
        }
        return button
    }()
    
    var dayVacation: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var buttonQuestion: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.tag = ButtonName.question.rawValue
        let img = UIImageView()
        img.image = .chat
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        button.addSubview(img)
        let size = size(centerX: false, centerY: false, top: 10, left: 10, right: 10, bottom: 10)
        setubUniversalImgButton(button: button, imgView: img, size: size)
        return button
    }()
    
    lazy var buttonBus: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.tag = ButtonName.bus.rawValue
        let img = UIImageView()
        img.image = UIImage(systemName: "bus.fill")!
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        button.addSubview(img)
        let size = size(centerX: false, centerY: false, top: 10, left: 10, right: 10, bottom: 10)
        setubUniversalImgButton(button: button, imgView: img, size: size)
        return button
    }()
    
    lazy var buttonSalary: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.tag = ButtonName.calendar.rawValue
        let img = UIImageView()
        img.image = UIImage(systemName: "calendar")!
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        button.addSubview(img)
        let size = size(centerX: false, centerY: false, top: 10, left: 10, right: 10, bottom: 10)
        setubUniversalImgButton(button: button, imgView: img, size: size)
        return button
    }()
    
    lazy var buttonGear: UIButton = {
        let button = UIButton()
        button.backgroundColor = .brown
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.tag = ButtonName.setting.rawValue
        
        let img = UIImageView()
        img.image = UIImage(systemName: "gear")!
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        button.addSubview(img)
        let size = size(centerX: false, centerY: false, top: 10, left: 10, right: 10, bottom: 10)
        setubUniversalImgButton(button: button, imgView: img, size: size)
        return button
    }()
    
    lazy var buttonCompetition: UIButton = {
        let button = UIButton()
        button.backgroundColor = .purple
        button.layer.cornerRadius = 10
        button.tag = ButtonName.competence.rawValue
        let img = UIImageView()
        img.image = .listCompetitions
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        button.addSubview(img)
        let size = size(centerX: false, centerY: false, top: 10, left: 10, right: 10, bottom: 10)
        setubUniversalImgButton(button: button, imgView: img, size: size)
        return button
    }()
    
    lazy var buttonLoyality: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.tag = ButtonName.franchise.rawValue
        let img = UIImageView()
        img.image = UIImage(systemName: "basket.fill")
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        button.addSubview(img)
        let size = size(centerX: false, centerY: false, top: 10, left: 10, right: 10, bottom: 10)
        setubUniversalImgButton(button: button, imgView: img, size: size)
        return button
    }()
    
    lazy var buttonRestoran: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "customCyan")
        button.layer.cornerRadius = 10
        button.tag = ButtonName.food.rawValue
        let img = UIImageView()
        img.image = .food
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        button.addSubview(img)
        let size = size(centerX: false, centerY: false, top: 10, left: 10, right: 10, bottom: 10)
        setubUniversalImgButton(button: button, imgView: img, size: size)
        return button
    }()
    
    lazy var buttonStudent: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        button.tag = ButtonName.student.rawValue
        let img = UIImageView()
        img.image =  .student
        img.contentMode = .scaleAspectFit
        img.tintColor = .white
        img.clipsToBounds = true
        button.addSubview(img)
        let size = size(centerX: false, centerY: false, top: 10, left: 10, right: 10, bottom: 10)
        setubUniversalImgButton(button: button, imgView: img, size: size)
        return button
    }()
    
    lazy var buttonMentor: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.tag = ButtonName.teacher.rawValue
        
        let img = UIImageView()
        img.image =  .teacher
        img.contentMode = .scaleAspectFit
        img.tintColor = .white
        img.clipsToBounds = true
        button.addSubview(img)
        let size = size(centerX: false, centerY: false, top: 10, left: 10, right: 10, bottom: 10)
        setubUniversalImgButton(button: button, imgView: img, size: size)
        return button
    }()
    
    lazy var buttonSber: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "customGreen")
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.tag = ButtonName.sber.rawValue
        let img = UIImageView()
        img.image = UIImage(systemName: "cross.case.fill")!
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        button.addSubview(img)
        let size = size(centerX: false, centerY: false, top: 10, left: 10, right: 10, bottom: 10)
        setubUniversalImgButton(button: button, imgView: img, size: size)
        return button
    }()
    
    lazy var buttonTonar: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.tag = ButtonName.tonar.rawValue
        let img = UIImageView()
        img.image = .tonar
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        button.addSubview(img)
        let size = size(centerX: false, centerY: false, top: 5, left: 7, right: 7, bottom: 7)
        setubUniversalImgButton(button: button, imgView: img, size: size)
        button.addSubview(tonarWeight)
        tonarWeight.snp.makeConstraints {
            $0.centerX.equalTo(button.snp.centerX)
            $0.centerY.equalTo(button.snp.centerY)
        }
        return button
    }()
    
    var tonarWeight: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
//    lazy var loginButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .clear
//        button.setImage(<#T##image: UIImage?##UIImage?#>, for: .normal)
//        button.layer.cornerRadius = 10
//        button.tintColor = .white
//        return button
//    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setubUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setubUI() {
        
        self.backgroundColor = .white
        
        [safeView, backgroundColorProfile, stackUiButton1, stackUiButton2, stackUiButton3, lineFeed, feedTable, indicatorLoad].forEach
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
            $0.top.equalTo(lineTitle.snp.bottom)
            $0.left.equalTo(imgProfile.snp.right).inset(-20)
            $0.bottom.equalTo(backgroundColorProfile.snp.bottom)
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
        
        indicatorLoad.snp.makeConstraints {
            $0.centerX.equalTo(self.snp.centerX)
            $0.centerY.equalTo(self.snp.centerY)
        }
        
    }
    
    private func initStackButton(arrayButton: [UIButton]) -> UIStackView{
        let config = stackConfig(axis: .horizontal,
                                 spacing: 10,
                                 distribution: .fillEqually,
                                 arrangedSubviews: arrayButton)
        let stack = CustomStackView(config: config)
        return stack
    }
    
    private func setubUniversalImgButton(button: UIButton, imgView: UIImageView, size: size) {
        imgView.snp.makeConstraints {
            
            if size.centerX {
                $0.centerX.equalTo(button.snp.centerX)
            }
            
            if size.centerY {
                $0.centerY.equalTo(button.snp.centerY)
            }
            
            if size.top != nil {
                let top = size.top!
                $0.top.equalTo(button.snp.top).inset(top)
            }
            
            if size.left != nil {
                let left = size.left!
                $0.left.equalTo(button.snp.left).inset(left)
            }
            
            if size.right != nil {
                let right = size.right!
                $0.right.equalTo(button.snp.right).inset(right)
            }
            
            if size.bottom != nil {
                let bottom = size.bottom!
                $0.bottom.equalTo(button.snp.bottom).inset(bottom)
            }
            
        }
    }
    
}
