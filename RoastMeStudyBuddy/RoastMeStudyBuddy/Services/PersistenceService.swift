//
//  PersistenceService.swift
//  RoastMeStudyBuddy
//
//  Created on February 15, 2026.
//

import Foundation
import SwiftData

@MainActor
final class PersistenceService {
    
    let container: ModelContainer
    let context: ModelContext
    
    init() {
        let schema = Schema([
            StudySession.self,
            UserPreferences.self
        ])
        
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            container = try ModelContainer(for: schema, configurations: [config])
            context = ModelContext(container)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
    
    // MARK: - Session Operations
    
    func saveSession(_ session: StudySession) {
        context.insert(session)
        do {
            try context.save()
        } catch {
            print("❌ Failed to save session: \(error)")
        }
    }
    
    func fetchSessions(limit: Int = 100) -> [StudySession] {
        let descriptor = FetchDescriptor<StudySession>(
            sortBy: [SortDescriptor(\.startTime, order: .reverse)]
        )
        return (try? context.fetch(descriptor)) ?? []
    }
    
    func fetchSessionsForDate(_ date: Date) -> [StudySession] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let predicate = #Predicate<StudySession> { session in
            session.startTime >= startOfDay && session.startTime < endOfDay
        }
        
        let descriptor = FetchDescriptor<StudySession>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.startTime, order: .reverse)]
        )
        
        return (try? context.fetch(descriptor)) ?? []
    }
    
    func deleteSession(_ session: StudySession) {
        context.delete(session)
        try? context.save()
    }
    
    // MARK: - Preferences Operations
    
    func fetchPreferences() -> UserPreferences {
        let descriptor = FetchDescriptor<UserPreferences>()
        if let prefs = try? context.fetch(descriptor).first {
            return prefs
        } else {
            let newPrefs = UserPreferences()
            context.insert(newPrefs)
            try? context.save()
            return newPrefs
        }
    }
    
    func updatePreferences(_ preferences: UserPreferences) {
        do {
            try context.save()
        } catch {
            print("❌ Failed to update preferences: \(error)")
        }
    }
    
    // MARK: - Statistics
    
    func calculateCurrentStreak() -> Int {
        let sessions = fetchSessions()
        guard !sessions.isEmpty else { return 0 }
        
        let calendar = Calendar.current
        var streak = 0
        var currentDate = calendar.startOfDay(for: Date())
        
        let sessionDates = Set(sessions.map { calendar.startOfDay(for: $0.startTime) })
        
        while sessionDates.contains(currentDate) {
            streak += 1
            currentDate = calendar.date(byAdding: .day, value: -1, to: currentDate)!
        }
        
        return streak
    }
    
    func getTodayStats() -> (sessions: Int, focusTime: TimeInterval, averageFocus: Double) {
        let todaySessions = fetchSessionsForDate(Date())
        let sessionsCount = todaySessions.count
        let totalFocusTime = todaySessions.reduce(0.0) { $0 + $1.focusTimeTotal }
        let averageFocus = todaySessions.isEmpty ? 0.0 : todaySessions.reduce(0.0) { $0 + $1.focusScore } / Double(todaySessions.count)
        
        return (sessionsCount, totalFocusTime, averageFocus)
    }
}
