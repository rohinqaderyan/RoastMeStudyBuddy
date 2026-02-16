//
//  SessionCompleteView.swift
//  RoastMeStudyBuddy
//
//  Created on February 15, 2026.
//

import SwiftUI

struct SessionCompleteView: View {
    let session: StudySession
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [.green.opacity(0.3), .blue.opacity(0.2)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Success Icon
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 80))
                            .foregroundStyle(.green)
                            .padding(.top, 40)
                        
                        Text("Session Complete!")
                            .font(.largeTitle.bold())
                        
                        Text(session.taskName)
                            .font(.title3)
                            .foregroundStyle(.secondary)
                        
                        // Stats Cards
                        VStack(spacing: 16) {
                            StatRow(
                                icon: "clock.fill",
                                label: "Total Time",
                                value: formatDuration(session.actualDuration),
                                color: .blue
                            )
                            
                            StatRow(
                                icon: "target",
                                label: "Focus Score",
                                value: "\(Int(session.focusScore))%",
                                color: focusColor(session.focusScore)
                            )
                            
                            StatRow(
                                icon: "exclamationmark.triangle.fill",
                                label: "Distractions",
                                value: "\(session.distractionCount)",
                                color: .orange
                            )
                            
                            if let stats = session.statistics {
                                StatRow(
                                    icon: "bolt.fill",
                                    label: "Focus Time",
                                    value: formatDuration(stats.focusTime),
                                    color: .green
                                )
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(16)
                        .shadow(radius: 2)
                        .padding(.horizontal)
                        
                        // Share Button
                        ShareLink(
                            item: generateShareText(),
                            subject: Text("My Study Session"),
                            message: Text("Check out my focused study session!")
                        ) {
                            Label("Share Results", systemImage: "square.and.arrow.up")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                        
                        // Done Button
                        Button {
                            dismiss()
                        } label: {
                            Text("Done")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func formatDuration(_ seconds: TimeInterval) -> String {
        let minutes = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return "\(minutes)m \(secs)s"
    }
    
    private func focusColor(_ score: Double) -> Color {
        score >= 80 ? .green : (score >= 50 ? .orange : .red)
    }
    
    private func generateShareText() -> String {
        "Just completed a \(formatDuration(session.actualDuration)) study session with \(Int(session.focusScore))% focus! 🔥 #RoastMeStudyBuddy"
    }
}

struct StatRow: View {
    let icon: String
    let label: String
    let value: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 30)
            
            Text(label)
                .font(.body)
            
            Spacer()
            
            Text(value)
                .font(.headline)
                .foregroundColor(color)
        }
    }
}

#Preview {
    SessionCompleteView(session: {
        let session = StudySession(
            plannedDuration: 1500,
            taskName: "Study Math",
            personalityMode: .savageRoaster
        )
        session.actualDuration = 1500
        session.focusScore = 87.5
        session.distractionCount = 3
        return session
    }())
}
