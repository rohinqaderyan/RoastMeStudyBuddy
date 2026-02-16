//
//  SessionManager.swift
//  RoastMeStudyBuddy
//
//  Created on February 15, 2026.
//

import Foundation
import Combine
import UIKit

@MainActor
final class SessionManager: ObservableObject {
    
    @Published var currentSession: StudySession?
    @Published var isSessionActive = false
    @Published var elapsedTime: TimeInterval = 0
    
    private let focusDetection: FocusDetectionServiceProtocol
    private let roastGenerator: RoastGenerationServiceProtocol
    private let persistence: PersistenceService
    private var cancellables = Set<AnyCancellable>()
    
    private var sessionTimer: Timer?
    private var currentFocusStreak: TimeInterval = 0
    private var lastFocusState: UserFocusState = .focused
    
    init(
        focusDetection: FocusDetectionServiceProtocol,
        roastGenerator: RoastGenerationServiceProtocol,
        persistence: PersistenceService
    ) {
        self.focusDetection = focusDetection
        self.roastGenerator = roastGenerator
        self.persistence = persistence
    }
    
    // MARK: - Session Lifecycle
    
    func startSession(
        duration: TimeInterval,
        taskName: String,
        mode: PersonalityMode
    ) async throws {
        let session = StudySession(
            plannedDuration: duration,
            taskName: taskName,
            personalityMode: mode
        )
        currentSession = session
        isSessionActive = true
        elapsedTime = 0
        currentFocusStreak = 0
        
        // Start monitoring
        try await focusDetection.startMonitoring()
        
        // Subscribe to focus state changes
        focusDetection.focusStatePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                Task { @MainActor in
                    await self?.handleFocusStateChange(state)
                }
            }
            .store(in: &cancellables)
        
        // Start session timer
        startTimer()
        
        print("✅ Session started: \(taskName) for \(duration/60) minutes")
    }
    
    func pauseSession() {
        sessionTimer?.invalidate()
        print("⏸️ Session paused")
    }
    
    func resumeSession() {
        startTimer()
        print("▶️ Session resumed")
    }
    
    func endSession() {
        guard let session = currentSession else { return }
        
        session.endTime = Date()
        session.actualDuration = elapsedTime
        
        // Calculate final statistics
        session.statistics = calculateStatistics(for: session)
        
        // Save to persistence
        persistence.saveSession(session)
        
        // Stop monitoring
        focusDetection.stopMonitoring()
        
        // Clear state
        sessionTimer?.invalidate()
        currentSession = nil
        isSessionActive = false
        elapsedTime = 0
        cancellables.removeAll()
        
        print("🏁 Session ended. Stats: \(session.statistics?.focusPercentage ?? 0)% focus")
    }
    
    // MARK: - Focus State Management
    
    private func handleFocusStateChange(_ state: UserFocusState) async {
        guard let session = currentSession else { return }
        
        // Detect state transition
        let wasDistracted = {
            if case .distracted = lastFocusState { return true }
            return false
        }()
        
        let isNowDistracted = {
            if case .distracted = state { return true }
            return false
        }()
        
        lastFocusState = state
        
        // Only generate messages on state transitions
        if wasDistracted != isNowDistracted {
            let event = FocusEvent(
                timestamp: Date(),
                eventType: isNowDistracted ? .distractionDetected : .focusStart,
                duration: nil
            )
            
            await generateAndAddMessage(for: event, session: session)
            
            // Update session stats
            if isNowDistracted {
                session.distractionCount += 1
                session.focusScore = max(0, session.focusScore - 5.0)
                currentFocusStreak = 0
            } else {
                session.focusScore = min(100, session.focusScore + 2.0)
            }
        }
    }
    
    private func generateAndAddMessage(for event: FocusEvent, session: StudySession) async {
        let context = SessionContext(
            currentFocusStreak: currentFocusStreak,
            distractionCount: session.distractionCount,
            timeRemaining: session.plannedDuration - elapsedTime,
            taskName: session.taskName
        )
        
        let message = await roastGenerator.generateMessage(
            for: event,
            mode: session.personalityMode,
            context: context
        )
        
        session.roastMessages.append(message)
        
        // Trigger haptics/sound effects based on message type
        playFeedback(for: message.type)
    }
    
    // MARK: - Timer
    
    private func startTimer() {
        sessionTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            Task { @MainActor in
                guard let self = self, let session = self.currentSession else { return }
                
                self.elapsedTime += 1
                
                // Update focus time if focused
                if case .focused = self.lastFocusState {
                    session.focusTimeTotal += 1
                    self.currentFocusStreak += 1
                }
                
                // Check for milestones
                await self.checkMilestones(session: session)
                
                // Check if session complete
                if self.elapsedTime >= session.plannedDuration {
                    await self.generateCompletionMessage(session: session)
                    self.endSession()
                }
            }
        }
    }
    
    private func checkMilestones(session: StudySession) async {
        // Generate praise at 25%, 50%, 75%, 100% completion
        let progress = elapsedTime / session.plannedDuration
        let milestones: [Double] = [0.25, 0.5, 0.75]
        
        for milestone in milestones {
            if abs(progress - milestone) < 0.01 { // Within 1% of milestone
                let event = FocusEvent(
                    timestamp: Date(),
                    eventType: .focusStart,
                    duration: nil
                )
                await generateAndAddMessage(for: event, session: session)
            }
        }
    }
    
    private func generateCompletionMessage(session: StudySession) async {
        let event = FocusEvent(
            timestamp: Date(),
            eventType: .focusStart,
            duration: session.actualDuration
        )
        
        let context = SessionContext(
            currentFocusStreak: currentFocusStreak,
            distractionCount: session.distractionCount,
            timeRemaining: 0,
            taskName: session.taskName
        )
        
        let completionMessages: [PersonalityMode: String] = [
            .savageRoaster: "Well, you actually finished! Didn't think you had it in you. 😏",
            .supportiveCoach: "AMAZING! You completed the full session! So proud of you! 🌟",
            .drillSergeant: "MISSION ACCOMPLISHED! Outstanding work, soldier! 🎖️"
        ]
        
        let content = completionMessages[session.personalityMode] ?? "Session complete!"
        
        let message = RoastMessage(
            timestamp: Date(),
            content: content,
            type: .milestone,
            trigger: .endOfSession
        )
        
        session.roastMessages.append(message)
    }
    
    // MARK: - Statistics
    
    private func calculateStatistics(for session: StudySession) -> SessionStatistics {
        let totalTime = elapsedTime
        let focusTime = session.focusTimeTotal
        let distractionTime = totalTime - focusTime
        let focusPercentage = totalTime > 0 ? (focusTime / totalTime) * 100 : 0
        
        return SessionStatistics(
            totalTime: totalTime,
            focusTime: focusTime,
            distractionTime: distractionTime,
            averageFocusStreak: focusTime / max(1, Double(session.distractionCount + 1)),
            longestFocusStreak: currentFocusStreak,
            focusPercentage: focusPercentage,
            distractionCount: session.distractionCount,
            roastCount: session.roastMessages.filter { $0.type == .roast }.count,
            praiseCount: session.roastMessages.filter { $0.type == .praise }.count
        )
    }
    
    // MARK: - Feedback
    
    private func playFeedback(for messageType: RoastMessage.MessageType) {
        let generator = UINotificationFeedbackGenerator()
        switch messageType {
        case .roast:
            generator.notificationOccurred(.warning)
        case .praise, .milestone:
            generator.notificationOccurred(.success)
        }
    }
}
