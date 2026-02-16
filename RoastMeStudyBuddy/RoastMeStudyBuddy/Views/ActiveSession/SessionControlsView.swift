//
//  SessionControlsView.swift
//  RoastMeStudyBuddy
//
//  Created on February 15, 2026.
//

import SwiftUI

struct SessionControlsView: View {
    let onPause: () -> Void
    let onEnd: () -> Void
    
    var body: some View {
        HStack(spacing: 24) {
            Button(action: onPause) {
                Image(systemName: "pause.fill")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(Color.blue)
                    .clipShape(Circle())
            }
            
            Button(action: onEnd) {
                Image(systemName: "stop.fill")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(Color.red)
                    .clipShape(Circle())
            }
        }
        .padding(.bottom, 40)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        SessionControlsView(onPause: {}, onEnd: {})
    }
}
