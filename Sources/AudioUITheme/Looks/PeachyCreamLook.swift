//
//  PeachyCreamLook.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 6/10/25.
//

import SwiftUI

// MARK: - Peachy Cream Look
@available(iOS 18.0, macOS 15.0, *)
public struct PeachyCreamLook: Look, Sendable {
    public init() {}
    
    // MARK: - Peachy Cream Brand Colors
    public var brandPrimary: Color      { Color(hex: "#FFCCBC") }    // Soft Peach
    public var brandSecondary: Color    { Color(hex: "#FFE0B2") }    // Cream
    public var brandTertiary: Color     { Color(hex: "#FFF3E0") }    // Light Cream
    public var brandQuaternary: Color   { Color(hex: "#FFAB91") }    // Coral Peach
    public var brandQuinary: Color      { Color(hex: "#FBE9E7") }    // Very Light Peach
    
    // MARK: - State Colors
    public var stateSuccess: Color      { Color(hex: "#DCEDC8") }    // Soft Mint
    public var stateWarning: Color      { Color(hex: "#FFF9C4") }    // Soft Yellow
    public var stateError: Color        { Color(hex: "#FFCDD2") }    // Soft Pink
    public var stateInfo: Color         { Color(hex: "#E1F5FE") }    // Soft Sky
    public var stateLink: Color         { Color(hex: "#FFAB91") }    // Coral Link
    
    // MARK: - Background Colors
    public var backgroundPrimary: Color   { Color(hex: "#FFF8F5") }  // Cream White
    public var backgroundSecondary: Color { Color(hex: "#FFF3ED") }  // Light Peach
    public var backgroundTertiary: Color  { Color(hex: "#FFEDE7") }  // Pale Peach
    public var surfacePrimary: Color      { Color(hex: "#FFFFFF") }  // Pure White
    public var surfaceSecondary: Color    { Color(hex: "#FFFBF8") }  // Off White
    public var surfaceTertiary: Color     { Color(hex: "#FFF8F3") }  // Cream
    
    // MARK: - Surface Variations
    public var surface: Color               { Color(hex: "#FFFFFF") }
    public var surfacePressed: Color        { Color(hex: "#FFF8F3") }
    public var surfaceElevated: Color       { Color(hex: "#FFFFFF") }
    public var surfaceDeep: Color           { Color(hex: "#FFF3ED") }
    public var surfaceRaised: Color         { Color(hex: "#FFFBF8") }
    
    // MARK: - Text Colors
    public var textPrimary: Color         { Color(hex: "#5D4037") }         // Soft Brown
    public var textSecondary: Color       { Color(hex: "#795548") }         // Medium Brown
    public var textTertiary: Color        { Color(hex: "#A1887F") }         // Light Brown
    public var textDisabled: Color        { Color(hex: "#BCAAA4") }         // Very Light Brown
    public var textAccent: Color          { Color(hex: "#FF8A65") }         // Soft Orange
    public var textHighlight: Color       { Color(hex: "#FFAB91") }         // Coral
    
    // MARK: - Effect Colors
    public var glassOverlay: Color        { Color(hex: "#FFCCBC").opacity(0.08) }
    public var glassBorder: Color         { Color(hex: "#FFE0B2").opacity(0.2) }
    public var glowPrimary: Color         { brandPrimary.opacity(0.3) }
    public var glowSecondary: Color       { brandSecondary.opacity(0.25) }
    public var glowAccent: Color          { brandQuaternary.opacity(0.3) }
    public var neutralDivider: Color      { Color(hex: "#FFEDE7").opacity(0.6) }
    
    // MARK: - Shadow Colors
    public var shadowDark: Color          { Color(hex: "#795548").opacity(0.08) }
    public var shadowLight: Color         { Color(hex: "#FFCCBC").opacity(0.15) }
    public var shadowMedium: Color        { Color(hex: "#A1887F").opacity(0.06) }
    public var shadowDeep: Color          { Color(hex: "#5D4037").opacity(0.12) }
    
    // MARK: - Interactive State Colors
    public var interactiveIdle: Color     { brandPrimary.opacity(0.7) }
    public var interactiveHover: Color    { brandPrimary.opacity(0.85) }
    public var interactivePressed: Color  { brandPrimary.opacity(0.6) }
    public var interactiveDisabled: Color { Color(hex: "#BCAAA4").opacity(0.5) }
    public var interactiveActive: Color   { brandQuaternary }
    public var interactiveFocus: Color    { brandSecondary }
    
    // MARK: - Accent Colors
    public var accent: Color             { brandPrimary }
    public var accentSecondary: Color    { brandSecondary }
    public var accentTertiary: Color     { brandTertiary }
    
    // MARK: - Control-specific Colors
    public var knobPrimary: Color        { Color(hex: "#FFAB91") }     // Coral Peach
    public var knobSecondary: Color      { Color(hex: "#FFE0B2") }     // Cream
    public var sliderTrack: Color        { Color(hex: "#FFEDE7") }     // Pale Track
    public var sliderThumb: Color        { brandPrimary }
    public var buttonPrimary: Color      { brandQuaternary }
    public var buttonSecondary: Color    { brandSecondary }
    public var padActive: Color          { brandPrimary }
    public var padInactive: Color        { Color(hex: "#FFF8F3") }
    
    // MARK: - Special Elements
    public var neutralHighlight: Color   { Color(hex: "#FFCCBC").opacity(0.5) }  // Peach highlight
    public var subtleAccent: Color       { Color(hex: "#FFF3ED") }               // Light peach subtle
    public var stateSpecial: Color       { Color(hex: "#FFE0B2") }               // Cream special
    public var paleGreenAccent: Color    { Color(hex: "#DCEDC8").opacity(0.4) }  // Very soft mint
    public var panelBackground: Color    { Color(hex: "#FFF8F5") }               // Cream white panel
    public var controlBackground: Color  { Color(hex: "#FFFBF8") }               // Off white control
}
