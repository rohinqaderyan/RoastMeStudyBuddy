//
//  SessionSetupView.swift
//  RoastMeStudyBuddy
//
//  Created on February 15, 2026.
//

import SwiftUI

struct SessionSetupView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @Environment(\.dismiss) var dismiss
    @Binding var showingActiveSession: Bool
    
    @State private var taskName = ""
    @State private var duration: TimeInterval = 1500 // 25 minutes
    @State private var selectedMode: PersonalityMode = .supportiveCoach
    @State private var isStarting = false
    
    let durationOptions: [(String, TimeInterval)] = [
        ("15 min", 900),
        ("25 min", 1500),
        ("45 min", 2700),
        ("60 min", 3600)
    ]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("What are you working on?") {
                    TextField("Task name (e.g., Study Math)", text: $taskName)
                        .textInputAutocapitalization(.sentences)
                }
                
                Section("How long?") {
                    Picker("Duration", selection: $duration) {
                        ForEach(durationOptions, id: \.1) { option in
                            Text(option.0).tag(option.1)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    ForEach(PersonalityMode.allCases, id: \.self) { mode in
                        Button {
                            withAnimation {
                                selectedMode = mode
                            }
                        } label: {
                            HStack {
                                Text(mode.icon)
                                    .font(.title2)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(mode.rawValue)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    Text(mode.description)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                if selectedMode == mode {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.blue)
                                        .font(.title3)
                                }
                            }
                        }
                    }
                } header: {
                    Text("Pick your roaster")
                } footer: {
                    Text("Choose the personality that will keep you accountable during this session.")
                }
            }
            .navigationTitle("Setup Session")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        startSession()
                    } label: {
                        if isStarting {
                            ProgressView()
                        } else {
                            Text("Start")
                                .bold()
                        }
                    }
                    .disabled(taskName.isEmpty || isStarting)
                }
            }
        }
    }
    
    private func startSession() {
        isStarting = true
        Task {
            do {
                try await sessionManager.startSession(
                    duration: duration,
                    taskName: taskName,
                    mode: selectedMode
                )
                await MainActor.run {
                    dismiss()
                    showingActiveSession = true
                }
            } catch {
                print("Failed to start session: \(error)")
                isStarting = false
            }
        }
    }
}

#Preview {
    SessionSetupView(showingActiveSession: .constant(false))
        .environmentObject(SessionManager(
            focusDetection: MockFocusDetectionService(),
            roastGenerator: RoastGenerationService(),
            persistence: PersistenceService()
        ))
}
