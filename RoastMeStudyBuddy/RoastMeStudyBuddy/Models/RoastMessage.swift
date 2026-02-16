//
//  RoastMessage.swift
//  RoastMeStudyBuddy
//
//  Created on February 15, 2026.
//

import Foundation

struct RoastMessage: Codable, Identifiable, Hashable {
    let id: UUID
    let timestamp: Date
    let content: String
    let type: MessageType
    let trigger: TriggerReason
    
    init(id: UUID = UUID(), timestamp: Date = Date(), content: String, type: MessageType, trigger: TriggerReason) {
        self.id = id
        self.timestamp = timestamp
        self.content = content
        self.type = type
        self.trigger = trigger
    }
    
    enum MessageType: String, Codable {
        case roast      // Negative/calling out distraction
        case praise     // Positive reinforcement
        case milestone  // Achievement unlocked
    }
    
    enum TriggerReason: String, Codable {
        case distracted       // Phone detected
        case refocused        // Back to work
        case timeGoal         // Hit time milestone
        case endOfSession     // Session complete
    }
}
