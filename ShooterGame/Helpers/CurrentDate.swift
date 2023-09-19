//
//  CurrentDate.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 20.09.2023.
//

import Foundation

final class CurrentDate {
    static let shared = CurrentDate()
    
    func currentDate() -> String {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDay = formatter.string(from: currentDateTime)
        return currentDay
    }
}
