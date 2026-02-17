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
        VStack(alignment: .leading, spacing: 20) {
            // Header
            Text("Today's Progress")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(.textPrimary)
            
            // Stats Grid - Horizontal with subtle dividers
            HStack(spacing: 0) {
                StatCard(
                    value: "\(sessionsToday)",
                    label: "Sessions",
                    color: .appPrimary
                )
                
                // Divider
                Rectangle()
                    .fill(Color.cardElevated)
                    .frame(width: 1)
                    .padding(.vertical, 12)
                
                StatCard(
                    value: formatTime(focusTimeToday),
                    label: "Focus Time",
                    color: .focusExcellent
                )
                
                // Divider
                Rectangle()
                    .fill(Color.cardElevated)
                    .frame(width: 1)
                    .padding(.vertical, 12)
                
                StatCard(
                    value: "\(Int(averageFocus))%",
                    label: "Avg Focus",
                    color: .appSecondary
                )
            }
        }
        .padding(24)
        .background(Color.cardBackground)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.cardElevated, lineWidth: 1)
        )
        .padding(.horizontal, 24)
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
        VStack(spacing: 8) {
            Text(value)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [color, color.opacity(0.7)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            Text(label)
                .font(.system(size: 13, weight: .medium, design: .rounded))
                .foregroundColor(.textSecondary)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ZStack {
        Color.darkBackground
            .ignoresSafeArea()
        
        QuickStatsView(
            sessionsToday: 2,
            focusTimeToday: 3600,
            averageFocus: 87.5
        )
    }
    .preferredColorScheme(.dark)
}
