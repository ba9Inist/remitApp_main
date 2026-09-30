//
//  loyalityVC.swift
//  remitApp_main
//
//  Created by Егор Голубев on 21.02.2026.
//

import UIKit

class loyalityVC: UIViewController {
    
    private let loalityView = loyalityView()
    private let loalityModel = loyalityModel()
    var shoppingList = [ShoppingListSheme]()
    weak var coordinator: MainCoordinator?
    var infoLoyality: loyalityDataResponceScheme
    var userRealm: InformationUserRealm?
    var loadTable = true
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    lazy var tapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(showFullscreenImage))
        return tap
    }()
    
    init(info: loyalityDataResponceScheme, user: InformationUserRealm?, coordinator: MainCoordinator ) {
        self.infoLoyality = info
        self.userRealm = user
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        view = loalityView
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loalityView.shoppingList.dataSource = self
        loalityView.shoppingList.delegate = self
        
        loalityView.shoppingList.register(ShoppingListCell.self,
                                          forCellReuseIdentifier: ShoppingListCell.reuseIdentifier)
        
        if !infoLoyality.error.isEmpty {
            CustomAlert().showFastAlertError(textError: infoLoyality.error)
        }
        
        var nameCardRealm = ""
        if userRealm != nil {
            nameCardRealm = userRealm?.loyaltyCardNumber ?? ""
            guard !nameCardRealm.isEmpty else { return }
            
            self.loalityView.numberCard.text = nameCardRealm
            
            if let imgBarcode = loalityModel.qrCodeLoyalityCard(codeCard: nameCardRealm, size: 5.0) {
                self.loalityView.barcodeCard.image = imgBarcode
            }
        }
        
        if !infoLoyality.discountСard.isEmpty && infoLoyality.discountСard != nameCardRealm {
            CustomAlert().showFastAlertError(textError: "Карта лояльности не соответствует в 1C МПЗ и 1С Лояльности. Обратитесь в отдел персонала.")
        }
        
        loalityView.balanceCard.text = "Баланс лайков: \(infoLoyality.balanceLikes) (\(infoLoyality.balanceLikesRub) руб.)"
        shoppingList = infoLoyality.ShoppingList
        loalityView.shoppingList.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadTable = false
        loalityView.barcodeCard.addGestureRecognizer(tapGesture)
    }
    
    private func loadDataTable() {
        
        guard !loadTable else { return }
        loadTable = true
        loalityView.shoppingList.tableHeaderView = activityIndicator
        activityIndicator.startAnimating()
        
        loalityModel.getLoyalityData(updateCheck: true) { infoloyality in
            if !infoloyality.result {
                CustomAlert().showFastAlertError(textError: infoloyality.error)
            } else {
                self.shoppingList.removeAll()
                self.shoppingList = infoloyality.ShoppingList
                self.loadTable = false
                self.loalityView.shoppingList.tableHeaderView = nil
                self.activityIndicator.stopAnimating()
            }
        }
        
    }
    
   @objc private func showFullscreenImage() {
       var nameCardRealm = ""
       if userRealm != nil {
           nameCardRealm = userRealm?.loyaltyCardNumber ?? ""
           guard !nameCardRealm.isEmpty else { return }
           
           self.loalityView.numberCard.text = nameCardRealm
           
           if let imgBarcode = loalityModel.qrCodeLoyalityCard(codeCard: nameCardRealm, size: 7.0) {
               let verticalImage = UIImage(cgImage: imgBarcode.cgImage!,
                                            scale: imgBarcode.scale,
                                            orientation: .right)
               coordinator?.openBarcodeFullScreen(barcodeImg: verticalImage, originalBreght: UIScreen.main.brightness)
           }
       }
    }
    
}

extension loyalityVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ShoppingListCell.reuseIdentifier,
            for: indexPath
        ) as! ShoppingListCell
        
        let elementTable = shoppingList[indexPath.row]
        
        let dataCheckCell = dataCheck(checkАmount: elementTable.checkАmount,
                                      dateCheck: elementTable.dateCheck,
                                      likeCount: elementTable.likeCount,
                                      addressStore: elementTable.addressStore,
                                      products: elementTable.products)
        cell.delegate = self
        cell.configure(dataCell: dataCheckCell)
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 && !loadTable {
            loadDataTable()
        }
    }
}

extension loyalityVC: ShoppingListCellDelegate {
    func didSelectProductDetails(dataCell : dataCheck) {
        coordinator?.openProductDetails(dataCell: dataCell)
    }
}

