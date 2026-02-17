//
//  StreakBadgeView.swift
//  RoastMeStudyBuddy
//
//  Created on February 15, 2026.
//

import SwiftUI

struct StreakBadgeView: View {
    let currentStreak: Int
    let goal: Int
    
    var progress: Double {
        min(Double(currentStreak) / Double(goal), 1.0)
    }
    
    var body: some View {
        HStack(spacing: 24) {
            // Circular Progress Indicator
            ZStack {
                // Background circle
                Circle()
                    .stroke(Color.cardElevated, lineWidth: 8)
                    .frame(width: 100, height: 100)
                
                // Progress circle with gradient
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        LinearGradient(
                            colors: [.appPrimary, .appSecondary],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(-90))
                    .animation(.spring(response: 0.8, dampingFraction: 0.6), value: progress)
                
                // Center content
                VStack(spacing: 4) {
                    Image(systemName: "flame.fill")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.appPrimary, .appSecondary],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    Text("\(currentStreak)")
                        .font(.system(size: 26, weight: .bold, design: .rounded))
                        .foregroundColor(.textPrimary)
                }
            }
            
            // Streak info
            VStack(alignment: .leading, spacing: 6) {
                Text("Day Streak")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.textPrimary)
                
                Text("Goal: \(goal) days")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.textSecondary)
                
                // Progress bar
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.cardElevated)
                            .frame(height: 6)
                        
                        RoundedRectangle(cornerRadius: 4)
                            .fill(
                                LinearGradient(
                                    colors: [.appPrimary, .appSecondary],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: geometry.size.width * progress, height: 6)
                            .animation(.spring(response: 0.8, dampingFraction: 0.6), value: progress)
                    }
                }
                .frame(height: 6)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
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
}

#Preview {
    ZStack {
        Color.darkBackground
            .ignoresSafeArea()
        
        VStack(spacing: 20) {
            StreakBadgeView(currentStreak: 3, goal: 7)
            StreakBadgeView(currentStreak: 7, goal: 7)
            StreakBadgeView(currentStreak: 0, goal: 7)
        }
    }
    .preferredColorScheme(.dark)
}
