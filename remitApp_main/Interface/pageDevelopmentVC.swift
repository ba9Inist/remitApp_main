//
//  pageDevelopmentVC.swift
//  remitApp_main
//
//  Created by Егор Голубев on 27.10.2025.
//

import UIKit
import SnapKit

class pageDevelopmentVC: UIViewController {
    
    private let backgroundSafeZone: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    var mainLogo: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "pageDevelopment")
        return img
    }()
    
    var alertView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(red: 204 / 255.0,
                                       green: 230 / 255.0,
                                       blue: 255 / 255.0,
                                       alpha: 1.0)
        view.layer.borderWidth = 2.00
        view.layer.borderColor = UIColor(red: 120 / 255.0,
                                         green: 192 / 255.0,
                                         blue: 255 / 255.0,
                                         alpha: 1.0).cgColor
        return view
    }()
    
    lazy var alertLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(red: 120 / 255.0,
                                  green: 192 / 255.0,
                                  blue: 255 / 255.0,
                                  alpha: 1.0)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Извините!\n Данный раздел находится в разработке"
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        setubUI()
    }
    
    private func setubUI() {
        
        view.backgroundColor = .white
        [backgroundSafeZone, mainLogo, alertView].forEach{view.addSubview($0)}
        alertView.addSubview(alertLabel)
        
        backgroundSafeZone.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.left.equalTo(view.snp.left)
            $0.right.equalTo(view.snp.right)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        mainLogo.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY)
            $0.left.equalTo(view.snp.left)
            $0.right.equalTo(view.snp.right)
        }
        
        alertView.snp.makeConstraints {
            $0.top.equalTo(mainLogo.snp.bottom).inset(-30)
            $0.left.equalTo(view.snp.left).inset(20)
            $0.right.equalTo(view.snp.right).inset(20)
            $0.height.equalTo(100)
        }
        
        alertLabel.snp.makeConstraints {
            $0.centerX.equalTo(alertView.snp.centerX)
            $0.centerY.equalTo(alertView.snp.centerY)
            $0.left.equalTo(alertView.snp.left).inset(30)
            $0.right.equalTo(alertView.snp.right).inset(30)
        }

        
    }
    
    
}
