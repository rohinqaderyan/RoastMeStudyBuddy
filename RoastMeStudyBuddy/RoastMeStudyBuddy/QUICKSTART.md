# Quick Start Guide 🚀

## Setting Up in Xcode

Since we've created all the Swift files but not an actual Xcode project file, follow these steps:

### Option 1: Create New Xcode Project (Recommended)

1. **Open Xcode**
2. **File → New → Project**
3. **Choose iOS App template**
4. **Configure**:
   - Product Name: `RoastMeStudyBuddy`
   - Team: (Your team)
   - Organization Identifier: `com.yourname.roastmestudybuddy`
   - Interface: **SwiftUI**
   - Language: **Swift**
   - Storage: **SwiftData** ✓
   - Include Tests: ✓

5. **Save to**: `/Users/QADERA01/RoastMeStudyBuddy`
   
6. **Delete auto-generated files**:
   - Delete `ContentView.swift`
   - Delete `Item.swift` (SwiftData template)

7. **Add your files**:
   - Drag all folders (App, Models, Services, Views, Utilities) into Xcode
   - ✓ Copy items if needed
   - ✓ Create groups
   - Add to target: RoastMeStudyBuddy

8. **Set Deployment Target**:
   - Project Settings → General → Minimum Deployments: **iOS 17.0**

9. **Run**:
   - Select iPhone 15 Pro simulator
   - Cmd+R to build and run

### Option 2: Quick Command Line Setup

```bash
# Navigate to project directory
cd /Users/QADERA01/RoastMeStudyBuddy

# Create Package.swift for SPM (alternative)
# Or use the Xcode GUI method above (recommended)
```

## First Run Experience

1. **Launch app** → See HomeView dashboard
2. **Tap "Start Study Session"**
3. **Enter**: "Study for exam"
4. **Choose**: 25 minutes
5. **Pick**: Savage Roaster 😈
6. **Tap "Start"**
7. **Watch**: Timer counts down, mock distractions trigger roasts!

## Troubleshooting

### Build Errors?

**"Cannot find type 'StudySession' in scope"**
- Ensure all files are added to the target
- Check target membership in File Inspector

**SwiftData errors**
- Make sure iOS Deployment Target is 17.0+
- Verify SwiftData is imported in models

**Preview crashes**
- Previews need modelContainer - check #Preview macros
- Some previews may not work until proper Xcode project

### Files Not Found?
All files should be in:
```
/Users/QADERA01/RoastMeStudyBuddy/
├── App/RoastMeStudyBuddyApp.swift
├── Models/*.swift
├── Services/*.swift
├── Views/*/*.swift
└── Utilities/*.swift
```

## Testing the App

### Test Scenarios:

**Scenario 1: Complete Session**
- Start 15-min session
- Let it run full duration
- Check completion screen shows stats

**Scenario 2: Early Exit**
- Start session
- Tap X button
- Confirm "End Session"
- Verify stats still saved

**Scenario 3: Personality Comparison**
- Run 3 sessions with different personalities
- Compare message tone in History

**Scenario 4: Streak Building**
- Complete 1 session
- Check Home screen streak badge
- (Streak logic counts daily, so test over multiple days)

## Expected Behavior

✅ **What Works**:
- Session timer counts down accurately
- Mock focus detection triggers every 15-30 seconds
- Roasts/praise appear in real-time
- Focus score updates (decreases on distraction)
- Session history persists across app launches
- Settings save preferences

⚠️ **Known Limitations (MVP)**:
- Focus detection is random (no real camera)
- Pause button doesn't work yet
- Widget/Live Activities not implemented
- No streak history (just current count)

## Next Steps After Setup

1. **Run a full session** to see complete flow
2. **Check History** to verify persistence works
3. **Tweak Settings** to test preference saving
4. **Modify roast messages** in `RoastGenerationService.swift` to add your own!
5. **Start Week 2 tasks** (add Live Activities, Widget)

## Need Help?

Check README.md for full documentation!

Happy coding! 🔥
