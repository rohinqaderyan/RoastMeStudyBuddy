//
//  RoastFeedView.swift
//  RoastMeStudyBuddy
//
//  Created on February 15, 2026.
//

import SwiftUI

struct RoastFeedView: View {
    let messages: [RoastMessage]
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(messages.suffix(5)) { message in
                        RoastMessageRow(message: message)
                            .id(message.id)
                    }
                }
                .padding()
            }
            .onChange(of: messages.count) { _, _ in
                if let lastMessage = messages.last {
                    withAnimation {
                        proxy.scrollTo(lastMessage.id, anchor: .bottom)
                    }
                }
            }
        }
    }
}

struct RoastMessageRow: View {
    let message: RoastMessage
    
    var backgroundColor: Color {
        switch message.type {
        case .roast: return .red.opacity(0.2)
        case .praise: return .green.opacity(0.2)
        case .milestone: return .blue.opacity(0.2)
        }
    }
    
    var icon: String {
        switch message.type {
        case .roast: return "flame.fill"
        case .praise: return "star.fill"
        case .milestone: return "trophy.fill"
        }
    }
    
    var iconColor: Color {
        switch message.type {
        case .roast: return .red
        case .praise: return .green
        case .milestone: return .blue
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(iconColor)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(message.content)
                    .font(.body)
                    .foregroundColor(.white)
                Text(message.timestamp.formatted(date: .omitted, time: .shortened))
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.5))
            }
            
            Spacer()
        }
        .padding()
        .background(backgroundColor)
        .cornerRadius(12)
        .transition(.slide)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        RoastFeedView(messages: [
            RoastMessage(content: "Really? We're checking Instagram AGAIN? 🙄", type: .roast, trigger: .distracted),
            RoastMessage(content: "Well, well, look who decided to focus! 👏", type: .praise, trigger: .refocused),
            RoastMessage(content: "25% complete! Keep going!", type: .milestone, trigger: .timeGoal)
        ])
    }
}
