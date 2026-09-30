//
//  transportTableCell.swift
//  remitApp_main
//
//  Created by Егор Голубев on 21.10.2025.
//

import UIKit
import SnapKit

struct routeCellData {
    let idRoute1C: String
    let bus: Bool
    let idTransportationStop1C: String
    let nameTransportationStop: String
    var countPeopleTransportationStop: Int
    let time: Date
}

// Ячейка только сообщает о подтверждённой записи. Сетевой запрос и обновление
// модели выполняет контроллер: раньше этим занималась сама ячейка и правила
// массивы контроллера напрямую.
protocol TransportCellDelegate: AnyObject {
    func didConfirmWaiting(for cell: transportTableCell, dataRoute: routeCellData)
}

class transportTableCell: UITableViewCell {

    static let reuseIdentifier = "CustomTableViewCell"
    weak var delegate: TransportCellDelegate?

    var routeData = routeCellData(
        idRoute1C: "",
        bus: false,
        idTransportationStop1C: "",
        nameTransportationStop: "",
        countPeopleTransportationStop: 0,
        time: Date.distantPast
    )
    
    private let dateRoute: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let nameRoute: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let imgPeople: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "figure.walk")
        img.tintColor = .red
        return img
    }()
    
    private  let countPeople: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var signUpForStopButton: UIButton = {
        let button = UIButton()
        button.setTitle("Жду", for: .normal)
        button.addTarget(self, action: #selector(signUpForStop), for: .touchUpInside)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        contentView.backgroundColor = .white
        
        [dateRoute, nameRoute, imgPeople, countPeople, signUpForStopButton].forEach
        { contentView.addSubview($0) }
        
        dateRoute.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).inset(10)
            $0.left.equalTo(contentView.snp.left).inset(10)
            $0.bottom.equalTo(contentView.snp.bottom).inset(10)
        }
        
        nameRoute.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).inset(10)
            $0.left.equalTo(dateRoute.snp.right).inset(-5)
            $0.bottom.equalTo(contentView.snp.bottom).inset(10)
        }
        
        signUpForStopButton.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).inset(10)
            $0.right.equalTo(contentView.snp.right).inset(10)
            $0.bottom.equalTo(contentView.snp.bottom).inset(10)
            $0.width.equalTo(50)
        }
        
        imgPeople.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).inset(10)
            $0.right.equalTo(signUpForStopButton.snp.left).inset(-10)
            $0.bottom.equalTo(contentView.snp.bottom).inset(10)
        }
        
        countPeople.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).inset(10)
            $0.right.equalTo(imgPeople.snp.left).inset(-5)
            $0.bottom.equalTo(contentView.snp.bottom).inset(10)
        }
    }
    
    func configure(dataCell:  routeCellData ) {
        routeData = dataCell
        nameRoute.text = routeData.nameTransportationStop
        countPeople.text = routeData.countPeopleTransportationStop.description
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "HH:mm"
        let formattedDateString = outputDateFormatter.string(from: routeData.time)
        dateRoute.text = formattedDateString
        countPeople.isHidden = !(routeData.countPeopleTransportationStop > 0)
        imgPeople.isHidden = !(routeData.countPeopleTransportationStop > 0)
    }
    
    @objc private func signUpForStop() {
        let configAlert = ConfigAlert(
            title: "Запись на остановку",
            message: "Записаться на остановку \(routeData.nameTransportationStop)?",
            type: .alert,
            actions: [
                UIAlertAction(title: "Да", style: .default) { [weak self] _ in
                    guard let self = self else { return }
                    self.delegate?.didConfirmWaiting(for: self, dataRoute: self.routeData)
                },
                UIAlertAction(title: "Нет", style: .cancel)
            ]
        )
        CustomAlert().showAlert(config: configAlert)
    }


    
    
    
}
