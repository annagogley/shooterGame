//
//  CollisionCategory.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 19.09.2023.
//

import Foundation

struct CollisionCategory: OptionSet {
    let rawValue: Int
    
    static let bullets = CollisionCategory(rawValue: 1 << 0)
    static let target = CollisionCategory(rawValue: 1 << 1)
}
