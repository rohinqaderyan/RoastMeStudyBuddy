# 📋 Build & Launch Checklist

Use this checklist when setting up the project in Xcode and preparing for launch.

## ✅ Phase 1: Xcode Setup (5 minutes)

- [ ] Open Xcode 15.0+
- [ ] Create new iOS App project
  - [ ] Product Name: `RoastMeStudyBuddy`
  - [ ] Interface: SwiftUI
  - [ ] Language: Swift
  - [ ] Storage: SwiftData ✓
  - [ ] Include Tests: ✓
- [ ] Save to: `/Users/QADERA01/RoastMeStudyBuddy`
- [ ] Delete auto-generated:
  - [ ] `ContentView.swift`
  - [ ] `Item.swift`
- [ ] Drag all project folders into Xcode:
  - [ ] App/
  - [ ] Models/
  - [ ] Services/
  - [ ] Views/
  - [ ] Utilities/
- [ ] Verify target membership (all files checked)
- [ ] Set iOS Deployment Target: **17.0**
- [ ] Build (Cmd+B) - should succeed!

## ✅ Phase 2: First Run Test (10 minutes)

- [ ] Select iPhone 15 Pro simulator
- [ ] Run app (Cmd+R)
- [ ] Verify HomeView displays
- [ ] Tap "Start Study Session"
- [ ] Enter task: "Test Session"
- [ ] Choose 15 min duration
- [ ] Select "Savage Roaster"
- [ ] Tap "Start"
- [ ] Verify ActiveSessionView shows:
  - [ ] Timer counting down
  - [ ] Focus meter at 100%
  - [ ] Wait 20-30 seconds for first roast
- [ ] Let session run 2-3 minutes
- [ ] Tap X to end early
- [ ] Confirm end session
- [ ] Verify SessionCompleteView shows stats
- [ ] Tap "Done"
- [ ] Check History shows session
- [ ] Open Settings and verify preferences load

✅ **If all checks pass, MVP is working!**

## ✅ Phase 3: Roast Quality Iteration (Ongoing)

- [ ] Test all 3 personalities (1 session each)
- [ ] Read every roast that appears
- [ ] Note which messages feel:
  - [ ] Repetitive (replace with variations)
  - [ ] Off-brand (revise tone)
  - [ ] Too harsh / too soft (adjust)
- [ ] Add 10-20 new roasts per personality
- [ ] Location: `Services/RoastGenerationService.swift`

### Writing Great Roasts:

**Good Roast Checklist**:
- [ ] Matches personality (Savage/Supportive/Drill Sergeant)
- [ ] Gen Z authentic (uses current slang/emojis)
- [ ] Specific (not generic "stay focused")
- [ ] Funny or motivating
- [ ] Shareable (would screenshot this?)

**Examples**:
```swift
// ✅ GOOD - Specific, funny, Gen Z
"Instagram will still be there later. Your deadline won't."

// ❌ BAD - Generic, boring
"Please stay focused on your work."
```

## ✅ Phase 4: UI Polish (Week 2)

- [ ] Add app icon (1024x1024)
  - [ ] Create in Figma/Sketch
  - [ ] Use 🔥 flame + 📚 book motif
  - [ ] Export all sizes
- [ ] Add launch screen
- [ ] Test on real device (not just simulator)
- [ ] Fix any layout issues on smaller screens (iPhone SE)
- [ ] Add loading states if needed
- [ ] Polish animations:
  - [ ] Roast message appearance
  - [ ] Focus meter transitions
  - [ ] Screen transitions

## ✅ Phase 5: Camera Detection (Week 3-4)

- [ ] Add camera permission to Info.plist
  - [ ] Key: `NSCameraUsageDescription`
  - [ ] Value: "We use the camera to detect focus during study sessions."
- [ ] Create `RealFocusDetectionService.swift`
- [ ] Implement AVFoundation capture
- [ ] Add Vision framework face detection
- [ ] Test battery drain (should be < 10%/hour)
- [ ] Add settings toggle: Mock vs Real detection
- [ ] Replace mock service in production

## ✅ Phase 6: Live Features (Week 3)

### Live Activities:
- [ ] Create ActivityKit extension target
- [ ] Define `SessionActivityAttributes.swift`
- [ ] Update Live Activity on focus changes
- [ ] Test on physical device (required for Live Activities)

### Widget:
- [ ] Create Widget extension target
- [ ] Build `StreakWidget.swift`
- [ ] Support small, medium, large sizes
- [ ] Update widget after each session
- [ ] Add deep link to start session

### Notifications:
- [ ] Request notification permission
- [ ] Schedule motivational notifications
- [ ] Reminder: "Start your study session!"
- [ ] Streak danger: "Your streak is about to break!"

## ✅ Phase 7: Testing (Week 5)

- [ ] Write unit tests for:
  - [ ] `SessionManager` session lifecycle
  - [ ] `RoastGenerationService` message selection
  - [ ] `PersistenceService` CRUD operations
  - [ ] Statistics calculations
- [ ] UI tests for critical flows:
  - [ ] Complete full session
  - [ ] Early session exit
  - [ ] History navigation
- [ ] Test edge cases:
  - [ ] 0-second session (how to handle?)
  - [ ] App backgrounding during session
  - [ ] Device rotation
  - [ ] Low battery mode
- [ ] Performance profiling:
  - [ ] Check memory leaks (Instruments)
  - [ ] Battery usage
  - [ ] App launch time

