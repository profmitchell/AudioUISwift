//
//  SageGreenLook.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 12/23/25.
//

import SwiftUI

// MARK: - Sage Green Look
@available(iOS 18.0, macOS 15.0, *)
public struct SageGreenLook: Look, Sendable {
    public init() {}
    
    // MARK: - Sage Green Brand Colors (Natural & Earthy)
    public var brandPrimary: Color      { Color(hex: "81C784") }    // Soft Sage
    public var brandSecondary: Color    { Color(hex: "A5D6A7") }    // Light Sage
    public var brandTertiary: Color     { Color(hex: "C8E6C9") }    // Pale Sage
    public var brandQuaternary: Color   { Color(hex: "E8F5E8") }    // Mint Whisper
    public var brandQuinary: Color      { Color(hex: "66BB6A") }    // Deep Sage
    
    // MARK: - State Colors
    public var stateSuccess: Color      { Color(hex: "4CAF50") }    // Natural Success
    public var stateWarning: Color      { Color(hex: "D4C5B9") }    // Warm Beige
    public var stateError: Color        { Color(hex: "A1887F") }    // Soft Brown
    public var stateInfo: Color         { Color(hex: "81C784") }    // Sage Info
    public var stateLink: Color         { Color(hex: "66BB6A") }    // Deep Sage Link
    
    // MARK: - Background Colors (Natural Depths)
    public var backgroundPrimary: Color   { Color(hex: "1C1C1C") }  // Rich Earth
    public var backgroundSecondary: Color { Color(hex: "2A2A2A") }  // Dark Soil
    public var backgroundTertiary: Color  { Color(hex: "373737") }  // Stone Gray
    public var surfacePrimary: Color      { Color(hex: "262626") }  // Primary Earth
    public var surfaceSecondary: Color    { Color(hex: "333333") }  // Secondary Earth
    public var surfaceTertiary: Color     { Color(hex: "404040") }  // Tertiary Earth
    
    // MARK: - Surface Variations
    public var surface: Color               { Color(hex: "262626") }
    public var surfacePressed: Color        { Color(hex: "1C1C1C") }
    public var surfaceElevated: Color       { Color(hex: "404040") }
    public var surfaceDeep: Color           { Color(hex: "141414") }
    public var surfaceRaised: Color         { Color(hex: "4D4D4D") }
    
    // MARK: - Text Colors
    public var textPrimary: Color         { Color(hex: "F0F4F0") }  // Natural White
    public var textSecondary: Color       { Color(hex: "D7E3D7") }  // Sage Gray
    public var textTertiary: Color        { Color(hex: "B8C8B8") }  // Muted Sage
    public var textDisabled: Color        { Color(hex: "78909C") }  // Stone Gray
    public var textAccent: Color          { brandPrimary }
    public var textHighlight: Color       { Color(hex: "A5D6A7") }
    
    // MARK: - Effect Colors (Natural Glow)
    public var glassOverlay: Color        { Color(hex: "81C784").opacity(0.1) }
    public var glassBorder: Color         { Color(hex: "A5D6A7").opacity(0.35) }
    public var glowPrimary: Color         { Color(hex: "81C784").opacity(0.6) }
    public var glowSecondary: Color       { Color(hex: "A5D6A7").opacity(0.4) }
    public var glowAccent: Color          { Color(hex: "C8E6C9").opacity(0.7) }
    public var neutralDivider: Color      { Color(hex: "5D6A5D") }
    
    // MARK: - Shadow Colors (Earth Shadows)
    public var shadowDark: Color          { Color.black.opacity(0.75) }
    public var shadowLight: Color         { Color(hex: "A5D6A7").opacity(0.12) }
    public var shadowMedium: Color        { Color(hex: "37474F").opacity(0.6) }
    public var shadowDeep: Color          { Color(hex: "0A0A0A") }
    
    // MARK: - Interactive State Colors
    public var interactiveIdle: Color     { Color(hex: "81C784").opacity(0.7) }
    public var interactiveHover: Color    { Color(hex: "66BB6A") }
    public var interactivePressed: Color  { Color(hex: "4CAF50") }
    public var interactiveDisabled: Color { Color(hex: "5D6A5D") }
    public var interactiveActive: Color   { brandPrimary }
    public var interactiveFocus: Color    { brandSecondary }
    
    // MARK: - Accent Colors
    public var accent: Color             { brandPrimary }
    public var accentSecondary: Color    { brandSecondary }
    public var accentTertiary: Color     { brandTertiary }
    
    // MARK: - Control-specific Colors
    public var knobPrimary: Color        { Color(hex: "78909C") }   // Natural Stone
    public var knobSecondary: Color      { Color(hex: "5D6A5D") }   // Dark Earth
    public var sliderTrack: Color        { surfaceSecondary }
    public var sliderThumb: Color        { brandPrimary }
    public var buttonPrimary: Color      { brandSecondary }
    public var buttonSecondary: Color    { brandTertiary }
    public var padActive: Color          { Color(hex: "4CAF50") }   // Active Green
    public var padInactive: Color        { surfacePrimary }
    
    // MARK: - Special Elements
    public var neutralHighlight: Color   { Color(hex: "E8F5E8").opacity(0.8) }   // Mint highlight
    public var subtleAccent: Color       { Color(hex: "404040") }                // Subtle earth
    public var stateSpecial: Color       { Color(hex: "8BC34A") }                // Fresh green special
    public var paleGreenAccent: Color    { Color(hex: "DCEDC8").opacity(0.5) }  // Pale natural accent
    public var panelBackground: Color    { Color(hex: "141414") }                // Deep earth panel
    public var controlBackground: Color  { Color(hex: "1C1C1C") }                // Control earth
} 