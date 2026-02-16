//
//  FocusEvent.swift
//  RoastMeStudyBuddy
//
//  Created on February 15, 2026.
//

import Foundation

struct FocusEvent: Identifiable {
    let id: UUID
    let timestamp: Date
    let eventType: EventType
    let duration: TimeInterval?
    
    init(id: UUID = UUID(), timestamp: Date = Date(), eventType: EventType, duration: TimeInterval? = nil) {
        self.id = id
        self.timestamp = timestamp
        self.eventType = eventType
        self.duration = duration
    }
    
    enum EventType {
        case focusStart
        case focusEnd
        case distractionDetected
        case phoneUsage
        case screenLock
    }
}
