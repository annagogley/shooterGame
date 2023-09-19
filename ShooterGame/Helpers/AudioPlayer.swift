//
//  AudioPlayer.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 19.09.2023.
//

import Foundation
import AVFAudio

struct AudioPlayer {
    var player = AVAudioPlayer()
    
    mutating func playSound(_ url: URL) {
        do {
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: nil)
            player.prepareToPlay()
            player.play()
        } catch {
            print("there is no sound")
        }
    }
}
