//
//  SoftPinkLook.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 12/23/25.
//

import SwiftUI

// MARK: - Soft Pink Look
@available(iOS 18.0, macOS 15.0, *)
public struct SoftPinkLook: Look, Sendable {
    public init() {}
    
    // MARK: - Soft Pink Brand Colors (Rose & Blush)
    public var brandPrimary: Color      { Color(hex: "F06292") }    // Soft Rose
    public var brandSecondary: Color    { Color(hex: "F48FB1") }    // Light Pink
    public var brandTertiary: Color     { Color(hex: "F8BBD9") }    // Blush Pink
    public var brandQuaternary: Color   { Color(hex: "FCE4EC") }    // Pale Rose
    public var brandQuinary: Color      { Color(hex: "E91E63") }    // Deep Rose
    
    // MARK: - State Colors
    public var stateSuccess: Color      { Color(hex: "81C784") }    // Soft Green Success
    public var stateWarning: Color      { Color(hex: "FFB74D") }    // Warm Amber
    public var stateError: Color        { Color(hex: "E57373") }    // Soft Red
    public var stateInfo: Color         { Color(hex: "F48FB1") }    // Pink Info
    public var stateLink: Color         { Color(hex: "F06292") }    // Rose Link
    
    // MARK: - Background Colors (Soft Depths)
    public var backgroundPrimary: Color   { Color(hex: "1A1A1A") }  // Deep Charcoal
    public var backgroundSecondary: Color { Color(hex: "2D2D2D") }  // Soft Shadow
    public var backgroundTertiary: Color  { Color(hex: "3A3A3A") }  // Gentle Gray
    public var surfacePrimary: Color      { Color(hex: "2A2A2A") }  // Primary Surface
    public var surfaceSecondary: Color    { Color(hex: "363636") }  // Secondary Surface
    public var surfaceTertiary: Color     { Color(hex: "424242") }  // Tertiary Surface
    
    // MARK: - Surface Variations
    public var surface: Color               { Color(hex: "2A2A2A") }
    public var surfacePressed: Color        { Color(hex: "1A1A1A") }
    public var surfaceElevated: Color       { Color(hex: "424242") }
    public var surfaceDeep: Color           { Color(hex: "121212") }
    public var surfaceRaised: Color         { Color(hex: "4E4E4E") }
    
    // MARK: - Text Colors
    public var textPrimary: Color         { Color(hex: "F5F5F5") }  // Soft White
    public var textSecondary: Color       { Color(hex: "E0E0E0") }  // Light Gray
    public var textTertiary: Color        { Color(hex: "BDBDBD") }  // Medium Gray
    public var textDisabled: Color        { Color(hex: "757575") }  // Disabled Gray
    public var textAccent: Color          { brandPrimary }
    public var textHighlight: Color       { Color(hex: "F48FB1") }
    
    // MARK: - Effect Colors (Soft Glow)
    public var glassOverlay: Color        { Color(hex: "F06292").opacity(0.08) }
    public var glassBorder: Color         { Color(hex: "F48FB1").opacity(0.3) }
    public var glowPrimary: Color         { Color(hex: "F06292").opacity(0.6) }
    public var glowSecondary: Color       { Color(hex: "F48FB1").opacity(0.4) }
    public var glowAccent: Color          { Color(hex: "F8BBD9").opacity(0.7) }
    public var neutralDivider: Color      { Color(hex: "616161") }
    
    // MARK: - Shadow Colors (Soft Shadows)
    public var shadowDark: Color          { Color.black.opacity(0.7) }
    public var shadowLight: Color         { Color(hex: "F48FB1").opacity(0.1) }
    public var shadowMedium: Color        { Color(hex: "424242").opacity(0.6) }
    public var shadowDeep: Color          { Color(hex: "000000") }
    
    // MARK: - Interactive State Colors
    public var interactiveIdle: Color     { Color(hex: "F06292").opacity(0.7) }
    public var interactiveHover: Color    { Color(hex: "E91E63") }
    public var interactivePressed: Color  { Color(hex: "C2185B") }
    public var interactiveDisabled: Color { Color(hex: "616161") }
    public var interactiveActive: Color   { brandPrimary }
    public var interactiveFocus: Color    { brandSecondary }
    
    // MARK: - Accent Colors
    public var accent: Color             { brandPrimary }
    public var accentSecondary: Color    { brandSecondary }
    public var accentTertiary: Color     { brandTertiary }
    
    // MARK: - Control-specific Colors
    public var knobPrimary: Color        { Color(hex: "757575") }   // Soft Stone
    public var knobSecondary: Color      { Color(hex: "616161") }   // Dark Stone
    public var sliderTrack: Color        { surfaceSecondary }
    public var sliderThumb: Color        { brandPrimary }
    public var buttonPrimary: Color      { brandSecondary }
    public var buttonSecondary: Color    { brandTertiary }
    public var padActive: Color          { Color(hex: "E91E63") }   // Active Pink
    public var padInactive: Color        { surfacePrimary }
    
    // MARK: - Special Elements
    public var neutralHighlight: Color   { Color(hex: "FCE4EC").opacity(0.8) }   // Pale rose highlight
    public var subtleAccent: Color       { Color(hex: "424242") }                // Subtle accent
    public var stateSpecial: Color       { Color(hex: "FF4081") }                // Bright pink special
    public var paleGreenAccent: Color    { Color(hex: "C8E6C9").opacity(0.4) }  // Pale green accent
    public var panelBackground: Color    { Color(hex: "121212") }                // Deep panel
    public var controlBackground: Color  { Color(hex: "1A1A1A") }                // Control background
} 