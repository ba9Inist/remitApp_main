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

    private static let biometryReason = "Для продолжения потребуется проверка лица или отпечатка пальца."

    // Защита от повторного запуска сценария входа при повторном viewDidAppear
    private var didStartAuthFlow = false

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
        launchScreenModel.getHeadImageView { [weak self] result in
            // Загрузчик картинки отдаёт часть ветвей отказа не с главного потока,
            // поэтому работу с UI выполняем явно на главном
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    if let image = image {
                        self?.logoRemit.image = image
                    }
                case .failure(let error):
                    // Картинка заставки необязательна: молча остаёмся с фоном по умолчанию,
                    // алерт на старте из-за декоративного изображения только мешает входу
                    print("Не удалось загрузить изображение заставки:", error.localizedDescription)
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // viewDidAppear может вызваться повторно — сценарий входа должен запуститься один раз
        guard !didStartAuthFlow else { return }
        didStartAuthFlow = true

        indicatorLoad.startAnimating()
        launchScreenModel.createUuidApple()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }
            guard let coordinator = self.coordinator else {
                print("Ошибка: координатор не найден!")
                return
            }

            self.indicatorLoad.stopAnimating()

            guard self.launchScreenModel.checkAuthorization() else {
                coordinator.showLoginVC()
                return
            }

            self.requestBiometry(coordinator: coordinator)
        }
    }

    // Запрос биометрии. Любой отказ обязан куда-то вести: раньше ветки
    // «не настроена биометрия», «Отмена» и неудачный повтор показывали алерт
    // и оставляли пользователя на экране запуска без выхода.
    private func requestBiometry(coordinator: AppCoordinator) {
        biometricModel.authenticate(reason: Self.biometryReason, allowPasswordFallback: true) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }

                switch result {
                case .success():
                    coordinator.showHomeScreenVC()

                case .failure(let error):
                    if error is BiometryNotEnrolledError {
                        // Биометрия на устройстве недоступна в принципе — повторять бессмысленно,
                        // уводим на обычный вход по номеру телефона
                        self.showDeadEndFreeAlert(
                            title: "Биометрия недоступна",
                            message: "Устройство не настроено для проверки лица или отпечатка. Настроить её можно в настройках устройства, а сейчас войдите по номеру телефона.",
                            retry: nil,
                            coordinator: coordinator
                        )
                    } else {
                        print("Ошибка биометрической авторизации:", error.localizedDescription)
                        self.showDeadEndFreeAlert(
                            title: "Не удалось подтвердить личность",
                            message: "Попробуйте ещё раз или войдите по номеру телефона.",
                            retry: { [weak self] in self?.requestBiometry(coordinator: coordinator) },
                            coordinator: coordinator
                        )
                    }
                }
            }
        }
    }

    // Алерт, из которого всегда есть выход: повтор (если он осмыслен) либо вход по номеру
    private func showDeadEndFreeAlert(title: String,
                                      message: String,
                                      retry: (() -> Void)?,
                                      coordinator: AppCoordinator) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        if let retry = retry {
            alert.addAction(UIAlertAction(title: "Повторить", style: .default) { _ in retry() })
        }

        alert.addAction(UIAlertAction(title: "Войти по номеру телефона", style: .default) { _ in
            coordinator.showLoginVC()
        })

        present(alert, animated: true)
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
    
}
