//
//  LoginVC.swift
//  remitApp_main
//
//  Created by Егор Голубев on 10.06.2025.
//

import UIKit

class LoginVC: UIViewController {

    private let loginView = LoginView()
    weak var coordinator: LoginCoordinator?
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.buttonAuth.addTarget(self, action: #selector(checkNumber(sender:)), for: .touchUpInside)
    }

    @objc func checkNumber(sender: UIButton) {
        let number = loginView.numberUser.text ?? ""
        guard !number.isEmpty && number.count == 11 else {
            let config = ConfigAlert(title: "Предупрждение",
                                     message: "Номер телефона введен некоректно",
                                     type: .alert,
                                     actions: [UIAlertAction]())
            let customAlert = CustomAlert()
            customAlert.showAlert(config: config)
            return
        }
        
        if sender.title(for: .normal) == "Прислать код" {
           // Логика проверки пользователя в 1С - http запрос
            sender.setTitle("Проверить код подверждения", for: .normal)
            loginView.codeAuth.isHidden = false
            loginView.createConstrains()
        } else {
            let code1C = "1234"
            let codeApple = loginView.codeAuth.text ?? ""
            guard !codeApple.isEmpty && codeApple.count == 4 && codeApple == code1C else {
                let config = ConfigAlert(title: "Предупрждение",
                                         message: "Код введен некоректно",
                                         type: .alert,
                                         actions: [UIAlertAction]())
                let customAlert = CustomAlert()
                customAlert.showAlert(config: config)
                loginView.buttonAuth.setTitle("Прислать код", for: .normal)
                disableButtonFor(duration: 60)
                return
            }
            
            guard let coordinator = self.coordinator else {
                print("Ошибка: координатор не найден!")
                return
            }
            
            coordinator.showHomeScreenVC()
            
            //Логика если код смс верный - http запрос
            
        }
        
    }
    
    private func disableButtonFor(duration seconds: TimeInterval) {
        loginView.buttonAuth.isEnabled = false
        loginView.buttonAuth.backgroundColor = .gray
        loginView.messageRepeatCode.isHidden = false

        var counter = Int(seconds)
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.loginView.messageRepeatCode.text = "Повторно отправить код через \(counter) секунд..."
            counter -= 1
            if counter < 0 {
                timer.invalidate()
                self.loginView.buttonAuth.isEnabled = true
                self.loginView.buttonAuth.backgroundColor = .red
                self.loginView.messageRepeatCode.isHidden = true
            }
        }
        RunLoop.main.add(timer, forMode: .common)
    }
    
}

