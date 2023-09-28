//
//  UILabelExtension.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 28.09.2023.
//

import Foundation
import UIKit

extension UILabel {
    func setupTableViewCellLabel(label: UILabel, font: UIFont) {
        label.font = font
        label.translatesAutoresizingMaskIntoConstraints = false
    }
}
