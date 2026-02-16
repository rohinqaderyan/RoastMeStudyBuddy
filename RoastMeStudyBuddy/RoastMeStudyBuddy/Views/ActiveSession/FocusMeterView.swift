//
//  FocusMeterView.swift
//  RoastMeStudyBuddy
//
//  Created on February 15, 2026.
//

import SwiftUI

struct FocusMeterView: View {
    let focusScore: Double
    
    var meterColor: Color {
        switch focusScore {
        case 80...100: return .green
        case 50..<80: return .orange
        default: return .red
        }
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Focus Score")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.7))
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 24)
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(meterColor.gradient)
                    .frame(width: CGFloat(focusScore / 100) * 300, height: 24)
                    .animation(.easeInOut(duration: 0.5), value: focusScore)
            }
            .frame(width: 300)
            
            Text("\(Int(focusScore))%")
                .font(.title3.bold())
                .foregroundColor(meterColor)
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        FocusMeterView(focusScore: 85)
    }
}
