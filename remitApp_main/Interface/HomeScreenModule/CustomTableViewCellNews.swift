//
//  CustomTableViewCellNews.swift
//  remitApp_main
//
//  Created by Егор Голубев on 02.10.2025.
//

import UIKit
import SnapKit

class CustomTableViewCellNews: UITableViewCell {
    
    
    static let reuseIdentifier = "CustomTableViewCell"

    let mainLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(mainLabel)

        mainLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).inset(10)
            $0.left.equalTo(contentView.snp.left).inset(10)
            $0.right.equalTo(contentView.snp.right).inset(5)
            $0.bottom.equalTo(contentView.snp.bottom).inset(10)
        }
    }

    func configure(text: String, colorHex: String) {
        mainLabel.text = text
        mainLabel.textColor = CustomColor(hexString: colorHex)
    }

}
