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
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [.purple.opacity(0.3), .blue.opacity(0.2)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        VStack(spacing: 8) {
                            Text("RoastMe Study Buddy")
                                .font(.largeTitle.bold())
                            Text("Let's get roasted into productivity")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.top, 32)
                        
                        // Streak Badge
                        StreakBadgeView(currentStreak: currentStreak, goal: 7)
                        
                        // Today's Stats
                        QuickStatsView(
                            sessionsToday: todayStats.sessions,
                            focusTimeToday: todayStats.focusTime,
                            averageFocus: todayStats.averageFocus
                        )
                        
                        // Start Session Button
                        Button {
                            showingSessionSetup = true
                        } label: {
                            HStack {
                                Image(systemName: "flame.fill")
                                Text("Start Study Session")
                                    .font(.headline)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange.gradient)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                        }
                        .padding(.horizontal)
                        
                        // Navigation Links
                        VStack(spacing: 12) {
                            NavigationLink(destination: HistoryView()) {
                                HomeMenuRow(
                                    icon: "chart.bar.fill",
                                    title: "Session History",
                                    subtitle: "View past sessions"
                                )
                            }
                            
                            NavigationLink(destination: SettingsView()) {
                                HomeMenuRow(
                                    icon: "gear",
                                    title: "Settings",
                                    subtitle: "Customize your experience"
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .sheet(isPresented: $showingSessionSetup) {
                SessionSetupView(showingActiveSession: $showingActiveSession)
            }
            .fullScreenCover(isPresented: $showingActiveSession) {
                ActiveSessionView()
            }
            .onAppear {
                loadStats()
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
