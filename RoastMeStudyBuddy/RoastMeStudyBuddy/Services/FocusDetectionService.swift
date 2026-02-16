//
//  FocusDetectionService.swift
//  RoastMeStudyBuddy
//
//  Created on February 15, 2026.
//

import Foundation
import Combine

protocol FocusDetectionServiceProtocol {
    var focusStatePublisher: AnyPublisher<UserFocusState, Never> { get }
    func startMonitoring() async throws
    func stopMonitoring()
}

enum UserFocusState: Equatable {
    case focused
    case distracted(reason: String)
}

// MARK: - Mock Implementation (for MVP)

final class MockFocusDetectionService: FocusDetectionServiceProtocol {
    
    private let focusStateSubject = PassthroughSubject<UserFocusState, Never>()
    var focusStatePublisher: AnyPublisher<UserFocusState, Never> {
        focusStateSubject.eraseToAnyPublisher()
    }
    
    private var isMonitoring = false
    private var monitoringTask: Task<Void, Never>?
    
    func startMonitoring() async throws {
        print("🎬 Mock Focus Detection Started")
        isMonitoring = true
        startMockDetectionLoop()
    }
    
    func stopMonitoring() {
        print("🛑 Mock Focus Detection Stopped")
        isMonitoring = false
        monitoringTask?.cancel()
    }
    
    private func startMockDetectionLoop() {
        monitoringTask = Task {
            while isMonitoring {
                // Simulate random focus state changes
                let isFocused = Bool.random() // 70% chance of staying focused
                
                if isFocused {
                    focusStateSubject.send(.focused)
                } else {
                    let distractions = [
                        "Phone usage detected",
                        "Looking away from screen",
                        "Checking notifications",
                        "Scrolling social media"
                    ]
                    let reason = distractions.randomElement() ?? "Distraction detected"
                    focusStateSubject.send(.distracted(reason: reason))
                }
                
                // Check every 15-30 seconds (randomized for realism)
                let interval = UInt64.random(in: 15_000_000_000...30_000_000_000)
                try? await Task.sleep(nanoseconds: interval)
            }
        }
    }
    
    // Simulate manual distraction (for testing UI)
    func simulateDistraction() {
        focusStateSubject.send(.distracted(reason: "Manual test distraction"))
    }
}

// TODO: Real implementation using AVFoundation + Core ML
// final class FocusDetectionService: FocusDetectionServiceProtocol {
//     private var captureSession: AVCaptureSession?
//     private var visionRequests: [VNRequest] = []
//     // Implement real camera-based detection
// }
