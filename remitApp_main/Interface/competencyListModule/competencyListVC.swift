//
//  competencyListVC.swift
//  remitApp_main
//
//  Created by Егор Голубев on 17.10.2025.
//

import UIKit

struct competency {
    let ratingPercent: Int
    let dateCertification: Date
    let area: String
}

class competencyListVC: UIViewController {
    
    private var competencyView: competencyListView
    private var arrayCompetency = [competency]()
    private let realm = realmManager()
    
    
    
    init() {
        self.competencyView = competencyListView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        view = competencyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        competencyView.competencyTable.delegate = self
        competencyView.competencyTable.dataSource = self
        competencyView.competencyTable.register(customCellCompetencyList.self, forCellReuseIdentifier: customCellCompetencyList.reuseIdentifier)
        loadDataArray()
    }
    
    
    func loadDataArray() {
        guard let userData = realm.fetchUser() else { return }
        arrayCompetency = userData.listCompetencies.map { competencyItem in
            competency(ratingPercent: competencyItem.ratingPercent,
                       dateCertification: competencyItem.dateCertification,
                       area: competencyItem.area)
        }
        
        if arrayCompetency.isEmpty {
            competencyView.competencyTable.isHidden = false
            competencyView.setubCompetencyEmpty()
        } else {
            competencyView.competencyTable.reloadData()
        }
    }
    
    
}

extension competencyListVC: UITableViewDelegate {
    
}

extension competencyListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayCompetency.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: customCellCompetencyList.reuseIdentifier,
            for: indexPath
        ) as! customCellCompetencyList
        
        let item = arrayCompetency[indexPath.row]
        cell.configure(dateComp: item.dateCertification, nameComp: item.area, raitingComp: item.ratingPercent)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return customHeaderCompetencyListView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
}
