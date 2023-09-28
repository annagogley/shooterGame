//
//  UIButtonExtension.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 28.09.2023.
//

import Foundation
import UIKit

extension UIButton {
    func setupStartScreenButton(button: UIButton, title: String, color: UIColor) {
        button.backgroundColor = color
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
    }
}
