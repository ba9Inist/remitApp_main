//
//  CustomColor.swift
//  remitApp_main
//
//  Created by Егор Голубев on 02.10.2025.
//

import UIKit

class CustomColor: UIColor {

}

extension CustomColor {
    
    convenience init?(hexString: String) {
        var chars = Array(hexString.hasPrefix("#") ? hexString.dropFirst() : hexString[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars.append(contentsOf: ["F","F"])
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]),nil,16)) / 255,
                 green: .init(strtoul(String(chars[2...3]),nil,16)) / 255,
                 blue: .init(strtoul(String(chars[4...5]),nil,16)) / 255,
                 alpha: .init(strtoul(String(chars[6...7]),nil,16)) / 255)
    }
}
