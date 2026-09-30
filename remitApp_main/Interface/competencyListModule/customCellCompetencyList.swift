//
//  customCellCompetencyList.swift
//  remitApp_main
//
//  Created by Егор Голубев on 17.10.2025.
//

import UIKit
import SnapKit

class customCellCompetencyList: UITableViewCell {
    
    static let reuseIdentifier = "CustomTableViewCell"
    
    private lazy var dateCompetetionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var nameCompetetionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var ratingCompetetionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var imgCompetetionLabel: UIImageView = {
        let img = UIImageView()
        img.isHidden = true
        img.image = UIImage(systemName: "hand.thumbsup.circle.fill")
        img.tintColor = .systemGreen
        return img
    }()
    
    private lazy var stackUi: UIStackView = {
        let config = stackConfig(axis: .horizontal,
                                 spacing: 10,
                                 distribution: .fillEqually,
                                 arrangedSubviews: [nameCompetetionLabel, ratingCompetetionLabel])
        let stack = CustomStackView(config: config)
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        [dateCompetetionLabel, stackUi, imgCompetetionLabel].forEach{contentView.addSubview($0)}
            
        let contentSnp = contentView.snp

        dateCompetetionLabel.snp.makeConstraints {
            $0.top.equalTo(contentSnp.top).inset(10)
            $0.left.equalTo(contentSnp.left).inset(10)
            $0.right.lessThanOrEqualTo(imgCompetetionLabel.snp.left).offset(-10)
        }

        stackUi.snp.makeConstraints {
            $0.top.equalTo(dateCompetetionLabel.snp.bottom).inset(-10)
            $0.left.equalTo(contentSnp.left).inset(10)
            $0.right.lessThanOrEqualTo(imgCompetetionLabel.snp.left).offset(-10)
            $0.bottom.equalTo(contentSnp.bottom).inset(10)
        }

        imgCompetetionLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentSnp.centerY)
            $0.right.equalTo(contentSnp.right).inset(10)
            $0.width.height.equalTo(50)
        }
    }
    
    func configure(dateComp: Date, nameComp: String, raitingComp: Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let formattedDateComp = formatter.string(from: dateComp)
        
        dateCompetetionLabel.text = "Дата атестации: \(formattedDateComp)"
        nameCompetetionLabel.text = nameComp
        ratingCompetetionLabel.text = "\(raitingComp.description) %"
        
        if raitingComp > 80 {
            imgCompetetionLabel.isHidden = false
            ratingCompetetionLabel.textColor = .systemGreen
        } else {
            imgCompetetionLabel.isHidden = false
            imgCompetetionLabel.image = UIImage(systemName: "hand.thumbsdown.circle.fill")
            imgCompetetionLabel.tintColor = .red
            ratingCompetetionLabel.textColor = .red
        }
    }


}
