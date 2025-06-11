//
//  AuroraLook.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 6/10/25.
//

import SwiftUI

// MARK: - Aurora Look
@available(iOS 18.0, macOS 15.0, *)
public struct AuroraLook: Look, Sendable {
    public init() {}
    
    // MARK: - Aurora Brand Colors
    public var brandPrimary: Color      { Color(hex: "#00D9FF") }    // Cyan Aurora
    public var brandSecondary: Color    { Color(hex: "#00FF88") }    // Green Aurora
    public var brandTertiary: Color     { Color(hex: "#7B68EE") }    // Purple Aurora
    public var brandQuaternary: Color   { Color(hex: "#FF00FF") }    // Magenta Aurora
    public var brandQuinary: Color      { Color(hex: "#00CED1") }    // Dark Turquoise
    
    // MARK: - State Colors
    public var stateSuccess: Color      { Color(hex: "#00FF88") }    // Aurora Green
    public var stateWarning: Color      { Color(hex: "#FFD700") }    // Golden Aurora
    public var stateError: Color        { Color(hex: "#FF1493") }    // Deep Pink
    public var stateInfo: Color         { Color(hex: "#00BFFF") }    // Deep Sky Blue
    public var stateLink: Color         { Color(hex: "#00D9FF") }    // Cyan Link
    
    // MARK: - Background Colors
    public var backgroundPrimary: Color   { Color(hex: "#0A0E27") }  // Deep Night Sky
    public var backgroundSecondary: Color { Color(hex: "#111538") }  // Midnight Blue
    public var backgroundTertiary: Color  { Color(hex: "#1A1F4A") }  // Dark Indigo
    public var surfacePrimary: Color      { Color(hex: "#242B5C") }  // Space Blue
    public var surfaceSecondary: Color    { Color(hex: "#2E3770") }  // Lighter Space Blue
    public var surfaceTertiary: Color     { Color(hex: "#384384") }  // Light Indigo
    
    // MARK: - Surface Variations
    public var surface: Color               { Color(hex: "#242B5C") }
    public var surfacePressed: Color        { Color(hex: "#1A1F4A") }
    public var surfaceElevated: Color       { Color(hex: "#2E3770") }
    public var surfaceDeep: Color           { Color(hex: "#111538") }
    public var surfaceRaised: Color         { Color(hex: "#384384") }
    
    // MARK: - Text Colors
    public var textPrimary: Color         { Color(hex: "#E0F7FA") }         // Ice White
    public var textSecondary: Color       { Color(hex: "#B2EBF2") }         // Light Cyan
    public var textTertiary: Color        { Color(hex: "#80DEEA") }         // Cyan Gray
    public var textDisabled: Color        { Color(hex: "#4A5568") }         // Dim Gray
    public var textAccent: Color          { brandPrimary }
    public var textHighlight: Color       { brandSecondary }
    
    // MARK: - Effect Colors
    public var glassOverlay: Color        { Color(hex: "#00D9FF").opacity(0.15) }
    public var glassBorder: Color         { Color(hex: "#00FF88").opacity(0.4) }
    public var glowPrimary: Color         { brandPrimary.opacity(0.9) }
    public var glowSecondary: Color       { brandSecondary.opacity(0.7) }
    public var glowAccent: Color          { brandTertiary.opacity(0.8) }
    public var neutralDivider: Color      { Color(hex: "#384384").opacity(0.6) }
    
    // MARK: - Shadow Colors
    public var shadowDark: Color          { Color(hex: "#000000").opacity(0.8) }
    public var shadowLight: Color         { Color(hex: "#00D9FF").opacity(0.2) }
    public var shadowMedium: Color        { Color(hex: "#0A0E27").opacity(0.6) }
    public var shadowDeep: Color          { Color(hex: "#000000").opacity(0.9) }
    
    // MARK: - Interactive State Colors
    public var interactiveIdle: Color     { brandPrimary.opacity(0.7) }
    public var interactiveHover: Color    { brandPrimary }
    public var interactivePressed: Color  { brandPrimary.opacity(0.5) }
    public var interactiveDisabled: Color { Color(hex: "#4A5568").opacity(0.5) }
    public var interactiveActive: Color   { brandSecondary }
    public var interactiveFocus: Color    { brandQuaternary }
    
    // MARK: - Accent Colors
    public var accent: Color             { brandPrimary }
    public var accentSecondary: Color    { brandSecondary }
    public var accentTertiary: Color     { brandTertiary }
    
    // MARK: - Control-specific Colors
    public var knobPrimary: Color        { Color(hex: "#00CED1") }     // Dark Turquoise
    public var knobSecondary: Color      { Color(hex: "#48D1CC") }     // Medium Turquoise
    public var sliderTrack: Color        { surfaceSecondary }
    public var sliderThumb: Color        { brandPrimary }
    public var buttonPrimary: Color      { brandSecondary }
    public var buttonSecondary: Color    { brandTertiary }
    public var padActive: Color          { brandPrimary }
    public var padInactive: Color        { surfacePrimary }
    
    // MARK: - Special Elements
    public var neutralHighlight: Color   { Color(hex: "#00D9FF").opacity(0.9) }  // Cyan highlight
    public var subtleAccent: Color       { Color(hex: "#2E3770") }               // Space blue subtle
    public var stateSpecial: Color       { Color(hex: "#7B68EE") }               // Purple special state
    public var paleGreenAccent: Color    { Color(hex: "#00FF88").opacity(0.4) }  // Soft aurora green
    public var panelBackground: Color    { Color(hex: "#0A0E27") }               // Deep night panel
    public var controlBackground: Color  { Color(hex: "#111538") }               // Midnight control background
}
