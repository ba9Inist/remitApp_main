//
//  CustomStackView.swift
//  remitApp_main
//
//  Created by Егор Голубев on 05.06.2025.
//

import UIKit

struct stackConfig {
    let axis: NSLayoutConstraint.Axis?
    let spacing: CGFloat?
    let distribution: UIStackView.Distribution?
    let arrangedSubviews: [UIView]?
}

class CustomStackView: UIStackView {

    convenience init(config: stackConfig) {
        self.init(frame: .zero)
        config.axis.map { axis = $0 }
        config.spacing.map { spacing = $0 }
        config.distribution.map { distribution = $0 }
        
        if let arrangedSubviews = config.arrangedSubviews {
                    for view in arrangedSubviews {
                        addArrangedSubview(view)
                    }
                }
    }

}
