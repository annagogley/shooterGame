//
//  CollisionCategory.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 14.09.2023.
//

import Foundation

class ShooterSettings {
    static let shared = ShooterSettings()
    
    var score: Int
    var state = State.start
    var targets = [Sphere]()
    
    private init() {
        score = 0
    }
    
    func resetGame() {
        score = 0
    }
    
    enum State {
        case start
        case inGame
    }
}
