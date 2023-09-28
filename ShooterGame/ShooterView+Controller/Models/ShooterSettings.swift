//
//  CollisionCategory.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 14.09.2023.
//

import Foundation

class ShooterSettings {
    static let shared = ShooterSettings()
    
    var state = State.start
    var targets = [Sphere]()
    
    enum State {
        case start
        case inGame
    }
}
