//
//  VacationModel.swift
//  remitApp_main
//
//  Created by Егор Голубев on 06.06.2025.
//

import Foundation
import UIKit

protocol VacationViewDelegate: AnyObject {
    func didSelectDate()
    func didSelectButtonVacation()
    func didSelectButtonDoneKeyboard()
}
