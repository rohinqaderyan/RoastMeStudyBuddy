//
//  Color+Theme.swift
//  RoastMeStudyBuddy
//
//  Created on February 15, 2026.
//

import SwiftUI

extension Color {
    // MARK: - Modern Dark Theme Colors
    
    // Primary gradient colors - sleek and minimal
    static let appPrimary = Color(hex: "6366F1") // Indigo
    static let appSecondary = Color(hex: "8B5CF6") // Violet
    static let appAccent = Color(hex: "EC4899") // Pink accent
    
    // Background layers for depth
    static let darkBackground = Color(hex: "0F0F1E") // Deep navy-black
    static let cardBackground = Color(hex: "1A1A2E") // Card background
    static let cardElevated = Color(hex: "25253A") // Elevated elements
    
    // Text colors
    static let textPrimary = Color(hex: "FFFFFF")
    static let textSecondary = Color(hex: "A0A0B8")
    static let textTertiary = Color(hex: "6B6B82")
    
    // Focus state colors
    static let focusExcellent = Color(hex: "10B981") // Emerald green
    static let focusGood = Color(hex: "3B82F6") // Blue
    static let focusWarning = Color(hex: "F59E0B") // Amber
    static let focusPoor = Color(hex: "EF4444") // Red
    
    // Subtle accent colors
    static let accentGlow = Color(hex: "6366F1").opacity(0.2)
    static let successGlow = Color(hex: "10B981").opacity(0.2)
    static let warningGlow = Color(hex: "F59E0B").opacity(0.2)
    
    // Legacy compatibility (mapped to new colors)
    static let focusGreen = focusExcellent
    static let focusOrange = focusWarning
    static let focusRed = focusPoor
    
    static let roastRed = focusPoor.opacity(0.15)
    static let praiseGreen = focusExcellent.opacity(0.15)
    static let milestoneBlue = appPrimary.opacity(0.15)
}

// MARK: - Hex Color Support
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
