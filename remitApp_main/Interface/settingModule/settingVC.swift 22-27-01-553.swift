//
//  settingVC.swift
//  remitApp_main
//
//  Created by Егор Голубев on 25.10.2025.
//

import UIKit
import SnapKit

class settingVC: UIViewController {
    
    private let backgroundSafeZone: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    private lazy var buttonUpdate: UIButton = {
       let button = UIButton()
        button.setTitle("   Обновить приложение   ", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(updateApp), for: .touchUpInside)
        return button
    }()
    
    private lazy var currentVersion: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var versionApp: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    var imgSetting: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "settingIcon")
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setubUI()
        navigationController?.navigationBar.tintColor = .white
        getVersions()
    }
    
    
    private func setubUI() {
        view.backgroundColor = .systemBackground
        [buttonUpdate, currentVersion, versionApp, backgroundSafeZone, imgSetting].forEach{view.addSubview($0)}
        
        backgroundSafeZone.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.left.equalTo(view.snp.left)
            $0.right.equalTo(view.snp.right)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        buttonUpdate.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY)
        }
        
        currentVersion.snp.makeConstraints {
            $0.bottom.equalTo(buttonUpdate.snp.top).inset(-10)
            $0.centerX.equalTo(view.snp.centerX)
        }
        
        versionApp.snp.makeConstraints {
            $0.bottom.equalTo(currentVersion.snp.top).inset(-5)
            $0.centerX.equalTo(view.snp.centerX)
        }
        
        imgSetting.snp.makeConstraints {
            $0.bottom.equalTo(view.snp.bottom)
            $0.left.equalTo(view.snp.left)
            $0.right.equalTo(view.snp.right)
            $0.top.equalTo(buttonUpdate.snp.bottom)
        }
    }
    
    @objc private func updateApp() {
        
        if let user = realmManager().fetchUser() {
            versionApp.text = "Последняя версия приложения: \(user.currentVersionApp)"
            let config = ConfigAlert(title: "Обновление", message: "Ваше приложение обновлено до актуальной версии", type: .alert, actions:[])
            CustomAlert().showAlert(config: config)
        }
        
    }
    
    private func getVersions() {
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            versionApp.text = "Версия вашего приложения: \(version)"
        }
        
        if let user = realmManager().fetchUser() {
            currentVersion.text = "Последняя версия приложения: \(user.currentVersionApp)"
        }
        
    }
    

}
