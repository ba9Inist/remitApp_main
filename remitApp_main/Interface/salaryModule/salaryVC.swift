//
//  salaryVC.swift
//  remitApp_main
//
//  Created by Егор Голубев on 14.03.2026.
//

import UIKit

class salaryVC: UIViewController {
    
    let salaryData: salaryResponceScheme
    private let salaryViewInstance = salaryView()
    
    init(salaryData: salaryResponceScheme) {
        self.salaryData = salaryData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = salaryViewInstance
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        salaryViewInstance.currentMonthButton.addTarget(self, action: #selector(handleButtonTap(sender:)), for: .touchUpInside)
        salaryViewInstance.lastMonthButton.addTarget(self, action: #selector(handleButtonTap(sender:)), for: .touchUpInside)
        var arrayImgHelp = [UIImageView]()
        arrayImgHelp.append(salaryViewInstance.imgHeadDate)
        arrayImgHelp.append(salaryViewInstance.imgHeadHourlyPay)
        arrayImgHelp.append(salaryViewInstance.imgHeadNight)
        arrayImgHelp.append(salaryViewInstance.imgHeadGift)
        arrayImgHelp.append(salaryViewInstance.imgHeadTotal)
        arrayImgHelp.append(salaryViewInstance.imgHeadAnotherShop)
        arrayImgHelp.append(salaryViewInstance.imgHeadPartTimeJob)
        arrayImgHelp.append(salaryViewInstance.imgLabelIncentives)
        arrayImgHelp.append(salaryViewInstance.imgLabelDeductions)
        arrayImgHelp.append(salaryViewInstance.imgLabelBrigadiers)
        arrayImgHelp.append(salaryViewInstance.imgLabelMentoring)
        arrayImgHelp.append(salaryViewInstance.imgLabelTotal)
        arrayImgHelp.forEach {
            let tap = UITapGestureRecognizer(target: self, action: #selector(showHelp(_:)))
            $0.addGestureRecognizer(tap)
        }
        
        setubUI(tag: 2)
    }
    
    @objc private func handleButtonTap(sender: UIButton) {
        
        let tag = sender.tag
        
        if tag == 1 { // Прошлый месяц
            //salaryViewInstance.currentMonthButton.isEnabled = false
            salaryViewInstance.currentMonthButton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        } else {
            //salaryViewInstance.lastMonthButton.isEnabled = false
            salaryViewInstance.lastMonthButton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        }
        
        sender.backgroundColor = .red
        setubUI(tag: tag)
        //sender.isEnabled = true
    }
    
    private func setubUI(tag: Int) {
        
        var totalData = salaryData.additionsSalaryCurrentMonths
        var detailsSalary = salaryData.CurrentMonthsSalary
        
        if tag == 1 {
            totalData = salaryData.additionsSalaryLastMonths
            detailsSalary = salaryData.LastMonthsSalary
        }
        
        salaryViewInstance.createUI(totalData: totalData, detailsSalary: detailsSalary)
        
    }
    
    @objc private func showHelp(_ sender: UITapGestureRecognizer) {
        
        guard let imageView = sender.view as? UIImageView else { return }
        let tag = imageView.tag
        
        let alert = CustomAlert()
        var textAlert = ""
        
        switch tag {
        case 1:
            textAlert = "Ячейка отображает дату рабочих дней"
        case 2:
            textAlert = "Ячейка отображает часовую оплату труда"
        case 3:
            textAlert = "Ячека отображает дневную оплату труда"
        case 4:
            textAlert = "Ячейка отображает ночную оплату труда"
        case 5:
            textAlert = "Ячейка отображает оплату труда за подработки"
        case 6:
            textAlert = "Ячейка отображает оплату труда за работу в другом цеху"
        case 7:
            textAlert = "Ячейка отображает оплату труда за весь день"
        case 8:
            textAlert = "Данный показатель отображает итоговую надбавку за месяц"
        case 9:
            textAlert = "Данный показатель отображает итоговое удержания за месяц"
        case 10:
            textAlert = "Данный показатель отображает итоговую сумму за бригадирство"
        case 11:
            textAlert = "Данный показатель отображает итоговую сумму за наставничество"
        case 12:
            textAlert = "Данный показатель отображает итоговую сумму зарплаты за месяц"
        default: break
        }
        
        if !textAlert.isEmpty {
            let config = ConfigAlert(title: "Подсказка", message: textAlert, type: .alert, actions: [])
            alert.showAlert(config: config)
        }
        
    }
    
}
