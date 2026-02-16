//
//  SettingsView.swift
//  RoastMeStudyBuddy
//
//  Created on February 15, 2026.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Query var preferences: [UserPreferences]
    @Environment(\.modelContext) private var modelContext
    
    var currentPrefs: UserPreferences? {
        preferences.first
    }
    
    var body: some View {
        Form {
            Section("Defaults") {
                if let prefs = currentPrefs {
                    Picker("Personality Mode", selection: Binding(
                        get: { prefs.defaultPersonalityMode },
                        set: { prefs.defaultPersonalityMode = $0 }
                    )) {
                        ForEach(PersonalityMode.allCases, id: \.self) { mode in
                            Text("\(mode.icon) \(mode.rawValue)").tag(mode)
                        }
                    }
                    
                    Stepper(
                        "Default Duration: \(Int(prefs.defaultSessionDuration / 60)) min",
                        value: Binding(
                            get: { prefs.defaultSessionDuration },
                            set: { prefs.defaultSessionDuration = $0 }
                        ),
                        in: 900...3600,
                        step: 300
                    )
                }
            }
            
            Section("Experience") {
                if let prefs = currentPrefs {
                    Toggle("Sound Effects", isOn: Binding(
                        get: { prefs.soundEffectsEnabled },
                        set: { prefs.soundEffectsEnabled = $0 }
                    ))
                    
                    Toggle("Haptic Feedback", isOn: Binding(
                        get: { prefs.hapticsEnabled },
                        set: { prefs.hapticsEnabled = $0 }
                    ))
                    
                    Toggle("Notifications", isOn: Binding(
                        get: { prefs.notificationsEnabled },
                        set: { prefs.notificationsEnabled = $0 }
                    ))
                }
            }
            
            Section("Goals") {
                if let prefs = currentPrefs {
                    Stepper(
                        "Streak Goal: \(prefs.streakGoal) days",
                        value: Binding(
                            get: { prefs.streakGoal },
                            set: { prefs.streakGoal = $0 }
                        ),
                        in: 1...30
                    )
                }
            }
            
            Section("About") {
                HStack {
                    Text("Version")
                    Spacer()
                    Text("1.0.0")
                        .foregroundStyle(.secondary)
                }
                
                Link("Privacy Policy", destination: URL(string: "https://example.com/privacy")!)
                Link("Terms of Service", destination: URL(string: "https://example.com/terms")!)
            }
            
            Section {
                Button("Clear All Data", role: .destructive) {
                    // TODO: Implement data deletion
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .modelContainer(for: [StudySession.self, UserPreferences.self])
    }
}
