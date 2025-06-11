//
//  RoyalPurpleLook.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 12/23/25.
//

import SwiftUI

// MARK: - Royal Purple Look
@available(iOS 18.0, macOS 15.0, *)
public struct RoyalPurpleLook: Look, Sendable {
    public init() {}
    
    // MARK: - Royal Purple Brand Colors (Violet & Amethyst)
    public var brandPrimary: Color      { Color(hex: "7C3AED") }    // Violet 600
    public var brandSecondary: Color    { Color(hex: "A855F7") }    // Purple 500
    public var brandTertiary: Color     { Color(hex: "C4B5FD") }    // Violet 300
    public var brandQuaternary: Color   { Color(hex: "EDE9FE") }    // Violet 100
    public var brandQuinary: Color      { Color(hex: "6D28D9") }    // Violet 700
    
    // MARK: - State Colors
    public var stateSuccess: Color      { Color(hex: "10B981") }    // Emerald Success
    public var stateWarning: Color      { Color(hex: "F59E0B") }    // Amber Warning
    public var stateError: Color        { Color(hex: "EF4444") }    // Red Error
    public var stateInfo: Color         { Color(hex: "A855F7") }    // Purple Info
    public var stateLink: Color         { Color(hex: "7C3AED") }    // Violet Link
    
    // MARK: - Background Colors (Royal Depths)
    public var backgroundPrimary: Color   { Color(hex: "1E1B2E") }  // Deep Purple
    public var backgroundSecondary: Color { Color(hex: "2D2A3E") }  // Dark Purple
    public var backgroundTertiary: Color  { Color(hex: "3C394E") }  // Medium Purple
    public var surfacePrimary: Color      { Color(hex: "2D2A3E") }  // Dark Purple
    public var surfaceSecondary: Color    { Color(hex: "3C394E") }  // Medium Purple
    public var surfaceTertiary: Color     { Color(hex: "4B485E") }  // Light Purple
    
    // MARK: - Surface Variations
    public var surface: Color               { Color(hex: "2D2A3E") }
    public var surfacePressed: Color        { Color(hex: "1E1B2E") }
    public var surfaceElevated: Color       { Color(hex: "3C394E") }
    public var surfaceDeep: Color           { Color(hex: "141025") }
    public var surfaceRaised: Color         { Color(hex: "5A576E") }
    
    // MARK: - Text Colors
    public var textPrimary: Color         { Color(hex: "FAF9FF") }  // Very light purple
    public var textSecondary: Color       { Color(hex: "E4E2F0") }  // Light purple gray
    public var textTertiary: Color        { Color(hex: "C9C5DD") }  // Medium purple gray
    public var textDisabled: Color        { Color(hex: "78748A") }  // Dark purple gray
    public var textAccent: Color          { brandPrimary }
    public var textHighlight: Color       { Color(hex: "C4B5FD") }
    
    // MARK: - Effect Colors (Royal Glow)
    public var glassOverlay: Color        { Color(hex: "7C3AED").opacity(0.15) }
    public var glassBorder: Color         { Color(hex: "A855F7").opacity(0.5) }
    public var glowPrimary: Color         { Color(hex: "7C3AED").opacity(0.9) }
    public var glowSecondary: Color       { Color(hex: "A855F7").opacity(0.7) }
    public var glowAccent: Color          { Color(hex: "C4B5FD").opacity(0.8) }
    public var neutralDivider: Color      { Color(hex: "5A576E") }
    
    // MARK: - Shadow Colors (Purple Shadows)
    public var shadowDark: Color          { Color.black.opacity(0.85) }
    public var shadowLight: Color         { Color(hex: "A855F7").opacity(0.2) }
    public var shadowMedium: Color        { Color(hex: "3C394E").opacity(0.8) }
    public var shadowDeep: Color          { Color(hex: "000000") }
    
    // MARK: - Interactive State Colors
    public var interactiveIdle: Color     { Color(hex: "7C3AED").opacity(0.8) }
    public var interactiveHover: Color    { Color(hex: "6D28D9") }
    public var interactivePressed: Color  { Color(hex: "5B21B6") }
    public var interactiveDisabled: Color { Color(hex: "78748A") }
    public var interactiveActive: Color   { brandPrimary }
    public var interactiveFocus: Color    { brandSecondary }
    
    // MARK: - Accent Colors
    public var accent: Color             { brandPrimary }
    public var accentSecondary: Color    { brandSecondary }
    public var accentTertiary: Color     { brandTertiary }
    
    // MARK: - Control-specific Colors
    public var knobPrimary: Color        { Color(hex: "78748A") }   // Purple gray knob
    public var knobSecondary: Color      { Color(hex: "5A576E") }   // Dark purple knob
    public var sliderTrack: Color        { surfaceSecondary }
    public var sliderThumb: Color        { brandPrimary }
    public var buttonPrimary: Color      { brandSecondary }
    public var buttonSecondary: Color    { brandTertiary }
    public var padActive: Color          { Color(hex: "5B21B6") }   // Active Purple
    public var padInactive: Color        { surfacePrimary }
    
    // MARK: - Special Elements
    public var neutralHighlight: Color   { Color(hex: "EDE9FE").opacity(0.9) }   // Light violet highlight
    public var subtleAccent: Color       { Color(hex: "3C394E") }                // Subtle purple
    public var stateSpecial: Color       { Color(hex: "8B5CF6") }                // Violet 500 special
    public var paleGreenAccent: Color    { Color(hex: "F3F4F6").opacity(0.3) }  // Pale accent
    public var panelBackground: Color    { Color(hex: "141025") }                // Deep panel
    public var controlBackground: Color  { Color(hex: "1E1B2E") }                // Control background
} 