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
    @State private var floatingAnimation = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Enhanced background with mesh gradient
                MeshGradient(
                    width: 3,
                    height: 3,
                    points: [
                        [0, 0], [0.5, 0], [1, 0],
                        [0, 0.5], [0.5, 0.5], [1, 0.5],
                        [0, 1], [0.5, 1], [1, 1]
                    ],
                    colors: [
                        .purple.opacity(0.4), .pink.opacity(0.3), .orange.opacity(0.3),
                        .blue.opacity(0.3), .purple.opacity(0.2), .pink.opacity(0.4),
                        .indigo.opacity(0.3), .blue.opacity(0.4), .purple.opacity(0.3)
                    ]
                )
                .ignoresSafeArea()
                
                // Floating decorative elements
                FloatingDecorView()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Hero Section with Mascot
                        VStack(spacing: 16) {
                            // Hero Illustration
                            Image("HeroIllustration")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                                .scaleEffect(floatingAnimation ? 1.05 : 1.0)
                                .animation(
                                    Animation.easeInOut(duration: 2.0)
                                        .repeatForever(autoreverses: true),
                                    value: floatingAnimation
                                )
                            
                            // Title with emoji
                            HStack(spacing: 8) {
                                Text("🔥")
                                    .font(.system(size: 36))
                                Text("RoastMe Study Buddy")
                                    .font(.system(size: 28, weight: .black, design: .rounded))
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [.orange, .pink, .purple],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                Text("🔥")
                                    .font(.system(size: 36))
                            }
                            
                            Text("Get roasted into peak productivity! 📚✨")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 20)
                        
                        // Streak Badge with enhanced design
                        ZStack {
                            // Glow effect
                            Image("GradientOrb")
                                .resizable()
                                .frame(width: 120, height: 120)
                                .blur(radius: 20)
                                .opacity(0.6)
                            
                            StreakBadgeView(currentStreak: currentStreak, goal: 7)
                        }
                        
                        // Today's Stats with glass morphism
                        QuickStatsView(
                            sessionsToday: todayStats.sessions,
                            focusTimeToday: todayStats.focusTime,
                            averageFocus: todayStats.averageFocus
                        )
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .shadow(color: .purple.opacity(0.3), radius: 15, x: 0, y: 5)
                        .padding(.horizontal)
                        
                        // Start Session Button - Enhanced
                        Button {
                            showingSessionSetup = true
                        } label: {
                            HStack(spacing: 12) {
                                Image(systemName: "flame.fill")
                                    .font(.title2)
                                Text("Start Study Session")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                Image(systemName: "arrow.right.circle.fill")
                                    .font(.title2)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(
                                LinearGradient(
                                    colors: [.orange, .pink, .purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .shadow(color: .orange.opacity(0.5), radius: 15, x: 0, y: 8)
                        }
                        .padding(.horizontal)
                        .scaleEffect(floatingAnimation ? 1.02 : 1.0)
                        
                        // Navigation Links with modern cards
                        VStack(spacing: 16) {
                            NavigationLink(destination: HistoryView()) {
                                ModernMenuCard(
                                    icon: "chart.bar.fill",
                                    title: "Session History",
                                    subtitle: "View past sessions",
                                    gradient: [.blue, .cyan]
                                )
                            }
                            
                            NavigationLink(destination: SettingsView()) {
                                ModernMenuCard(
                                    icon: "gear",
                                    title: "Settings",
                                    subtitle: "Customize your experience",
                                    gradient: [.purple, .pink]
                                )
                            }
                        }
                        .padding(.horizontal)
                        
                        // Fun motivational section
                        VStack(spacing: 12) {
                            HStack {
                                Text("💪")
                                Text("Ready to crush it?")
                                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                                Text("💪")
                            }
                            
                            Text("Your study buddy is fired up and ready to roast!")
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(16)
                        .padding(.horizontal)
                        .padding(.bottom, 30)
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
                floatingAnimation = true
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

// MARK: - Floating Decorations
struct FloatingDecorView: View {
    @State private var animate1 = false
    @State private var animate2 = false
    @State private var animate3 = false
    
    var body: some View {
        ZStack {
            // Star 1
            Image("StarDecor")
                .resizable()
                .frame(width: 40, height: 40)
                .offset(x: 150, y: -300)
                .rotationEffect(.degrees(animate1 ? 360 : 0))
                .opacity(0.7)
                .animation(
                    Animation.linear(duration: 8).repeatForever(autoreverses: false),
                    value: animate1
                )
            
            // Sparkle
            Image("SparkleDecor")
                .resizable()
                .frame(width: 50, height: 50)
                .offset(x: -160, y: -250)
                .scaleEffect(animate2 ? 1.2 : 0.8)
                .opacity(0.6)
                .animation(
                    Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true),
                    value: animate2
                )
            
            // Flame decoration
            Image("FlameDecor")
                .resizable()
                .frame(width: 35, height: 35)
                .offset(x: -170, y: 100)
                .offset(y: animate3 ? -10 : 10)
                .opacity(0.7)
                .animation(
                    Animation.easeInOut(duration: 2).repeatForever(autoreverses: true),
                    value: animate3
                )
            
            // Star 2
            Image("StarDecor")
                .resizable()
                .frame(width: 30, height: 30)
                .offset(x: 170, y: 50)
                .rotationEffect(.degrees(animate1 ? -360 : 0))
                .opacity(0.6)
                .animation(
                    Animation.linear(duration: 10).repeatForever(autoreverses: false),
                    value: animate1
                )
        }
        .allowsHitTesting(false)
        .onAppear {
            animate1 = true
            animate2 = true
            animate3 = true
        }
    }
}

// MARK: - Modern Menu Card
struct ModernMenuCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let gradient: [Color]
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: gradient,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 56, height: 56)
                    .shadow(color: gradient[0].opacity(0.4), radius: 8, x: 0, y: 4)
                
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                Text(subtitle)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .shadow(color: gradient[0].opacity(0.2), radius: 10, x: 0, y: 5)
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
