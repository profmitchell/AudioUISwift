//
//  CosmicLook.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 6/6/25.
//

import SwiftUI

// MARK: - Cosmic Deep Space Look
@available(iOS 18.0, macOS 15.0, *)
public struct CosmicLook: Look, Sendable {
    public init() {}
    
    // MARK: - Cosmic Deep Space Brand Colors
    public var brandPrimary: Color      { Color(hex: "#9C27B0") }    // Deep Purple
    public var brandSecondary: Color    { Color(hex: "#3F51B5") }    // Indigo
    public var brandTertiary: Color     { Color(hex: "#2196F3") }    // Blue
    public var brandQuaternary: Color   { Color(hex: "#00BCD4") }    // Cyan
    public var brandQuinary: Color      { Color(hex: "#E91E63") }    // Pink
    
    // MARK: - State Colors
    public var stateSuccess: Color      { Color(hex: "#4CAF50") }    // Green
    public var stateWarning: Color      { Color(hex: "#FF9800") }    // Orange
    public var stateError: Color        { Color(hex: "#F44336") }    // Red
    public var stateInfo: Color         { Color(hex: "#2196F3") }    // Blue
    public var stateLink: Color         { Color(hex: "#9C27B0") }    // Deep Purple
    
    // MARK: - Background Colors
    public var backgroundPrimary: Color   { Color(hex: "#0A0A0F") }  // Deep Space Black
    public var backgroundSecondary: Color { Color(hex: "#1A1A2E") }  // Dark Purple
    public var backgroundTertiary: Color  { Color(hex: "#16213E") }  // Dark Blue
    public var surfacePrimary: Color      { Color(hex: "#1A1A2E") }  // Dark Purple
    public var surfaceSecondary: Color    { Color(hex: "#16213E") }  // Dark Blue
    public var surfaceTertiary: Color     { Color(hex: "#0F3460") }  // Medium Blue
    
    // MARK: - Surface Variations
    public var surface: Color               { Color(hex: "#1A1A2E") }
    public var surfacePressed: Color        { Color(hex: "#0A0A0F") }
    public var surfaceElevated: Color       { Color(hex: "#16213E") }
    public var surfaceDeep: Color           { Color(hex: "#000000") }
    public var surfaceRaised: Color         { Color(hex: "#0F3460") }
    
    // MARK: - Text Colors
    public var textPrimary: Color         { Color(hex: "#FFFFFF") }  // Starlight White
    public var textSecondary: Color       { Color(hex: "#E1BEE7") }  // Light Purple
    public var textTertiary: Color        { Color(hex: "#B39DDB") }  // Medium Purple
    public var textDisabled: Color        { Color(hex: "#7986CB") }  // Light Blue
    public var textAccent: Color          { brandPrimary }
    public var textHighlight: Color       { brandSecondary }
    
    // MARK: - Effect Colors
    public var glassOverlay: Color        { brandPrimary.opacity(0.1) }
    public var glassBorder: Color         { brandPrimary.opacity(0.5) }
    public var glowPrimary: Color         { brandPrimary.opacity(0.8) }
    public var glowSecondary: Color       { brandSecondary.opacity(0.7) }
    public var glowAccent: Color          { brandTertiary.opacity(0.9) }
    public var neutralDivider: Color      { Color(hex: "#3F51B5").opacity(0.4) }
    
    // MARK: - Shadow Colors
    public var shadowDark: Color          { Color.black.opacity(0.9) }
    public var shadowLight: Color         { brandPrimary.opacity(0.3) }
    public var shadowMedium: Color        { Color(hex: "#0A0A0F").opacity(0.7) }
    public var shadowDeep: Color          { Color.black.opacity(0.95) }
    
    // MARK: - Interactive State Colors
    public var interactiveIdle: Color     { brandPrimary.opacity(0.8) }
    public var interactiveHover: Color    { brandPrimary }
    public var interactivePressed: Color  { brandSecondary }
    public var interactiveDisabled: Color { Color(hex: "#7986CB").opacity(0.4) }
    public var interactiveActive: Color   { brandSecondary }
    public var interactiveFocus: Color    { brandTertiary }
    
    // MARK: - Accent Colors
    public var accent: Color             { brandPrimary }
    public var accentSecondary: Color    { brandSecondary }
    public var accentTertiary: Color     { brandTertiary }
    
    // MARK: - Control-specific Colors
    public var knobPrimary: Color        { brandQuaternary }
    public var knobSecondary: Color      { brandQuinary }
    public var sliderTrack: Color        { surfaceSecondary }
    public var sliderThumb: Color        { brandPrimary }
    public var buttonPrimary: Color      { brandSecondary }
    public var buttonSecondary: Color    { brandTertiary }
    public var padActive: Color          { brandPrimary }
    public var padInactive: Color        { surfacePrimary }
    
    // MARK: - Special Elements
    public var neutralHighlight: Color   { Color(hex: "#9C27B0").opacity(0.8) }  // Purple highlight
    public var subtleAccent: Color       { Color(hex: "#16213E") }               // Dark blue subtle accent
    public var stateSpecial: Color       { Color(hex: "#1A1A2E") }               // Dark purple special state
    public var paleGreenAccent: Color    { Color(hex: "#4CAF50").opacity(0.6) }  // Green accent
    public var panelBackground: Color    { Color(hex: "#0A0A0F") }               // Deep space black panel
    public var controlBackground: Color  { Color(hex: "#1A1A2E") }               // Dark purple control background
} 