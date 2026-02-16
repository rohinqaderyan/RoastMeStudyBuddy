//
//  Constants.swift
//  RoastMeStudyBuddy
//
//  Created on February 15, 2026.
//

import Foundation

enum AppConstants {
    static let minSessionDuration: TimeInterval = 300 // 5 minutes
    static let maxSessionDuration: TimeInterval = 7200 // 2 hours
    static let defaultSessionDuration: TimeInterval = 1500 // 25 minutes
    
    static let focusCheckInterval: TimeInterval = 15 // Check focus every 15 seconds
    static let milestones: [Double] = [0.25, 0.5, 0.75, 1.0]
    
    static let maxFreeSessionsPerDay = 3
    static let maxHistoryDays = 90
}

enum AppColors {
    // Add custom color definitions here
}
