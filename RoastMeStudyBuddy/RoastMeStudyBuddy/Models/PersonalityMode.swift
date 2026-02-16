//
//  PersonalityMode.swift
//  RoastMeStudyBuddy
//
//  Created on February 15, 2026.
//

import Foundation

enum PersonalityMode: String, Codable, CaseIterable {
    case savageRoaster = "Savage Roaster"
    case supportiveCoach = "Supportive Coach"
    case drillSergeant = "Drill Sergeant"
    
    var description: String {
        switch self {
        case .savageRoaster:
            return "Brutal honesty with dark humor"
        case .supportiveCoach:
            return "Encouraging with gentle accountability"
        case .drillSergeant:
            return "Military-style discipline"
        }
    }
    
    var icon: String {
        switch self {
        case .savageRoaster: return "😈"
        case .supportiveCoach: return "💪"
        case .drillSergeant: return "🎖️"
        }
    }
}
