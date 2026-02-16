//
//  RoastMeStudyBuddyApp.swift
//  RoastMeStudyBuddy
//
//  Created on February 15, 2026.
//

import SwiftUI
import SwiftData

@main
struct RoastMeStudyBuddyApp: App {
    
    @StateObject private var sessionManager: SessionManager
    private let persistence: PersistenceService
    
    init() {
        let persistence = PersistenceService()
        self.persistence = persistence
        
        let focusDetection = MockFocusDetectionService()
        let roastGenerator = RoastGenerationService()
        
        _sessionManager = StateObject(wrappedValue: SessionManager(
            focusDetection: focusDetection,
            roastGenerator: roastGenerator,
            persistence: persistence
        ))
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(sessionManager)
                .modelContainer(persistence.container)
        }
    }
}
