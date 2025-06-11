//
//  GoldenHourLook.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 12/23/25.
//

import SwiftUI

// MARK: - Golden Hour Look
@available(iOS 18.0, macOS 15.0, *)
public struct GoldenHourLook: Look, Sendable {
    public init() {}
    
    // MARK: - Golden Hour Brand Colors (Amber & Gold)
    public var brandPrimary: Color      { Color(hex: "F59E0B") }    // Amber 500
    public var brandSecondary: Color    { Color(hex: "FCD34D") }    // Amber 300
    public var brandTertiary: Color     { Color(hex: "FEF3C7") }    // Amber 100
    public var brandQuaternary: Color   { Color(hex: "FFFBEB") }    // Amber 50
    public var brandQuinary: Color      { Color(hex: "D97706") }    // Amber 600
    
    // MARK: - State Colors
    public var stateSuccess: Color      { Color(hex: "059669") }    // Emerald Success
    public var stateWarning: Color      { Color(hex: "DC2626") }    // Red Warning
    public var stateError: Color        { Color(hex: "B91C1C") }    // Red 700 Error
    public var stateInfo: Color         { Color(hex: "F59E0B") }    // Amber Info
    public var stateLink: Color         { Color(hex: "D97706") }    // Amber 600 Link
    
    // MARK: - Background Colors (Warm Depths)
    public var backgroundPrimary: Color   { Color(hex: "1C1917") }  // Stone 900
    public var backgroundSecondary: Color { Color(hex: "292524") }  // Stone 800
    public var backgroundTertiary: Color  { Color(hex: "44403C") }  // Stone 700
    public var surfacePrimary: Color      { Color(hex: "292524") }  // Stone 800
    public var surfaceSecondary: Color    { Color(hex: "44403C") }  // Stone 700
    public var surfaceTertiary: Color     { Color(hex: "57534E") }  // Stone 600
    
    // MARK: - Surface Variations
    public var surface: Color               { Color(hex: "292524") }
    public var surfacePressed: Color        { Color(hex: "1C1917") }
    public var surfaceElevated: Color       { Color(hex: "44403C") }
    public var surfaceDeep: Color           { Color(hex: "0C0A09") }
    public var surfaceRaised: Color         { Color(hex: "68625D") }
    
    // MARK: - Text Colors
    public var textPrimary: Color         { Color(hex: "FAFAF9") }  // Stone 50
    public var textSecondary: Color       { Color(hex: "E7E5E4") }  // Stone 200
    public var textTertiary: Color        { Color(hex: "D6D3D1") }  // Stone 300
    public var textDisabled: Color        { Color(hex: "78716C") }  // Stone 500
    public var textAccent: Color          { brandPrimary }
    public var textHighlight: Color       { Color(hex: "FCD34D") }
    
    // MARK: - Effect Colors (Golden Glow)
    public var glassOverlay: Color        { Color(hex: "F59E0B").opacity(0.12) }
    public var glassBorder: Color         { Color(hex: "FCD34D").opacity(0.4) }
    public var glowPrimary: Color         { Color(hex: "F59E0B").opacity(0.9) }
    public var glowSecondary: Color       { Color(hex: "FCD34D").opacity(0.7) }
    public var glowAccent: Color          { Color(hex: "FEF3C7").opacity(0.8) }
    public var neutralDivider: Color      { Color(hex: "68625D") }
    
    // MARK: - Shadow Colors (Warm Shadows)
    public var shadowDark: Color          { Color.black.opacity(0.8) }
    public var shadowLight: Color         { Color(hex: "FCD34D").opacity(0.2) }
    public var shadowMedium: Color        { Color(hex: "44403C").opacity(0.7) }
    public var shadowDeep: Color          { Color(hex: "000000") }
    
    // MARK: - Interactive State Colors
    public var interactiveIdle: Color     { Color(hex: "F59E0B").opacity(0.8) }
    public var interactiveHover: Color    { Color(hex: "D97706") }
    public var interactivePressed: Color  { Color(hex: "B45309") }
    public var interactiveDisabled: Color { Color(hex: "78716C") }
    public var interactiveActive: Color   { brandPrimary }
    public var interactiveFocus: Color    { brandSecondary }
    
    // MARK: - Accent Colors
    public var accent: Color             { brandPrimary }
    public var accentSecondary: Color    { brandSecondary }
    public var accentTertiary: Color     { brandTertiary }
    
    // MARK: - Control-specific Colors
    public var knobPrimary: Color        { Color(hex: "78716C") }   // Stone knob
    public var knobSecondary: Color      { Color(hex: "68625D") }   // Dark stone
    public var sliderTrack: Color        { surfaceSecondary }
    public var sliderThumb: Color        { brandPrimary }
    public var buttonPrimary: Color      { brandSecondary }
    public var buttonSecondary: Color    { brandTertiary }
    public var padActive: Color          { Color(hex: "B45309") }   // Active Amber
    public var padInactive: Color        { surfacePrimary }
    
    // MARK: - Special Elements
    public var neutralHighlight: Color   { Color(hex: "FEF3C7").opacity(0.9) }   // Golden highlight
    public var subtleAccent: Color       { Color(hex: "44403C") }                // Subtle stone
    public var stateSpecial: Color       { Color(hex: "FBBF24") }                // Amber 400 special
    public var paleGreenAccent: Color    { Color(hex: "FEF7CD").opacity(0.4) }  // Pale amber accent
    public var panelBackground: Color    { Color(hex: "0C0A09") }                // Deep panel
    public var controlBackground: Color  { Color(hex: "1C1917") }                // Control background
} 