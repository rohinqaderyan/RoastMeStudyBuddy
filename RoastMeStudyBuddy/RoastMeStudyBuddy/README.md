# RoastMe Study Buddy 🔥

An AI-powered iOS study companion that roasts you into productivity! Built with SwiftUI and SwiftData.

## 🎯 Concept

RoastMe Study Buddy keeps students focused by:
- Monitoring focus during study sessions (MVP uses mock detection)
- Generating personality-driven roasts & praise based on behavior
- Tracking streaks and providing detailed analytics
- Making productivity fun through Gen Z humor

## 🏗️ Architecture

**Pattern**: MVVM + Clean Architecture
- **Models**: SwiftData entities (StudySession, UserPreferences) + lightweight structs
- **ViewModels**: Thin logic layer (SessionManager is the main coordinator)
- **Views**: SwiftUI components organized by feature
- **Services**: Protocol-based services for focus detection, roast generation, persistence

## 📁 Project Structure

```
RoastMeStudyBuddy/
├── App/                          # App entry point & configuration
│   ├── RoastMeStudyBuddyApp.swift
│   └── Config/
├── Models/                       # Data models
│   ├── StudySession.swift       # SwiftData model for sessions
│   ├── PersonalityMode.swift    # Roaster personalities
│   ├── RoastMessage.swift       # Message model
│   ├── FocusEvent.swift         # Focus state events
│   └── UserPreferences.swift    # SwiftData user settings
├── Services/                     # Business logic layer
│   ├── SessionManager.swift     # Main session coordinator
│   ├── FocusDetectionService.swift  # Mock focus monitoring
│   ├── RoastGenerationService.swift # Message generation
│   └── PersistenceService.swift     # SwiftData wrapper
├── Views/                        # SwiftUI views
│   ├── Home/                    # Dashboard
│   ├── SessionSetup/            # Pre-session config
│   ├── ActiveSession/           # Live session UI
│   ├── SessionComplete/         # Post-session summary
│   ├── History/                 # Past sessions
│   └── Settings/                # User preferences
└── Utilities/                   # Helpers & extensions
```

## ✨ Features (MVP)

### Implemented:
- [x] Study session timer with focus tracking
- [x] 3 personality modes (Savage Roaster, Supportive Coach, Drill Sergeant)
- [x] Mock focus detection (simulates random distractions)
- [x] 50+ unique roasts & praise messages per personality
- [x] Real-time focus score meter
- [x] Session history with detailed stats
- [x] Streak tracking
- [x] SwiftData persistence
- [x] Session completion summary with sharing
- [x] Haptic feedback on messages
- [x] Beautiful gradient UI

### Coming Soon:
- [ ] Real camera-based focus detection (Core ML)
- [ ] Live Activities (lock screen session tracker)
- [ ] Home screen widget
- [ ] LLM-powered roasts (premium feature)
- [ ] Multiplayer study rooms
- [ ] Apple Watch companion
- [ ] Shortcuts integration

## 🚀 How to Run

### Requirements:
- macOS 14.0+ (Sonoma)
- Xcode 15.0+
- iOS 17.0+ target device or simulator

### Setup:

1. **Create Xcode Project**:
   ```bash
   cd /Users/QADERA01/RoastMeStudyBuddy
   # Open Xcode and create a new iOS App project
   # Product Name: RoastMeStudyBuddy
   # Interface: SwiftUI
   # Language: Swift
   # Include SwiftData: Yes
   ```

2. **Add Files to Xcode**:
   - In Xcode, delete the auto-generated ContentView.swift
   - Drag all folders from this directory into your Xcode project
   - Ensure "Copy items if needed" is checked
   - Create groups (not folder references)

3. **Configure Info.plist** (for future camera usage):
   - Add `NSCameraUsageDescription`: "We use the camera to detect if you're focused or distracted during study sessions."

4. **Build & Run**:
   - Select a simulator or device (iOS 17.0+)
   - Press Cmd+R to build and run