## ✅ Phase 8: Premium Features (Week 5-6)

- [ ] Integrate StoreKit 2
- [ ] Create subscription products in App Store Connect:
  - [ ] Monthly: $4.99
  - [ ] Yearly: $39.99 (save 33%)
- [ ] Build paywall UI
- [ ] Implement feature gates:
  - [ ] Free: 3 sessions/day
  - [ ] Premium: Unlimited
  - [ ] LLM roasts (premium only)
- [ ] Add "Restore Purchases" button
- [ ] Test sandbox purchases

### LLM Integration (Premium):
- [ ] Sign up for OpenAI/Anthropic API
- [ ] Store API key securely (Keychain)
- [ ] Implement LLM roast generation
- [ ] Add fallback to offline messages
- [ ] Rate limiting (max 1 API call per 30 seconds)

## ✅ Phase 9: Beta Testing (Week 6)

- [ ] Create TestFlight build
- [ ] Upload to App Store Connect
- [ ] Submit for TestFlight review
- [ ] Recruit 10-20 Gen Z testers:
  - [ ] College students
  - [ ] High schoolers
  - [ ] Young professionals
- [ ] Create feedback form (Google Forms/Typeform)
- [ ] Track metrics:
  - [ ] Completion rate
  - [ ] Average session length
  - [ ] Roast ratings
  - [ ] Feature requests
- [ ] Iterate based on feedback

## ✅ Phase 10: App Store Submission (Week 7)

### Marketing Assets:
- [ ] App Store icon (1024x1024)
- [ ] Screenshots (5-10):
  - [ ] iPhone 15 Pro Max (6.7")
  - [ ] iPhone 15 Pro (6.1")
  - [ ] Show key features:
    - [ ] Home screen with streak
    - [ ] Session setup
    - [ ] Active session with roasts
    - [ ] Session complete stats
    - [ ] History view
- [ ] App Preview video (15-30 seconds):
  - [ ] Show complete flow
  - [ ] Highlight roast personality
  - [ ] End with CTA
- [ ] App Store description:
  - [ ] Hook (first 2 lines critical!)
  - [ ] Features list
  - [ ] How it works
  - [ ] Testimonials (after beta)

### App Store Connect:
- [ ] Fill out app information
- [ ] Pricing: Free (with IAP)
- [ ] Categories: Education, Productivity
- [ ] Keywords: study, focus, productivity, ai, roast
- [ ] Age rating: 12+ (mild humor)
- [ ] Privacy policy URL
- [ ] Support URL

### Review Preparation:
- [ ] Test app on clean device (no debug data)
- [ ] Create demo video showing features
- [ ] Write review notes:
  - [ ] Focus detection is mock (explain upgrade path)
  - [ ] Premium features explanation
- [ ] Submit for review
- [ ] Monitor status (typically 24-48 hours)

## ✅ Phase 11: Launch Day (Week 8)

- [ ] App approved! 🎉
- [ ] Set release date or release immediately
- [ ] Social media launch posts:
  - [ ] Twitter/X thread
  - [ ] Instagram Reel showing app
  - [ ] TikTok demo video
  - [ ] LinkedIn post (for professionals)
- [ ] Submit to directories:
  - [ ] Product Hunt
  - [ ] Reddit r/SideProject
  - [ ] Hacker News Show HN
- [ ] Reach out to:
  - [ ] Study/productivity influencers
  - [ ] Education YouTubers
  - [ ] University student groups
- [ ] Monitor:
  - [ ] App Store reviews (respond quickly!)
  - [ ] Crash reports (fix ASAP)
  - [ ] Analytics (downloads, retention)

## 🎯 Success Metrics

Track these weekly:

**Week 1-2 Goals**:
- [ ] 100 downloads
- [ ] 50% D1 retention
- [ ] 5 App Store reviews

**Month 1 Goals**:
- [ ] 1,000 downloads
- [ ] 30% D7 retention
- [ ] 4.0+ star rating
- [ ] 10 premium subscribers

**Month 3 Goals**:
- [ ] 10,000 downloads
- [ ] 20% D30 retention
- [ ] 100+ reviews
- [ ] 100 premium subscribers ($500 MRR)

## 📈 Growth Tactics

### Organic:
- [ ] ASO (App Store Optimization)
  - [ ] Keyword research
  - [ ] A/B test screenshots
  - [ ] Update description monthly
- [ ] Content marketing:
  - [ ] "How I stay focused" blog posts
  - [ ] Study tips with app mentions
  - [ ] TikTok study-with-me videos
- [ ] Word of mouth:
  - [ ] Referral program
  - [ ] Share screenshots incentive
  - [ ] University ambassador program

### Paid (if budget allows):
- [ ] Apple Search Ads (start with $10/day)
- [ ] Instagram ads targeting students
- [ ] TikTok ads (study content)

## 🔧 Maintenance Checklist (Ongoing)

### Weekly:
- [ ] Monitor crash reports
- [ ] Respond to reviews
- [ ] Check analytics

### Monthly:
- [ ] Add 10 new roasts
- [ ] Review user feedback
- [ ] Plan next feature
- [ ] Update screenshots if UI changes

### Quarterly:
- [ ] Major feature release
- [ ] User survey
- [ ] Competitor analysis
- [ ] P&L review

---

**Ready to build? Start with Phase 1! 🚀**

Each phase is designed to take 1-2 weeks for a solo developer.
Focus on quality over speed - the roasts MUST be great!
