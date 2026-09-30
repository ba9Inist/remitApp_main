//
//  salaryView.swift
//  remitApp_main
//
//  Created by Егор Голубев on 14.03.2026.
//

import UIKit
import SnapKit

class salaryView: UIView {
    
    private let safeView: UIView = {
        let titleSafeView = UIView()
        titleSafeView.backgroundColor = .red
        return titleSafeView
    }()
    
    private let headSection: UILabel = {
        let label = UILabel()
        label.text = "ЗАРПЛАТА"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    
    private let headLine: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    lazy var lastMonthButton: UIButton = {
        let button = UIButton()
        button.setTitle("Прошлый месяц", for: .normal)
        button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        button.tintColor  = .white
        button.layer.cornerRadius = 10
        button.tag = 1
        return button
    }()
    
    lazy var currentMonthButton: UIButton = {
        let button = UIButton()
        button.setTitle("Текущий месяц", for: .normal)
        button.backgroundColor = .red
        button.tintColor  = .white
        button.layer.cornerRadius = 10
        button.tag = 2
        return button
    }()
    
    let imgHeadDate: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "1.calendar")!
        img.tintColor = .black
        img.contentMode = .scaleAspectFit
        img.tag = 1
        img.isUserInteractionEnabled = true
        return img
    }()
    
    let imgHeadHourlyPay: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "clock.arrow.trianglehead.clockwise.rotate.90.path.dotted")!
        img.tintColor = .black
        img.contentMode = .scaleAspectFit
        img.tag = 2
        img.isUserInteractionEnabled = true
        return img
    }()
    
    let imgHeadGift: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "gift.fill")!
        img.tintColor = .black
        img.contentMode = .scaleAspectFit
        img.tag = 3
        img.isUserInteractionEnabled = true
        return img
    }()
    
    let imgHeadNight: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "moon.fill")!
        img.tintColor = .black
        img.contentMode = .scaleAspectFit
        img.tag = 4
        img.isUserInteractionEnabled = true
        return img
    }()
    
    let imgHeadPartTimeJob: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "arrow.up.forward.square.fill")!
        img.tintColor = .black
        img.contentMode = .scaleAspectFit
        img.tag = 5
        img.isUserInteractionEnabled = true
        return img
    }()
    
    let imgHeadAnotherShop: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "figure.walk.diamond.fill")!
        img.tintColor = .black
        img.contentMode = .scaleAspectFit
        img.tag = 6
        img.isUserInteractionEnabled = true
        return img
    }()
    
    let imgHeadTotal: UIImageView = {
        let img = UIImageView()
        let icon = UIImage(systemName: "pause.circle")!
        let verticalImage = UIImage(cgImage: icon.cgImage!,
                                    scale: icon.scale,
                                    orientation: .right)
        img.image = verticalImage
        img.tintColor = .black
        img.contentMode = .scaleAspectFit
        img.tag = 7
        img.isUserInteractionEnabled = true
        return img
    }()
    
    private lazy var stackUiButton: UIStackView = {
        
        let config = stackConfig(axis: .horizontal,
                                 spacing: 20,
                                 distribution: .fillEqually,
                                 arrangedSubviews: [lastMonthButton, currentMonthButton])
        let stack = CustomStackView(config: config)
        return stack
    }()
    
    //MARK: Поощерение
    
    var labelIncentives: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    var imgLabelIncentives: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.tintColor = .green
        img.image = UIImage(systemName: "flag.fill")!
        img.tag = 8
        img.isUserInteractionEnabled = true
        return img
    }()
    
    private lazy var stackIncentives: UIStackView = {
        let config = stackConfig(axis: .horizontal,
                                 spacing: 5,
                                 distribution: .fillEqually,
                                 arrangedSubviews: [imgLabelIncentives, labelIncentives])
        let stack = CustomStackView(config: config)
        return stack
    }()
    
    //MARK: Удержание
    
    var labelDeductions: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    var imgLabelDeductions: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.tintColor = .red
        img.image = UIImage(systemName: "flag.fill")!
        img.tag = 9
        img.isUserInteractionEnabled = true
        return img
    }()
    
    private lazy var stackDeductions: UIStackView = {
        let config = stackConfig(axis: .horizontal,
                                 spacing: 5,
                                 distribution: .fillEqually,
                                 arrangedSubviews: [imgLabelDeductions, labelDeductions])
        let stack = CustomStackView(config: config)
        return stack
    }()
    
    //MARK: Бригадирские
    
    var labelBrigadiers: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    var imgLabelBrigadiers: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.tintColor = .black
        img.image = UIImage(systemName: "person.3")!
        img.tag = 10
        img.isUserInteractionEnabled = true
        return img
    }()
    
    private lazy var stackBrigadiers: UIStackView = {
        let config = stackConfig(axis: .horizontal,
                                 spacing: 5,
                                 distribution: .fillEqually,
                                 arrangedSubviews: [imgLabelBrigadiers, labelBrigadiers])
        let stack = CustomStackView(config: config)
        return stack
    }()
    
    //MARK: Наставничество
    
    var labelMentoring: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    var imgLabelMentoring: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.tintColor = .black
        img.image = UIImage(systemName: "person")!
        img.tag = 11
        img.isUserInteractionEnabled = true
        return img
    }()
    
    private lazy var stackMentoring: UIStackView = {
        let config = stackConfig(axis: .horizontal,
                                 spacing: 5,
                                 distribution: .fillEqually,
                                 arrangedSubviews: [imgLabelMentoring, labelMentoring])
        let stack = CustomStackView(config: config)
        return stack
    }()
    
    //MARK: Итог за месяц
    
    var labelTotal: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    var imgLabelTotal: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.tintColor = .black
        let icon = UIImage(systemName: "pause.circle")!
        let verticalImage = UIImage(cgImage: icon.cgImage!,
                                    scale: icon.scale,
                                    orientation: .right)
        img.image = verticalImage
        img.tag = 12
        img.isUserInteractionEnabled = true
        return img
    }()
    
    private lazy var stackTotal: UIStackView = {
        let config = stackConfig(axis: .horizontal,
                                 spacing: 5,
                                 distribution: .fillEqually,
                                 arrangedSubviews: [imgLabelTotal, labelTotal])
        let stack = CustomStackView(config: config)
        return stack
    }()
    
    lazy var stackTotalInfoMonth: UIStackView = {
        let config = stackConfig(axis: .vertical,
                                 spacing: 15,
                                 distribution: .fillEqually,
                                 arrangedSubviews: [stackIncentives, stackDeductions, stackBrigadiers, stackMentoring, stackTotal])
        let stack = CustomStackView(config: config)
        return stack
    }()
    
    //MARK: Стэки для данных ЗП
    
    private lazy var dateColumnStack: UIStackView = {
        let config = stackConfig(axis: .vertical,
                                 spacing: 5,
                                 distribution: .fillEqually,
                                 arrangedSubviews: [])
        let stack = CustomStackView(config: config)
        return stack
    }()
    
    private lazy var pieceworkColumnStack: UIStackView = {
        let config = stackConfig(axis: .vertical,
                                 spacing: 5,
                                 distribution: .fillEqually,
                                 arrangedSubviews: [])
        let stack = CustomStackView(config: config)
        return stack
    }()
    
    private lazy var amountTimeColumnStack: UIStackView = {
        let config = stackConfig(axis: .vertical,
                                 spacing: 5,
                                 distribution: .fillEqually,
                                 arrangedSubviews: [])
        let stack = CustomStackView(config: config)
        return stack
    }()
    
    private lazy var nightColumnStack: UIStackView = {
        let config = stackConfig(axis: .vertical,
                                 spacing: 5,
                                 distribution: .fillEqually,
                                 arrangedSubviews: [])
        let stack = CustomStackView(config: config)
        return stack
    }()
    private lazy var partTimeColumnStack: UIStackView = {
        let config = stackConfig(axis: .vertical,
                                 spacing: 5,
                                 distribution: .fillEqually,
                                 arrangedSubviews: [])
        let stack = CustomStackView(config: config)
        return stack
    }()
    
    private lazy var anotherShopColumnStack: UIStackView = {
        let config = stackConfig(axis: .vertical,
                                 spacing: 5,
                                 distribution: .fillEqually,
                                 arrangedSubviews: [])
        let stack = CustomStackView(config: config)
        return stack
    }()
    
    private lazy var totalColumnStack: UIStackView = {
        let config = stackConfig(axis: .vertical,
                                 spacing: 5,
                                 distribution: .fillEqually,
                                 arrangedSubviews: [])
        let stack = CustomStackView(config: config)
        return stack
    }()
    
    private lazy var stackDetails: UIStackView = {
        let config = stackConfig(axis: .horizontal,
                                 spacing: 10,
                                 distribution: .fillEqually,
                                 arrangedSubviews: [dateColumnStack, pieceworkColumnStack, amountTimeColumnStack, nightColumnStack, partTimeColumnStack, anotherShopColumnStack, totalColumnStack])
        let stack = CustomStackView(config: config)
        return stack
    }()
    
    private let labelHelp: UILabel = {
       let label = UILabel()
        label.text = "* Нажмите на иконку, чтобы получить расшифровку показателя"
        label.numberOfLines = 0
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
        
        
        [safeView, headSection, headLine, stackUiButton, stackTotalInfoMonth, labelHelp].forEach {
            addSubview($0)
        }
        
        safeView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.top)
        }
        
        headSection.snp.makeConstraints {
            $0.top.equalTo(safeView.snp.bottom).inset(-5)
            $0.centerX.equalTo(self.snp.centerX)
        }
        
        headLine.snp.makeConstraints {
            $0.top.equalTo(headSection.snp.bottom).inset(-5)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
            $0.height.equalTo(3)
        }
        
        stackUiButton.snp.makeConstraints {
            $0.top.equalTo(headLine.snp.bottom).inset(-10)
            $0.left.equalTo(self.snp.left).inset(10)
            $0.right.equalTo(self.snp.right).inset(10)
        }
        
    }
    
    func createUI(totalData: totalValueMonth, detailsSalary: [detailsDay]) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        
        [dateColumnStack, pieceworkColumnStack, amountTimeColumnStack, nightColumnStack, partTimeColumnStack, anotherShopColumnStack, totalColumnStack]
            .forEach { $0.arrangedSubviews.forEach { $0.removeFromSuperview() } }
        
        dateColumnStack.addArrangedSubview(imgHeadDate)
        pieceworkColumnStack.addArrangedSubview(imgHeadHourlyPay)
        amountTimeColumnStack.addArrangedSubview(imgHeadGift)
        nightColumnStack.addArrangedSubview(imgHeadNight)
        partTimeColumnStack.addArrangedSubview(imgHeadPartTimeJob)
        anotherShopColumnStack.addArrangedSubview(imgHeadAnotherShop)
        totalColumnStack.addArrangedSubview(imgHeadTotal)
        
        if !detailsSalary.isEmpty {
            detailsSalary.forEach { day in
                
                let labelDate = UILabel()
                labelDate.text = formatter.string(from: day.date)
                
                let labelPiecework = UILabel()
                labelPiecework.text = day.amountPiecework.description
                
                let labelAmountTime = UILabel()
                labelAmountTime.text = day.amountTime.description
                
                let labelNight = UILabel()
                labelNight.text = day.amountNight.description
                
                let labelPartTime = UILabel()
                labelPartTime.text = day.amountPartTime.description
                
                let labelAnotherShop = UILabel()
                labelAnotherShop.text = day.amountAnotherShop.description
                
                let labelTotalTable = UILabel()
                labelTotalTable.text = day.totalAmount.description
                
                [labelDate, labelPiecework, labelAmountTime, labelNight, labelPartTime, labelAnotherShop, labelTotalTable]
                    .forEach {
                        $0.font = UIFont.systemFont(ofSize: 10)
                        $0.textAlignment = .center
                        $0.textColor = .black
                    }
                
                dateColumnStack.addArrangedSubview(labelDate)
                pieceworkColumnStack.addArrangedSubview(labelPiecework)
                amountTimeColumnStack.addArrangedSubview(labelAmountTime)
                nightColumnStack.addArrangedSubview(labelNight)
                partTimeColumnStack.addArrangedSubview(labelPartTime)
                anotherShopColumnStack.addArrangedSubview(labelAnotherShop)
                totalColumnStack.addArrangedSubview(labelTotalTable)
                
            }
        }
        
        labelIncentives.text = totalData.incentives.description
        labelDeductions.text = totalData.deductions.description
        labelBrigadiers.text = totalData.brigadiers.description
        labelMentoring.text = totalData.mentoring.description
        labelTotal.text = totalData.totalPayment.description
        
        if stackDetails.superview != nil {
            stackDetails.removeFromSuperview()
        }
        
        addSubview(stackDetails)
        
        stackDetails.snp.makeConstraints {
            $0.top.equalTo(stackUiButton.snp.bottom).inset(-20)
            $0.left.equalTo(self.snp.left).inset(10)
            $0.right.equalTo(self.snp.right).inset(10)
        }
        
        if let lastSubview = stackDetails.arrangedSubviews.last as? UIStackView {
            if let lastSubviewItem = lastSubview.arrangedSubviews.last {
                stackTotalInfoMonth.snp.makeConstraints {
                    $0.top.equalTo(lastSubviewItem.snp.bottom).inset(-20)
                    $0.left.equalTo(self.snp.left).inset(5)
                }
                
                labelHelp.snp.makeConstraints {
                    $0.top.equalTo(stackTotalInfoMonth.snp.bottom).inset(-10)
                    $0.left.equalTo(self.snp.left).inset(5)
                    $0.right.equalTo(self.snp.right).inset(5)
                }
                
            }
        }
    }
    
}

