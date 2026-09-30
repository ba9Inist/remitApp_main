//
//  HomeScreenView.swift
//  remitApp_main
//
//  Created by Егор Голубев on 06.06.2025.
//

import UIKit
import RealmSwift


final class HomeScreenVC: UIViewController {
    
    private var homeScreenView: HomeScreenView
    weak var coordinator: MainCoordinator?
    private let homeScreenModel = HomeScreenModel()
    private var newsArray = [news]()
    private var avatarOriginPoint = CGPoint()
    private var arrayButtonView = [UIButton]()
    let userRealm = realmManager().fetchUser()
    
    init() {
        self.homeScreenView = HomeScreenView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        homeScreenModel.UpdateUI(view: homeScreenView)
        view = homeScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Кабинет сотрудника"
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        homeScreenView.feedTable.register(CustomTableViewCellNews.self,
                                          forCellReuseIdentifier: CustomTableViewCellNews.reuseIdentifier)
        homeScreenView.feedTable.delegate = self
        homeScreenView.feedTable.dataSource = self
        newsArray = homeScreenModel.fetchNews()
        homeScreenView.feedTable.reloadData()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnAvatar))
        homeScreenView.imgProfile.addGestureRecognizer(tapGesture)
        
        arrayButtonView.append(homeScreenView.buttonVacation)
        arrayButtonView.append(homeScreenView.buttonQuestion)
        arrayButtonView.append(homeScreenView.buttonBus)
        arrayButtonView.append(homeScreenView.buttonSalary)
        arrayButtonView.append(homeScreenView.buttonGear)
        arrayButtonView.append(homeScreenView.buttonCompetition)
        arrayButtonView.append(homeScreenView.buttonLoyality)
        arrayButtonView.append(homeScreenView.buttonRestoran)
        arrayButtonView.append(homeScreenView.buttonStudent)
        arrayButtonView.append(homeScreenView.buttonMentor)
        arrayButtonView.append(homeScreenView.buttonSber)
        arrayButtonView.append(homeScreenView.buttonTonar)
        
        arrayButtonView.forEach {
            $0.addTarget(self, action: #selector(handleButtonTap(sender:)), for: .touchUpInside)
        }
        
    }
    
    @objc func handleButtonTap(sender: UIButton) {
        
        let rawValue = sender.tag
        if rawValue == 12 {
            return
        }
        
        guard let buttonType = ButtonName(rawValue: rawValue) else { return }
        guard let coordinator = self.coordinator else {
            print("Ошибка: координатор не найден!")
            return
        }
        
        isEnableButton(active: false)
        jobIndicatorLoad(start: true)
        
        coordinator.openChildVC(typeVC: buttonType, userRealm: userRealm) { [weak self] in
            DispatchQueue.main.async {
                self?.isEnableButton(active: true)
                self?.jobIndicatorLoad(start: false)
            }
        }
    }
    
    @objc private func didTapOnAvatar() {
        
        //homeScreenView.imgProfile.isUserInteractionEnabled = false
        
        
        avatarOriginPoint = homeScreenView.imgProfile.center
        let scale = UIScreen.main.bounds.width / homeScreenView.imgProfile.bounds.width
        
        UIView.animate(withDuration: 0.5) {
            self.homeScreenView.imgProfile.layer.zPosition = 1000
            self.homeScreenView.imgProfile.center = CGPoint(x: UIScreen.main.bounds.midX,
                                                            y: UIScreen.main.bounds.midY - self.avatarOriginPoint.y)
            self.homeScreenView.imgProfile.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.homeScreenView.imgProfile.layer.cornerRadius = 0
            self.homeScreenView.imgProfile.isHidden = false
            self.homeScreenView.imgProfile.alpha = 0.7
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                //self.returnAvatarButton.alpha = 1
            }
        }
    }
    
    private func jobIndicatorLoad(start: Bool) {
        
        if start {
            homeScreenView.indicatorLoad.isHidden = false
            homeScreenView.indicatorLoad.startAnimating()
        } else {
            homeScreenView.indicatorLoad.isHidden = true
            homeScreenView.indicatorLoad.stopAnimating()
        }
    }
    
    private func isEnableButton(active: Bool) {
        arrayButtonView.forEach {
            $0.isEnabled = active
        }
    }
    
    
}

extension HomeScreenVC: UITableViewDelegate {
    
}

extension HomeScreenVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomTableViewCellNews.reuseIdentifier,
            for: indexPath
        ) as! CustomTableViewCellNews
        
        let item = newsArray[indexPath.row]
        cell.configure(text: item.textNews, colorHex: item.colorHex)
        
        return cell
    }
    
}
