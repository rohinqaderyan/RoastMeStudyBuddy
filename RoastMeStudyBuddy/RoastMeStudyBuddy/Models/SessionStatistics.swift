//
//  SessionStatistics.swift
//  RoastMeStudyBuddy
//
//  Created on February 15, 2026.
//

import Foundation

struct SessionStatistics: Codable {
    let totalTime: TimeInterval
    let focusTime: TimeInterval
    let distractionTime: TimeInterval
    let averageFocusStreak: TimeInterval
    let longestFocusStreak: TimeInterval
    let focusPercentage: Double
    let distractionCount: Int
    let roastCount: Int
    let praiseCount: Int
}
