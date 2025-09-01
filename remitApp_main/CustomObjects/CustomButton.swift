//
//  CustomButton.swift
//  remitApp_main
//
//  Created by Егор Голубев on 23.05.2025.
//

import UIKit

struct ButtonConfig {
    let title: String?
    let backgroundColor: UIColor?
    let systemIconName: String?
    let tintColor: UIColor?
    let imageEdgeInsets: UIEdgeInsets?
    let contentHorizontalAlignment: UIControl.ContentHorizontalAlignment?
    let contentVerticalAlignment: UIControl.ContentVerticalAlignment?
    let targetSelectorPair: (target: AnyObject?, selector: Selector?)?
    let cornerRadius: CGFloat?
    let systemIconNameBool: Bool = true
    let tag: Int?
}

final class CustomButton: UIButton {

    convenience init(config: ButtonConfig) {
        self.init(frame: .zero)
        
        config.title.map { setTitle($0, for: .normal) }
        config.backgroundColor.map { backgroundColor = $0 }
        if config.systemIconNameBool {
            config.systemIconName.map { setImage(UIImage(systemName: $0), for: .normal) }
        } else {
            config.systemIconName.map { setImage(UIImage(named: $0), for: .normal) }
        }
        config.tintColor.map { tintColor = $0 }
        config.imageEdgeInsets.map { imageEdgeInsets = $0 }
        config.contentHorizontalAlignment.map { contentHorizontalAlignment = $0 }
        config.contentVerticalAlignment.map { contentVerticalAlignment = $0 }
        config.cornerRadius.map { layer.cornerRadius = $0 }
        config.tag.map { tag = $0 }
        
        if let pair = config.targetSelectorPair, let target = pair.target, let selector = pair.selector {
            addTarget(target, action: selector, for: .touchUpInside)
        }
    }
}
