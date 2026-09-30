//
//  LoginVC.swift
//  remitApp_main
//
//  Created by Егор Голубев on 10.06.2025.
//

import UIKit

import UIKit

class LoginVC: UIViewController {
    
    private let loginView = LoginView()
    weak var coordinator: LoginCoordinator?
    private let loginModel = LoginModel()
    private let biometricModel = biometricManager.shared
    
    override func loadView() {
        view = loginView
        title = "Кабинет сотрудника"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.buttonAuth.addTarget(self, action: #selector(checkNumber(sender:)), for: .touchUpInside)
        configureToolBars()
    }
    
    @objc func checkNumber(sender: UIButton) {
        let number = loginView.numberUser.text ?? ""
        let codeApple = loginView.codeAuth.text ?? ""
        guard !number.isEmpty && number.count == 11 else {
            let config = ConfigAlert(title: "Предупреждение",
                                     message: "Номер телефона введен некорректно",
                                     type: .alert,
                                     actions: [UIAlertAction]())
            let customAlert = CustomAlert()
            customAlert.showAlert(config: config)
            return
        }
        
        if sender.title(for: .normal) == "Прислать код" {
            loginModel.generateAnAuthorizationCode(number: number, codeAuth: codeApple) { success in
                if success {
                    DispatchQueue.main.async {
                        sender.setTitle("Проверить код подтверждения", for: .normal)
                    }
                }
            }
        } else {
            loginModel.checkCodeAuthorization(number: number, codeApple: codeApple) { success in
                if !success {
                    DispatchQueue.main.async {
                        self.loginView.buttonAuth.setTitle("Прислать код", for: .normal)
                        self.disableButtonFor(duration: 60)
                        return
                    }
                } else {
                    self.biometricModel.authenticate(reason: "Для продолжения потребуется проверка лица или отпечатка пальца.", allowPasswordFallback: true) { result in
                        switch result {
                        case .success():
                            DispatchQueue.main.async {
                                guard let coordinator = self.coordinator else {
                                    print("Ошибка: координатор не найден!")
                                    return
                                }
                                coordinator.showHomeScreenVC()
                            }
                        case .failure(let error):
                            DispatchQueue.main.async {
                                if error is BiometryNotEnrolledError {
                                    CustomAlert().showFastAlertError(textError: "Ваше устройство не зарегистрировано для использования биометрии. Вы можете настроить её в настройках устройства.")
                                } else {
                                    let alert = UIAlertController(title: "Ошибка авторизации", message: "Что-то пошло не так. Пробовали ли вы ввести пароль устройства?", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Ввести пароль", style: .default) { _ in
                                        self.biometricModel.retryAuthentication(reason: "Для продолжения потребуется проверка лица или отпечатка пальца.", allowPasswordFallback: true) { repeatResult in
                                            switch repeatResult {
                                            case .success():
                                                DispatchQueue.main.async {
                                                    guard let coordinator = self.coordinator else {
                                                        print("Ошибка: координатор не найден!")
                                                        return
                                                    }
                                                    coordinator.showHomeScreenVC()
                                                }
                                            case .failure(let repeatError):
                                                DispatchQueue.main.async {
                                                    CustomAlert().showFastAlertError(textError: repeatError.localizedDescription)
                                                    print("Ошибка при повторной попытке биометрической авторизации:", repeatError.localizedDescription)
                                                }
                                            }
                                        }
                                    })
                                    alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
                                    self.present(alert, animated: true)
                                }
                            }
                        }
                    }
                }
            }
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
    
    private func configureToolBars() {
        let numberUserToolbar = createToolbar(forNext: true, forPrevious: false)
        loginView.numberUser.inputAccessoryView = numberUserToolbar
        
        let codeAuthToolbar = createToolbar(forNext: true, forPrevious: true)
        loginView.codeAuth.inputAccessoryView = codeAuthToolbar
    }
    
    private func createToolbar(forNext: Bool, forPrevious: Bool) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        var items: [UIBarButtonItem] = []
        
        if forPrevious {
            let prevButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(goBack))
            items.append(prevButton)
        }
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        items.append(flexSpace)
        
        if forNext {
            let nextButton = UIBarButtonItem(title: "Далее", style: .plain, target: self, action: #selector(goForward))
            items.append(nextButton)
        }
        
        toolbar.items = items
        return toolbar
    }
    
    @objc func goForward() {
        if loginView.numberUser.isFirstResponder {
            loginView.codeAuth.becomeFirstResponder()
        } else if loginView.codeAuth.isFirstResponder {
            loginView.codeAuth.resignFirstResponder()
        }
    }
    
    @objc func goBack() {
        loginView.numberUser.becomeFirstResponder()
    }
    
    
    
    
}

