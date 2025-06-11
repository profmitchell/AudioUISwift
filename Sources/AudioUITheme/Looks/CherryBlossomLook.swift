//
//  CherryBlossomLook.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 6/10/25.
//

import SwiftUI

// MARK: - Cherry Blossom Look
@available(iOS 18.0, macOS 15.0, *)
public struct CherryBlossomLook: Look, Sendable {
    public init() {}
    
    // MARK: - Cherry Blossom Brand Colors
    public var brandPrimary: Color      { Color(hex: "#FFB7C5") }    // Sakura Pink
    public var brandSecondary: Color    { Color(hex: "#FF69B4") }    // Hot Pink
    public var brandTertiary: Color     { Color(hex: "#FFC0CB") }    // Light Pink
    public var brandQuaternary: Color   { Color(hex: "#E91E63") }    // Deep Pink
    public var brandQuinary: Color      { Color(hex: "#F8BBD0") }    // Pale Pink
    
    // MARK: - State Colors
    public var stateSuccess: Color      { Color(hex: "#8BC34A") }    // Light Green
    public var stateWarning: Color      { Color(hex: "#FFAB91") }    // Peach
    public var stateError: Color        { Color(hex: "#E91E63") }    // Deep Pink
    public var stateInfo: Color         { Color(hex: "#CE93D8") }    // Light Purple
    public var stateLink: Color         { Color(hex: "#FF69B4") }    // Hot Pink Link
    
    // MARK: - Background Colors
    public var backgroundPrimary: Color   { Color(hex: "#2D1B2E") }  // Deep Plum
    public var backgroundSecondary: Color { Color(hex: "#3E2140") }  // Dark Purple
    public var backgroundTertiary: Color  { Color(hex: "#4F2752") }  // Medium Plum
    public var surfacePrimary: Color      { Color(hex: "#5D3561") }  // Light Plum
    public var surfaceSecondary: Color    { Color(hex: "#6B4370") }  // Lighter Plum
    public var surfaceTertiary: Color     { Color(hex: "#79517F") }  // Soft Purple
    
    // MARK: - Surface Variations
    public var surface: Color               { Color(hex: "#5D3561") }
    public var surfacePressed: Color        { Color(hex: "#4F2752") }
    public var surfaceElevated: Color       { Color(hex: "#6B4370") }
    public var surfaceDeep: Color           { Color(hex: "#3E2140") }
    public var surfaceRaised: Color         { Color(hex: "#79517F") }
    
    // MARK: - Text Colors
    public var textPrimary: Color         { Color(hex: "#FFF0F5") }         // Lavender Blush
    public var textSecondary: Color       { Color(hex: "#FFE4E1") }         // Misty Rose
    public var textTertiary: Color        { Color(hex: "#FFDAB9") }         // Peach Puff
    public var textDisabled: Color        { Color(hex: "#8B7D8B") }         // Dusty Purple
    public var textAccent: Color          { brandPrimary }
    public var textHighlight: Color       { brandSecondary }
    
    // MARK: - Effect Colors
    public var glassOverlay: Color        { Color(hex: "#FFB7C5").opacity(0.2) }
    public var glassBorder: Color         { Color(hex: "#FF69B4").opacity(0.4) }
    public var glowPrimary: Color         { brandPrimary.opacity(0.8) }
    public var glowSecondary: Color       { brandSecondary.opacity(0.6) }
    public var glowAccent: Color          { brandTertiary.opacity(0.7) }
    public var neutralDivider: Color      { Color(hex: "#79517F").opacity(0.5) }
    
    // MARK: - Shadow Colors
    public var shadowDark: Color          { Color(hex: "#1A0F1B").opacity(0.7) }
    public var shadowLight: Color         { Color(hex: "#FFB7C5").opacity(0.3) }
    public var shadowMedium: Color        { Color(hex: "#2D1B2E").opacity(0.5) }
    public var shadowDeep: Color          { Color(hex: "#0D0A0E").opacity(0.8) }
    
    // MARK: - Interactive State Colors
    public var interactiveIdle: Color     { brandPrimary.opacity(0.8) }
    public var interactiveHover: Color    { brandPrimary }
    public var interactivePressed: Color  { brandPrimary.opacity(0.6) }
    public var interactiveDisabled: Color { Color(hex: "#8B7D8B").opacity(0.4) }
    public var interactiveActive: Color   { brandSecondary }
    public var interactiveFocus: Color    { brandQuaternary }
    
    // MARK: - Accent Colors
    public var accent: Color             { brandPrimary }
    public var accentSecondary: Color    { brandSecondary }
    public var accentTertiary: Color     { brandTertiary }
    
    // MARK: - Control-specific Colors
    public var knobPrimary: Color        { Color(hex: "#F48FB1") }     // Medium Pink
    public var knobSecondary: Color      { Color(hex: "#F8BBD0") }     // Light Pink
    public var sliderTrack: Color        { surfaceSecondary }
    public var sliderThumb: Color        { brandPrimary }
    public var buttonPrimary: Color      { brandSecondary }
    public var buttonSecondary: Color    { brandTertiary }
    public var padActive: Color          { brandPrimary }
    public var padInactive: Color        { surfacePrimary }
    
    // MARK: - Special Elements
    public var neutralHighlight: Color   { Color(hex: "#FFB7C5").opacity(0.9) }  // Sakura highlight
    public var subtleAccent: Color       { Color(hex: "#6B4370") }               // Plum subtle
    public var stateSpecial: Color       { Color(hex: "#CE93D8") }               // Lavender special
    public var paleGreenAccent: Color    { Color(hex: "#8BC34A").opacity(0.4) }  // Soft green accent
    public var panelBackground: Color    { Color(hex: "#2D1B2E") }               // Deep plum panel
    public var controlBackground: Color  { Color(hex: "#3E2140") }               // Dark purple control
}
