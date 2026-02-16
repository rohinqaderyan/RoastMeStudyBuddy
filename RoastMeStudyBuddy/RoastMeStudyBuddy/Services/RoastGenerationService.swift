//
//  RoastGenerationService.swift
//  RoastMeStudyBuddy
//
//  Created on February 15, 2026.
//

import Foundation

protocol RoastGenerationServiceProtocol {
    func generateMessage(
        for event: FocusEvent,
        mode: PersonalityMode,
        context: SessionContext
    ) async -> RoastMessage
}

struct SessionContext {
    let currentFocusStreak: TimeInterval
    let distractionCount: Int
    let timeRemaining: TimeInterval
    let taskName: String
}

final class RoastGenerationService: RoastGenerationServiceProtocol {
    
    // MARK: - Offline Message Library
    
    private let savageRoastMessages: [String] = [
        "Really? We're checking notifications AGAIN? 🙄",
        "Your attention span has the energy of a sloth on vacation.",
        "At this rate, you'll graduate when flying cars are normal.",
        "Focus level: goldfish. Try again. 🐠",
        "Instagram will still be there later. Your deadline won't.",
        "Are we studying or scrolling? Pick one.",
        "That phone is not going to help you pass this test.",
        "Your future self is judging you SO hard right now.",
        "Distraction #\(Int.random(in: 1...99)). You're crushing it... at procrastinating.",
        "The phone down. Now. I'm not asking twice. 😈",
        "Is this what peak performance looks like? I think not.",
        "Your GPA called. It's concerned.",
        "Breaking news: Phone still won't study for you.",
        "Oops, you did it again. Hit me baby one more... distraction.",
        "That's it. I'm telling your mom. 📱❌"
    ]
    
    private let savagePraiseMessages: [String] = [
        "Well, well, look who decided to focus! 👏",
        "Five whole minutes! We're on fire now!",
        "You're doing the thing! Keep doing the thing!",
        "Okay, I see you. Not bad, not bad at all. 💪",
        "This is the energy we need! Where was this 10 minutes ago?",
        "Finally! The real you has entered the chat.",
        "Now THIS is what I'm talking about! 🔥",
        "Plot twist: You're actually capable of focus!",
        "Your brain is back online. Welcome back.",
        "See? You CAN do it when you try!"
    ]
    
    private let supportiveRoastMessages: [String] = [
        "Hey, I noticed you got distracted. No worries—let's refocus! 💙",
        "Small detour, but we've got this. Back to work!",
        "It happens! Let's get back on track together.",
        "I believe in you, but your phone doesn't need attention right now. 😊",
        "Quick break? Cool. But now it's time to shine! ✨",
        "Your future self will thank you for refocusing right now.",
        "You're stronger than this distraction. Let's go!",
        "Deep breath. Reset. You've totally got this.",
        "One step at a time. Let's get back to it!",
        "Every time you refocus, you're building discipline. Keep going!"
    ]
    
    private let supportivePraiseMessages: [String] = [
        "You're doing AMAZING! Keep that momentum going! 🌟",
        "YES! This is exactly what success looks like!",
        "I'm so proud of your focus right now! 💪",
        "You're crushing it! Your hard work is paying off!",
        "Look at you go! This is the energy we love!",
        "Absolutely incredible focus! Keep it up!",
        "You're in the zone! Don't stop now!",
        "This is YOUR moment! Own it! 🔥",
        "I knew you could do it! You're unstoppable!",
        "Pure focus energy! You're on fire right now!"
    ]
    
    private let drillSergeantRoastMessages: [String] = [
        "DROP THE PHONE AND GET BACK TO WORK! NOW! 🎖️",
        "Is this how champions train? I THINK NOT!",
        "FOCUS! Your future self is counting on you!",
        "ATTENTION! This is NOT break time, soldier!",
        "UNACCEPTABLE! Get your head in the game!",
        "Do you want to succeed or do you want to fail? CHOOSE!",
        "DISTRACTIONS are the enemy! ELIMINATE THEM!",
        "I didn't train you to quit! REFOCUS IMMEDIATELY!",
        "DISCIPLINE! That's what separates winners from losers!",
        "Your mission: COMPLETE THIS SESSION. Nothing else matters!"
    ]
    
    private let drillSergeantPraiseMessages: [String] = [
        "OUTSTANDING! This is what I'm talking about! 🎖️",
        "EXCELLENT WORK, SOLDIER! Keep that focus!",
        "NOW you're showing me what you're made of!",
        "THAT'S THE SPIRIT! March forward to victory!",
        "DISCIPLINE IN ACTION! This is textbook excellence!",
        "IMPRESSIVE! You're operating at peak performance!",
        "SOLID FOCUS! This is the standard we hold!",
        "MOTIVATED! DEDICATED! FOCUSED! That's YOU!",
        "You're a MACHINE! Keep that discipline locked in!",
        "HOOAH! This is how we achieve greatness!"
    ]
    
    // MARK: - Message Generation
    
    func generateMessage(
        for event: FocusEvent,
        mode: PersonalityMode,
        context: SessionContext
    ) async -> RoastMessage {
        
        let messageType: RoastMessage.MessageType
        let trigger: RoastMessage.TriggerReason
        
        switch event.eventType {
        case .distractionDetected, .phoneUsage:
            messageType = .roast
            trigger = .distracted
        case .focusStart, .focusEnd:
            messageType = .praise
            trigger = .refocused
        case .screenLock:
            messageType = .praise
            trigger = .timeGoal
        }
        
        let content = selectMessage(mode: mode, type: messageType, context: context)
        
        return RoastMessage(
            timestamp: Date(),
            content: content,
            type: messageType,
            trigger: trigger
        )
    }
    
    private func selectMessage(
        mode: PersonalityMode,
        type: RoastMessage.MessageType,
        context: SessionContext
    ) -> String {
        let messages: [String]
        
        switch (mode, type) {
        case (.savageRoaster, .roast):
            messages = savageRoastMessages
        case (.savageRoaster, .praise):
            messages = savagePraiseMessages
        case (.supportiveCoach, .roast):
            messages = supportiveRoastMessages
        case (.supportiveCoach, .praise):
            messages = supportivePraiseMessages
        case (.drillSergeant, .roast):
            messages = drillSergeantRoastMessages
        case (.drillSergeant, .praise):
            messages = drillSergeantPraiseMessages
        default:
            messages = supportivePraiseMessages
        }
        
        return messages.randomElement() ?? "Keep going!"
    }
    
    // Future: LLM API integration for premium users
    private func generateWithLLM(context: SessionContext, mode: PersonalityMode) async throws -> String {
        // TODO: Implement OpenAI/Anthropic API call
        // For now, fallback to offline messages
        return ""
    }
}