## 🎮 How to Use

1. **Start a Session**:
   - Tap "Start Study Session"
   - Enter what you're working on
   - Choose duration (15/25/45/60 min)
   - Pick your roaster personality
   - Hit "Start"

2. **During the Session**:
   - Watch the timer count down
   - Mock detection will randomly simulate distractions
   - Get roasted or praised based on "focus state"
   - Monitor your real-time focus score

3. **Complete & Review**:
   - Session auto-completes at planned duration
   - View detailed stats (focus %, distractions, messages)
   - Share your results
   - Check history for all past sessions

## 🎨 Personality Modes

### 😈 Savage Roaster
Brutal honesty with Gen Z dark humor. Will destroy you for phone-checking.

**Example Roasts**:
- "Really? We're checking Instagram AGAIN? 🙄"
- "Your attention span has the energy of a sloth on vacation."
- "At this rate, you'll graduate when flying cars are normal."

### 💪 Supportive Coach
Encouraging accountability without judgment. Your focus cheerleader.

**Example Messages**:
- "Hey, I noticed you got distracted. No worries—let's refocus! 💙"
- "You're doing AMAZING! Keep that momentum going! 🌟"

### 🎖️ Drill Sergeant
Military-style discipline. Boot camp energy for maximum focus.

**Example Commands**:
- "DROP THE PHONE AND GET BACK TO WORK! NOW!"
- "OUTSTANDING! This is what I'm talking about!"

## 🧪 Testing

The app uses MockFocusDetectionService for MVP:
- Randomly simulates focus/distraction states every 15-30 seconds
- Triggers roast/praise generation
- No camera required yet

To test different scenarios:
- Long sessions (watch milestone messages at 25%, 50%, 75%)
- Different personalities (see message variation)
- Session completion (stats calculation)

## 🔐 Privacy

- All data stays on-device (SwiftData local storage)
- No analytics tracking (yet)
- No account required
- Camera permission only requested when needed (future)
- No images/videos ever uploaded

## 🎯 Next Development Steps

### Week 1: Polish MVP
1. Add sound effects for roasts/praise
2. Improve UI animations
3. Add onboarding flow
4. Create app icon

### Week 2: Live Features
1. Implement Live Activities (lock screen)
2. Build home screen widget
3. Add local notifications

### Week 3: Real Detection
1. Integrate AVFoundation camera capture
2. Train/integrate Core ML distraction detection model
3. Replace MockFocusDetectionService

### Week 4: Premium Features
1. LLM API integration for custom roasts
2. StoreKit 2 subscriptions
3. Unlimited sessions for premium

## 🐛 Known Issues

- SessionManager timer may not pause correctly (TODO: implement pause logic)
- Stats calculation needs edge case handling (0-second sessions)
- Need to handle background app state (pause session automatically)
- Widget not yet implemented

## 📝 Code Highlights

### Clean Separation of Concerns
```swift
// Services are protocol-based for easy testing
protocol FocusDetectionServiceProtocol {
    var focusStatePublisher: AnyPublisher<FocusState, Never> { get }
    func startMonitoring() async throws
    func stopMonitoring()
}

// Easy to swap mock for real implementation
let focusDetection = MockFocusDetectionService() // or RealFocusDetectionService()
```

### SwiftData Integration
```swift
@Model
final class StudySession {
    var id: UUID
    var startTime: Date
    var focusScore: Double
    // Automatic persistence, queries, relationships
}
```

### Reactive State Management
```swift
@MainActor
final class SessionManager: ObservableObject {
    @Published var currentSession: StudySession?
    @Published var isSessionActive = false
    // Views auto-update when state changes
}
```

## 🤝 Contributing

This is a solo MVP project, but suggestions welcome!

## 📄 License

MIT License - free to use and modify

---

**Built with ❤️ and 🔥 by a developer who believes productivity should be fun!**
