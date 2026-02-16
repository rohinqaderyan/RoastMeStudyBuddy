//
//  StudySession.swift
//  RoastMeStudyBuddy
//
//  Created on February 15, 2026.
//

import Foundation
import SwiftData

@Model
final class StudySession {
    var id: UUID
    var startTime: Date
    var endTime: Date?
    var plannedDuration: TimeInterval // in seconds
    var actualDuration: TimeInterval
    var taskName: String
    var personalityMode: PersonalityMode
    var focusScore: Double // 0.0 - 100.0
    var distractionCount: Int
    var focusTimeTotal: TimeInterval
    var roastMessages: [RoastMessage]
    var statistics: SessionStatistics?
    
    init(
        plannedDuration: TimeInterval,
        taskName: String,
        personalityMode: PersonalityMode
    ) {
        self.id = UUID()
        self.startTime = Date()
        self.plannedDuration = plannedDuration
        self.taskName = taskName
        self.personalityMode = personalityMode
        self.actualDuration = 0
        self.focusScore = 100.0
        self.distractionCount = 0
        self.focusTimeTotal = 0
        self.roastMessages = []
    }
}
