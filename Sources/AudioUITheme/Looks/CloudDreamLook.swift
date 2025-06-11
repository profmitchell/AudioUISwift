//
//  CloudDreamLook.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 6/10/25.
//

import SwiftUI

// MARK: - Cloud Dream Look
@available(iOS 18.0, macOS 15.0, *)
public struct CloudDreamLook: Look, Sendable {
    public init() {}
    
    // MARK: - Cloud Dream Brand Colors
    public var brandPrimary: Color      { Color(hex: "#B8D4E3") }    // Soft Sky Blue
    public var brandSecondary: Color    { Color(hex: "#C5CAE9") }    // Lavender Gray
    public var brandTertiary: Color     { Color(hex: "#D1C4E9") }    // Soft Lavender
    public var brandQuaternary: Color   { Color(hex: "#E1BEE7") }    // Pale Purple
    public var brandQuinary: Color      { Color(hex: "#F8BBD0") }    // Soft Pink
    
    // MARK: - State Colors
    public var stateSuccess: Color      { Color(hex: "#C5E1A5") }    // Soft Green
    public var stateWarning: Color      { Color(hex: "#FFE0B2") }    // Soft Peach
    public var stateError: Color        { Color(hex: "#FFCDD2") }    // Soft Rose
    public var stateInfo: Color         { Color(hex: "#B3E5FC") }    // Soft Cyan
    public var stateLink: Color         { Color(hex: "#B8D4E3") }    // Sky Blue Link
    
    // MARK: - Background Colors
    public var backgroundPrimary: Color   { Color(hex: "#F5F5F7") }  // Off White
    public var backgroundSecondary: Color { Color(hex: "#EEEFF3") }  // Light Gray
    public var backgroundTertiary: Color  { Color(hex: "#E7E8EF") }  // Pale Blue Gray
    public var surfacePrimary: Color      { Color(hex: "#FFFFFF") }  // Pure White
    public var surfaceSecondary: Color    { Color(hex: "#FAFBFC") }  // Almost White
    public var surfaceTertiary: Color     { Color(hex: "#F7F8FA") }  // Soft White
    
    // MARK: - Surface Variations
    public var surface: Color               { Color(hex: "#FFFFFF") }
    public var surfacePressed: Color        { Color(hex: "#F7F8FA") }
    public var surfaceElevated: Color       { Color(hex: "#FFFFFF") }
    public var surfaceDeep: Color           { Color(hex: "#EEEFF3") }
    public var surfaceRaised: Color         { Color(hex: "#FAFBFC") }
    
    // MARK: - Text Colors
    public var textPrimary: Color         { Color(hex: "#4A5568") }         // Soft Dark Gray
    public var textSecondary: Color       { Color(hex: "#718096") }         // Medium Gray
    public var textTertiary: Color        { Color(hex: "#A0AEC0") }         // Light Gray
    public var textDisabled: Color        { Color(hex: "#CBD5E0") }         // Very Light Gray
    public var textAccent: Color          { Color(hex: "#7B93DB") }         // Soft Blue
    public var textHighlight: Color       { Color(hex: "#9FA8DA") }         // Soft Purple
    
    // MARK: - Effect Colors
    public var glassOverlay: Color        { Color(hex: "#B8D4E3").opacity(0.08) }
    public var glassBorder: Color         { Color(hex: "#C5CAE9").opacity(0.2) }
    public var glowPrimary: Color         { brandPrimary.opacity(0.3) }
    public var glowSecondary: Color       { brandSecondary.opacity(0.25) }
    public var glowAccent: Color          { brandTertiary.opacity(0.3) }
    public var neutralDivider: Color      { Color(hex: "#E2E8F0").opacity(0.7) }
    
    // MARK: - Shadow Colors
    public var shadowDark: Color          { Color(hex: "#718096").opacity(0.1) }
    public var shadowLight: Color         { Color(hex: "#B8D4E3").opacity(0.15) }
    public var shadowMedium: Color        { Color(hex: "#A0AEC0").opacity(0.08) }
    public var shadowDeep: Color          { Color(hex: "#4A5568").opacity(0.15) }
    
    // MARK: - Interactive State Colors
    public var interactiveIdle: Color     { brandPrimary.opacity(0.7) }
    public var interactiveHover: Color    { brandPrimary.opacity(0.85) }
    public var interactivePressed: Color  { brandPrimary.opacity(0.6) }
    public var interactiveDisabled: Color { Color(hex: "#CBD5E0").opacity(0.5) }
    public var interactiveActive: Color   { brandSecondary }
    public var interactiveFocus: Color    { brandTertiary }
    
    // MARK: - Accent Colors
    public var accent: Color             { brandPrimary }
    public var accentSecondary: Color    { brandSecondary }
    public var accentTertiary: Color     { brandTertiary }
    
    // MARK: - Control-specific Colors
    public var knobPrimary: Color        { Color(hex: "#E1BEE7") }     // Pale Purple
    public var knobSecondary: Color      { Color(hex: "#F8BBD0") }     // Soft Pink
    public var sliderTrack: Color        { Color(hex: "#E2E8F0") }     // Light Track
    public var sliderThumb: Color        { brandPrimary }
    public var buttonPrimary: Color      { brandSecondary }
    public var buttonSecondary: Color    { brandTertiary }
    public var padActive: Color          { brandPrimary }
    public var padInactive: Color        { Color(hex: "#F7F8FA") }
    
    // MARK: - Special Elements
    public var neutralHighlight: Color   { Color(hex: "#B8D4E3").opacity(0.5) }  // Soft blue highlight
    public var subtleAccent: Color       { Color(hex: "#EEEFF3") }               // Light gray subtle
    public var stateSpecial: Color       { Color(hex: "#D1C4E9") }               // Lavender special
    public var paleGreenAccent: Color    { Color(hex: "#C5E1A5").opacity(0.4) }  // Very soft green
    public var panelBackground: Color    { Color(hex: "#F5F5F7") }               // Off white panel
    public var controlBackground: Color  { Color(hex: "#FAFBFC") }               // Almost white control
}
