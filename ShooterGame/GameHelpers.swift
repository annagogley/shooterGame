//
//  CollisionCategory.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 14.09.2023.
//

import Foundation

struct CollisionCategory: OptionSet {
    let rawValue: Int
    
    static let bullets  = CollisionCategory(rawValue: 1 << 0) // 00...01
    static let target = CollisionCategory(rawValue: 1 << 1) // 00..10
}


class ShooterSettings {
    static let sharedInstance = ShooterSettings()
    
    var score:Int
    var state = State.Start
    var targets = [Sphere]()
    
    private init() {
        score = 0
    }
    
    func resetGame() {
        score = 0
    }
    
    enum State {
        case Start
        case InGame
    }
}
