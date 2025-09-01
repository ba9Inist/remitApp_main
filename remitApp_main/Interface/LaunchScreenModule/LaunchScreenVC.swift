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
    
    private lazy var logoRemit: UIImageView = {
        let logoRemit = UIImageView()
        logoRemit.backgroundColor = .blue
        return logoRemit
    }()
    
    private lazy var indicatorLoad: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        return indicator
    }()
    
    private let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(logoRemit)
        logoRemit.addSubview(indicatorLoad)
        setubConstrains()
        networkManager.setubHeadImageView { [weak self] image in
            guard let self = self else { return }
            self.logoRemit.image = image
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        indicatorLoad.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.indicatorLoad.stopAnimating()
            guard let coordinator = self.coordinator else {
                print("Ошибка: координатор не найден!")
                return
            }
            coordinator.showLoginVC()
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
