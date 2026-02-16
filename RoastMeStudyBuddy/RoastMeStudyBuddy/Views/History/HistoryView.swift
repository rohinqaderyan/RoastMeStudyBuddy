//
//  HistoryView.swift
//  RoastMeStudyBuddy
//
//  Created on February 15, 2026.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    @Query(sort: \StudySession.startTime, order: .reverse) var sessions: [StudySession]
    
    var body: some View {
        List {
            if sessions.isEmpty {
                ContentUnavailableView(
                    "No Sessions Yet",
                    systemImage: "book.closed",
                    description: Text("Complete your first study session to see it here!")
                )
            } else {
                ForEach(sessions) { session in
                    NavigationLink(destination: SessionDetailView(session: session)) {
                        SessionHistoryRow(session: session)
                    }
                }
            }
        }
        .navigationTitle("Session History")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct SessionHistoryRow: View {
    let session: StudySession
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(session.taskName)
                    .font(.headline)
                Spacer()
                Text("\(Int(session.focusScore))%")
                    .font(.subheadline.bold())
                    .foregroundColor(focusColor(session.focusScore))
            }
            
            HStack(spacing: 16) {
                Label(formatDuration(session.actualDuration), systemImage: "clock")
                Label("\(session.distractionCount)", systemImage: "exclamationmark.triangle")
                Spacer()
                Text(session.startTime.formatted(date: .abbreviated, time: .omitted))
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
    
    private func focusColor(_ score: Double) -> Color {
        score >= 80 ? .green : (score >= 50 ? .orange : .red)
    }
    
    private func formatDuration(_ seconds: TimeInterval) -> String {
        let minutes = Int(seconds) / 60
        return "\(minutes)m"
    }
}

struct SessionDetailView: View {
    let session: StudySession
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    Text(session.taskName)
                        .font(.title.bold())
                    Text(session.startTime.formatted(date: .long, time: .shortened))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.top)
                
                // Main Stats
                HStack(spacing: 20) {
                    VStack {
                        Text("\(Int(session.focusScore))")
                            .font(.system(size: 48, weight: .bold))
                            .foregroundColor(focusColor(session.focusScore))
                        Text("Focus Score")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    Divider()
                        .frame(height: 60)
                    
                    VStack {
                        Text(formatDuration(session.actualDuration))
                            .font(.system(size: 48, weight: .bold))
                        Text("Duration")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(16)
                .shadow(radius: 2)
                .padding(.horizontal)
                
                // Detailed Stats
                if let stats = session.statistics {
                    VStack(spacing: 12) {
                        StatRowDetail(label: "Focus Time", value: formatDuration(stats.focusTime), icon: "bolt.fill", color: .green)
                        StatRowDetail(label: "Distractions", value: "\(stats.distractionCount)", icon: "exclamationmark.triangle.fill", color: .orange)
                        StatRowDetail(label: "Roasts Received", value: "\(stats.roastCount)", icon: "flame.fill", color: .red)
                        StatRowDetail(label: "Praise Received", value: "\(stats.praiseCount)", icon: "star.fill", color: .yellow)
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                }
                
                // Messages
                if !session.roastMessages.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Session Messages")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ForEach(session.roastMessages) { message in
                            MessageCard(message: message)
                        }
                    }
                }
            }
            .padding(.bottom, 40)
        }
        .navigationTitle("Session Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func focusColor(_ score: Double) -> Color {
        score >= 80 ? .green : (score >= 50 ? .orange : .red)
    }
    
    private func formatDuration(_ seconds: TimeInterval) -> String {
        let minutes = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return minutes > 0 ? "\(minutes)m \(secs)s" : "\(secs)s"
    }
}

struct StatRowDetail: View {
    let label: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 30)
            Text(label)
            Spacer()
            Text(value)
                .font(.headline)
        }
    }
}

struct MessageCard: View {
    let message: RoastMessage
    
    var backgroundColor: Color {
        switch message.type {
        case .roast: return .red.opacity(0.1)
        case .praise: return .green.opacity(0.1)
        case .milestone: return .blue.opacity(0.1)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(message.content)
                .font(.body)
            Text(message.timestamp.formatted(date: .omitted, time: .shortened))
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(backgroundColor)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        HistoryView()
            .modelContainer(for: [StudySession.self, UserPreferences.self])
    }
}
