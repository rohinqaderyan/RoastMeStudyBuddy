//
//  UserPreferences.swift
//  RoastMeStudyBuddy
//
//  Created on February 15, 2026.
//

import Foundation
import SwiftData

@Model
final class UserPreferences {
    var defaultPersonalityMode: PersonalityMode
    var defaultSessionDuration: TimeInterval
    var roastIntensity: Double // 0.0 - 1.0
    var soundEffectsEnabled: Bool
    var hapticsEnabled: Bool
    var notificationsEnabled: Bool
    var streakGoal: Int
    var isPremium: Bool
    
    init() {
        self.defaultPersonalityMode = .supportiveCoach
        self.defaultSessionDuration = 1500 // 25 min
        self.roastIntensity = 0.7
        self.soundEffectsEnabled = true
        self.hapticsEnabled = true
        self.notificationsEnabled = true
        self.streakGoal = 7
        self.isPremium = false
    }
}
