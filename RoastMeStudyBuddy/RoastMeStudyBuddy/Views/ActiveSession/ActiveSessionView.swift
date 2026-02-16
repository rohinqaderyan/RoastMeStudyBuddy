//
//  ActiveSessionView.swift
//  RoastMeStudyBuddy
//
//  Created on February 15, 2026.
//

import SwiftUI

struct ActiveSessionView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @Environment(\.dismiss) var dismiss
    
    @State private var showingEndConfirmation = false
    @State private var showingSessionComplete = false
    @State private var completedSession: StudySession?
    
    var session: StudySession? {
        sessionManager.currentSession
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 32) {
                // Close button
                HStack {
                    Spacer()
                    Button {
                        showingEndConfirmation = true
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title3)
                            .foregroundColor(.white.opacity(0.7))
                            .padding()
                    }
                }
                
                if let session = session {
                    // Timer Display
                    VStack(spacing: 8) {
                        Text(formatTime(session.plannedDuration - sessionManager.elapsedTime))
                            .font(.system(size: 72, weight: .thin, design: .rounded))
                            .monospacedDigit()
                            .foregroundColor(.white)
                        
                        Text(session.taskName)
                            .font(.title3)
                            .foregroundStyle(.white.opacity(0.7))
                    }
                    .padding(.top, 20)
                    
                    // Focus Meter
                    FocusMeterView(focusScore: session.focusScore)
                    
                    Spacer()
                    
                    // Roast Feed
                    RoastFeedView(messages: session.roastMessages)
                        .frame(height: 200)
                    
                    // Controls
                    SessionControlsView(
                        onPause: { sessionManager.pauseSession() },
                        onEnd: { showingEndConfirmation = true }
                    )
                }
            }
        }
        .confirmationDialog(
            "End session early?",
            isPresented: $showingEndConfirmation,
            titleVisibility: .visible
        ) {
            Button("End Session", role: .destructive) {
                completedSession = sessionManager.currentSession
                sessionManager.endSession()
                showingSessionComplete = true
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("You'll still get stats for the time completed.")
        }
        .onChange(of: sessionManager.isSessionActive) { _, isActive in
            if !isActive && completedSession == nil {
                completedSession = sessionManager.currentSession
                showingSessionComplete = true
            }
        }
        .sheet(isPresented: $showingSessionComplete) {
            if let completed = completedSession {
                SessionCompleteView(session: completed)
            }
        }
    }
    
    private func formatTime(_ seconds: TimeInterval) -> String {
        let minutes = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
}

#Preview {
    ActiveSessionView()
        .environmentObject({
            let manager = SessionManager(
                focusDetection: MockFocusDetectionService(),
                roastGenerator: RoastGenerationService(),
                persistence: PersistenceService()
            )
            Task {
                try? await manager.startSession(
                    duration: 1500,
                    taskName: "Study Math",
                    mode: .savageRoaster
                )
            }
            return manager
        }())
}
