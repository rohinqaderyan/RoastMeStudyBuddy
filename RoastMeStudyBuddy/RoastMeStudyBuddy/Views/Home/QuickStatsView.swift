//
//  QuickStatsView.swift
//  RoastMeStudyBuddy
//
//  Created on February 15, 2026.
//

import SwiftUI

struct QuickStatsView: View {
    let sessionsToday: Int
    let focusTimeToday: TimeInterval
    let averageFocus: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Today's Progress")
                .font(.headline)
            
            HStack(spacing: 16) {
                StatCard(
                    value: "\(sessionsToday)",
                    label: "Sessions",
                    color: .blue
                )
                
                StatCard(
                    value: formatTime(focusTimeToday),
                    label: "Focus Time",
                    color: .green
                )
                
                StatCard(
                    value: "\(Int(averageFocus))%",
                    label: "Avg Focus",
                    color: .purple
                )
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
    
    private func formatTime(_ seconds: TimeInterval) -> String {
        let hours = Int(seconds) / 3600
        let minutes = (Int(seconds) % 3600) / 60
        return hours > 0 ? "\(hours)h \(minutes)m" : "\(minutes)m"
    }
}

struct StatCard: View {
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2.bold())
                .foregroundColor(color)
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(color.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    QuickStatsView(
        sessionsToday: 2,
        focusTimeToday: 3600,
        averageFocus: 87.5
    )
    .padding()
}
