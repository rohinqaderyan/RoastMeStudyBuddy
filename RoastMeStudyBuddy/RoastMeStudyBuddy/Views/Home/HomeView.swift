//
//  HomeView.swift
//  RoastMeStudyBuddy
//
//  Created on February 15, 2026.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @Environment(\.modelContext) private var modelContext
    
    @State private var showingSessionSetup = false
    @State private var showingActiveSession = false
    @State private var currentStreak = 0
    @State private var todayStats: (sessions: Int, focusTime: TimeInterval, averageFocus: Double) = (0, 0, 0)
    @State private var glowAnimation = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Dark background
                Color.darkBackground
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 32) {
                        // Header Section - Minimal and Clean
                        VStack(spacing: 16) {
                            // Minimal icon with subtle glow
                            ZStack {
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [.appPrimary, .appSecondary],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 80, height: 80)
                                    .blur(radius: 30)
                                    .opacity(glowAnimation ? 0.6 : 0.3)
                                
                                Image(systemName: "flame.fill")
                                    .font(.system(size: 40, weight: .medium))
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [.appPrimary, .appSecondary],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                            }
                            
                            VStack(spacing: 8) {
                                Text("RoastMe Study Buddy")
                                    .font(.system(size: 32, weight: .bold, design: .rounded))
                                    .foregroundColor(.textPrimary)
                                
                                Text("Minimal. Focused. Productive.")
                                    .font(.system(size: 15, weight: .medium, design: .rounded))
                                    .foregroundColor(.textSecondary)
                            }
                        }
                        .padding(.top, 40)
                        
                        // Streak Badge - Minimal Design
                        StreakBadgeView(currentStreak: currentStreak, goal: 7)
                        
                        // Today's Stats - Clean Cards
                        QuickStatsView(
                            sessionsToday: todayStats.sessions,
                            focusTimeToday: todayStats.focusTime,
                            averageFocus: todayStats.averageFocus
                        )
                        
                        // Primary Action Button - Sleek Design
                        Button {
                            showingSessionSetup = true
                        } label: {
                            HStack(spacing: 12) {
                                Image(systemName: "play.circle.fill")
                                    .font(.system(size: 24, weight: .medium))
                                
                                Text("Start Session")
                                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                                
                                Spacer()
                                
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 20)
                            .background(
                                ZStack {
                                    // Subtle glow layer
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(
                                            LinearGradient(
                                                colors: [.appPrimary, .appSecondary],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                        .blur(radius: 20)
                                        .opacity(0.3)
                                    
                                    // Main button
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(
                                            LinearGradient(
                                                colors: [.appPrimary, .appSecondary],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                }
                            )
                        }
                        .padding(.horizontal, 24)
                        
                        // Navigation Cards - Minimal and Clean
                        VStack(spacing: 16) {
                            NavigationLink(destination: HistoryView()) {
                                MinimalMenuCard(
                                    icon: "chart.bar.fill",
                                    title: "History",
                                    description: "Past sessions"
                                )
                            }
                            
                            NavigationLink(destination: SettingsView()) {
                                MinimalMenuCard(
                                    icon: "gearshape.fill",
                                    title: "Settings",
                                    description: "Preferences"
                                )
                            }
                        }
                        .padding(.horizontal, 24)
                        
                        Spacer(minLength: 40)
                    }
                }
            }
            .preferredColorScheme(.dark)
            .sheet(isPresented: $showingSessionSetup) {
                SessionSetupView(showingActiveSession: $showingActiveSession)
            }
            .fullScreenCover(isPresented: $showingActiveSession) {
                ActiveSessionView()
            }
            .onAppear {
                loadStats()
                withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                    glowAnimation = true
                }
            }
        }
    }
    
    private func loadStats() {
        // Load streak and today's stats from persistence
        // This would normally use PersistenceService
        currentStreak = 3 // Placeholder
        todayStats = (2, 3600, 87.5) // Placeholder
    }
}

// MARK: - Minimal Menu Card
struct MinimalMenuCard: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon with subtle background
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.cardElevated)
                    .frame(width: 48, height: 48)
                
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.appPrimary)
            }
            
            // Text content
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundColor(.textPrimary)
                
                Text(description)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.textSecondary)
            }
            
            Spacer()
            
            // Chevron
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.textTertiary)
        }
        .padding(20)
        .background(Color.cardBackground)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.cardElevated, lineWidth: 1)
        )
    }
}

// MARK: - Legacy Menu Row (keeping for compatibility)
struct HomeMenuRow: View {
    let icon: String
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.blue)
                .frame(width: 40)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.tertiary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}

#Preview {
    HomeView()
        .environmentObject(SessionManager(
            focusDetection: MockFocusDetectionService(),
            roastGenerator: RoastGenerationService(),
            persistence: PersistenceService()
        ))
}
