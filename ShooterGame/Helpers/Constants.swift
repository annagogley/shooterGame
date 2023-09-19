//
//  Constants.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 19.09.2023.
//

import Foundation

struct Const {
    static let gunSoundURL =  Bundle.main.url(forResource: "art.scnassets/gun", withExtension: "mp3")!
    static let blowSoundURL =  Bundle.main.url(forResource: "art.scnassets/blow", withExtension: "mp3")!
    static let particlesScene = "art.scnassets/particles.scn"
    static let particles = "particles"
    static let crossImage = "cross"
    static let trophy = "trophy"
    static let noStatMessage = "There are no statistics yet, play the first game to find out your accuracy!"
}
