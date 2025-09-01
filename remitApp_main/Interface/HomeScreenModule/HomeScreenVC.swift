//
//  HomeScreenView.swift
//  remitApp_main
//
//  Created by Егор Голубев on 06.06.2025.
//

import UIKit

final class HomeScreenVC: UIViewController {
    
    private let homeScreenView: HomeScreenView
    weak var coordinator: MainCoordinator?
    
    init() {
        self.homeScreenView = HomeScreenView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = homeScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Кабинет сотрудника"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        homeScreenView.feedTable.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        homeScreenView.feedTable.delegate = self
        homeScreenView.feedTable.dataSource = self
    }
    
    @objc func handleButtonTap(sender: UIButton) {
        let rawValue = sender.tag
        guard let buttonType = ButtonName(rawValue: rawValue) else { return }
        guard let coordinator = self.coordinator else {
            print("Ошибка: координатор не найден!")
            return
        }
        coordinator.openChildVC(typeVC: buttonType)
    }
}

extension HomeScreenVC: UITableViewDelegate {
    
}

extension HomeScreenVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
}
