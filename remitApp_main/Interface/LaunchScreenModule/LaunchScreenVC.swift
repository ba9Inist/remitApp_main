//
//  LaunchScreenVCViewController.swift
//  remitApp_main
//
//  Created by Егор Голубев on 25.04.2025.
//

import UIKit
import SnapKit

class LaunchScreenVC: UIViewController {
    
    weak var coordinator: AppCoordinator?
    private let launchScreenModel = LaunchScreenModel()
    private let biometricModel = biometricManager.shared
    
    private lazy var logoRemit: UIImageView = {
        let logoRemit = UIImageView()
        logoRemit.backgroundColor = .white
        return logoRemit
    }()
    
    private lazy var indicatorLoad: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(logoRemit)
        logoRemit.addSubview(indicatorLoad)
        setubConstrains()
        launchScreenModel.getHeadImageView { result in
            switch result {
            case .success(let image):
                if let image = image {
                    self.logoRemit.image = image
                }
            case .failure(let error):
                CustomAlert().showFastAlertError(textError: error.localizedDescription)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        indicatorLoad.startAnimating()
        launchScreenModel.createUuidApple()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            guard let coordinator = self.coordinator else {
                print("Ошибка: координатор не найден!")
                return
            }
            if self.launchScreenModel.checkAuthorization() {
                self.biometricModel.authenticate(reason: "Для продолжения потребуется проверка лица или отпечатка пальца.", allowPasswordFallback: true) { result in
                    switch result {
                    case .success():
                        DispatchQueue.main.async {
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
            } else{
                coordinator.showLoginVC()
            }
            self.indicatorLoad.stopAnimating()
        }
    }
    
   private func setubConstrains(){
        logoRemit.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.left.equalTo(view.snp.left)
            $0.right.equalTo(view.snp.right)
            $0.bottom.equalTo(view.snp.bottom)
        }
        
        indicatorLoad.snp.makeConstraints {
            $0.top.equalTo(view.snp.bottom).inset(250)
            $0.left.equalTo(view.snp.left).inset(50)
            $0.right.equalTo(view.snp.right).inset(50)
        }
    }
    
    private func loadDataRemit() {
       let VC = HomeScreenVC()
        present(VC, animated: true)
    }
    
}
