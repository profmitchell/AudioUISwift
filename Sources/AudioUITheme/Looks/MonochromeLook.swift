//
//  MonochromeLook.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 6/6/25.
//

import SwiftUI

// MARK: - Monochrome Elegant Look
@available(iOS 18.0, macOS 15.0, *)
public struct MonochromeLook: Look, Sendable {
    public init() {}
    
    // MARK: - Monochrome Brand Colors
    public var brandPrimary: Color      { Color(hex: "#FFFFFF") }    // Pure White
    public var brandSecondary: Color    { Color(hex: "#E0E0E0") }    // Light Gray
    public var brandTertiary: Color     { Color(hex: "#BDBDBD") }    // Medium Gray
    public var brandQuaternary: Color   { Color(hex: "#9E9E9E") }    // Gray
    public var brandQuinary: Color      { Color(hex: "#757575") }    // Dark Gray
    
    // MARK: - State Colors
    public var stateSuccess: Color      { Color(hex: "#FFFFFF") }    // White Success
    public var stateWarning: Color      { Color(hex: "#BDBDBD") }    // Gray Warning
    public var stateError: Color        { Color(hex: "#424242") }    // Dark Gray Error
    public var stateInfo: Color         { Color(hex: "#E0E0E0") }    // Light Gray Info
    public var stateLink: Color         { Color(hex: "#FFFFFF") }    // White Link
    
    // MARK: - Background Colors
    public var backgroundPrimary: Color   { Color(hex: "#121212") }  // Almost Black
    public var backgroundSecondary: Color { Color(hex: "#1E1E1E") }  // Dark Gray
    public var backgroundTertiary: Color  { Color(hex: "#2A2A2A") }  // Medium Dark Gray
    public var surfacePrimary: Color      { Color(hex: "#2A2A2A") }  // Medium Dark Gray
    public var surfaceSecondary: Color    { Color(hex: "#3A3A3A") }  // Medium Gray
    public var surfaceTertiary: Color     { Color(hex: "#4A4A4A") }  // Light Gray
    
    // MARK: - Surface Variations
    public var surface: Color               { Color(hex: "#2A2A2A") }
    public var surfacePressed: Color        { Color(hex: "#1E1E1E") }
    public var surfaceElevated: Color       { Color(hex: "#3A3A3A") }
    public var surfaceDeep: Color           { Color(hex: "#121212") }
    public var surfaceRaised: Color         { Color(hex: "#4A4A4A") }
    
    // MARK: - Text Colors
    public var textPrimary: Color         { Color.white }
    public var textSecondary: Color       { Color(hex: "#E0E0E0") }
    public var textTertiary: Color        { Color(hex: "#BDBDBD") }
    public var textDisabled: Color        { Color(hex: "#757575") }
    public var textAccent: Color          { brandPrimary }
    public var textHighlight: Color       { brandSecondary }
    
    // MARK: - Effect Colors
    public var glassOverlay: Color        { Color.white.opacity(0.05) }
    public var glassBorder: Color         { Color.white.opacity(0.2) }
    public var glowPrimary: Color         { Color.white.opacity(0.6) }
    public var glowSecondary: Color       { Color.white.opacity(0.4) }
    public var glowAccent: Color          { Color.white.opacity(0.8) }
    public var neutralDivider: Color      { Color(hex: "#424242") }
    
    // MARK: - Shadow Colors
    public var shadowDark: Color          { Color.black.opacity(0.8) }
    public var shadowLight: Color         { Color.white.opacity(0.1) }
    public var shadowMedium: Color        { Color.black.opacity(0.4) }
    public var shadowDeep: Color          { Color.black.opacity(0.9) }
    
    // MARK: - Interactive State Colors
    public var interactiveIdle: Color     { Color.white.opacity(0.8) }
    public var interactiveHover: Color    { Color.white }
    public var interactivePressed: Color  { Color.white.opacity(0.6) }
    public var interactiveDisabled: Color { Color(hex: "#757575") }
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
    public var neutralHighlight: Color   { Color.white.opacity(0.8) }            // White highlight
    public var subtleAccent: Color       { Color(hex: "#3A3A3A") }               // Gray subtle accent
    public var stateSpecial: Color       { Color(hex: "#2A2A2A") }               // Dark gray special state
    public var paleGreenAccent: Color    { Color(hex: "#E0E0E0").opacity(0.6) }  // Light gray accent
    public var panelBackground: Color    { Color(hex: "#121212") }               // Almost black panel
    public var controlBackground: Color  { Color(hex: "#1E1E1E") }               // Dark gray control background
} 