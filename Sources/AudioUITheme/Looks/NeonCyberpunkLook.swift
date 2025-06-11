//
//  NeonCyberpunkLook.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 6/10/25.
//

import SwiftUI

// MARK: - Neon Cyberpunk Look
@available(iOS 18.0, macOS 15.0, *)
public struct NeonCyberpunkLook: Look, Sendable {
    public init() {}
    
    // MARK: - Neon Cyberpunk Brand Colors
    public var brandPrimary: Color      { Color(hex: "#FF006E") }    // Hot Magenta
    public var brandSecondary: Color    { Color(hex: "#00F5FF") }    // Electric Cyan
    public var brandTertiary: Color     { Color(hex: "#FFFF00") }    // Neon Yellow
    public var brandQuaternary: Color   { Color(hex: "#8B00FF") }    // Electric Purple
    public var brandQuinary: Color      { Color(hex: "#00FF41") }    // Neon Green
    
    // MARK: - State Colors
    public var stateSuccess: Color      { Color(hex: "#00FF41") }    // Neon Green
    public var stateWarning: Color      { Color(hex: "#FFFF00") }    // Neon Yellow
    public var stateError: Color        { Color(hex: "#FF0040") }    // Neon Red
    public var stateInfo: Color         { Color(hex: "#00F5FF") }    // Electric Cyan
    public var stateLink: Color         { Color(hex: "#FF006E") }    // Hot Magenta Link
    
    // MARK: - Background Colors
    public var backgroundPrimary: Color   { Color(hex: "#0A0A0A") }  // Near Black
    public var backgroundSecondary: Color { Color(hex: "#141414") }  // Dark Gray
    public var backgroundTertiary: Color  { Color(hex: "#1E1E1E") }  // Medium Dark
    public var surfacePrimary: Color      { Color(hex: "#282828") }  // Dark Surface
    public var surfaceSecondary: Color    { Color(hex: "#323232") }  // Gray Surface
    public var surfaceTertiary: Color     { Color(hex: "#3C3C3C") }  // Light Gray
    
    // MARK: - Surface Variations
    public var surface: Color               { Color(hex: "#282828") }
    public var surfacePressed: Color        { Color(hex: "#1E1E1E") }
    public var surfaceElevated: Color       { Color(hex: "#323232") }
    public var surfaceDeep: Color           { Color(hex: "#141414") }
    public var surfaceRaised: Color         { Color(hex: "#3C3C3C") }
    
    // MARK: - Text Colors
    public var textPrimary: Color         { Color(hex: "#FFFFFF") }         // Pure White
    public var textSecondary: Color       { Color(hex: "#E0E0E0") }         // Light Gray
    public var textTertiary: Color        { Color(hex: "#B0B0B0") }         // Medium Gray
    public var textDisabled: Color        { Color(hex: "#606060") }         // Dark Gray
    public var textAccent: Color          { brandPrimary }
    public var textHighlight: Color       { brandSecondary }
    
    // MARK: - Effect Colors
    public var glassOverlay: Color        { Color(hex: "#FF006E").opacity(0.15) }
    public var glassBorder: Color         { Color(hex: "#00F5FF").opacity(0.5) }
    public var glowPrimary: Color         { brandPrimary }
    public var glowSecondary: Color       { brandSecondary.opacity(0.9) }
    public var glowAccent: Color          { brandQuaternary.opacity(0.8) }
    public var neutralDivider: Color      { Color(hex: "#3C3C3C").opacity(0.6) }
    
    // MARK: - Shadow Colors
    public var shadowDark: Color          { Color(hex: "#000000").opacity(0.9) }
    public var shadowLight: Color         { brandPrimary.opacity(0.4) }
    public var shadowMedium: Color        { Color(hex: "#000000").opacity(0.7) }
    public var shadowDeep: Color          { Color(hex: "#000000") }
    
    // MARK: - Interactive State Colors
    public var interactiveIdle: Color     { brandPrimary.opacity(0.7) }
    public var interactiveHover: Color    { brandPrimary }
    public var interactivePressed: Color  { brandPrimary.opacity(0.5) }
    public var interactiveDisabled: Color { Color(hex: "#606060").opacity(0.4) }
    public var interactiveActive: Color   { brandSecondary }
    public var interactiveFocus: Color    { brandQuinary }
    
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
    public var neutralHighlight: Color   { Color(hex: "#FF006E") }               // Magenta highlight
    public var subtleAccent: Color       { Color(hex: "#323232") }               // Gray subtle
    public var stateSpecial: Color       { Color(hex: "#8B00FF") }               // Purple special
    public var paleGreenAccent: Color    { Color(hex: "#00FF41").opacity(0.5) }  // Soft neon green
    public var panelBackground: Color    { Color(hex: "#0A0A0A") }               // Near black panel
    public var controlBackground: Color  { Color(hex: "#141414") }               // Dark control
}
