//
//  RetroLook.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 6/6/25.
//

import SwiftUI

// MARK: - Retro Vintage Look
@available(iOS 18.0, macOS 15.0, *)
public struct RetroLook: Look, Sendable {
    public init() {}
    
    // MARK: - Retro Vintage Brand Colors
    public var brandPrimary: Color      { Color(hex: "#D2691E") }    // Chocolate Orange
    public var brandSecondary: Color    { Color(hex: "#DAA520") }    // Goldenrod
    public var brandTertiary: Color     { Color(hex: "#CD853F") }    // Peru
    public var brandQuaternary: Color   { Color(hex: "#F4A460") }    // Sandy Brown
    public var brandQuinary: Color      { Color(hex: "#DEB887") }    // Burlywood
    
    // MARK: - State Colors
    public var stateSuccess: Color      { Color(hex: "#228B22") }    // Forest Green
    public var stateWarning: Color      { Color(hex: "#DAA520") }    // Goldenrod
    public var stateError: Color        { Color(hex: "#B22222") }    // Fire Brick
    public var stateInfo: Color         { Color(hex: "#4682B4") }    // Steel Blue
    public var stateLink: Color         { Color(hex: "#D2691E") }    // Chocolate Orange
    
    // MARK: - Background Colors
    public var backgroundPrimary: Color   { Color(hex: "#2F1B14") }  // Dark Brown
    public var backgroundSecondary: Color { Color(hex: "#3D2817") }  // Medium Brown
    public var backgroundTertiary: Color  { Color(hex: "#4A341F") }  // Light Brown
    public var surfacePrimary: Color      { Color(hex: "#5D4037") }  // Brown
    public var surfaceSecondary: Color    { Color(hex: "#6D4C41") }  // Medium Brown
    public var surfaceTertiary: Color     { Color(hex: "#795548") }  // Light Brown
    
    // MARK: - Surface Variations
    public var surface: Color               { Color(hex: "#5D4037") }
    public var surfacePressed: Color        { Color(hex: "#4A341F") }
    public var surfaceElevated: Color       { Color(hex: "#6D4C41") }
    public var surfaceDeep: Color           { Color(hex: "#3D2817") }
    public var surfaceRaised: Color         { Color(hex: "#795548") }
    
    // MARK: - Text Colors
    public var textPrimary: Color         { Color(hex: "#FFF8DC") }  // Cornsilk
    public var textSecondary: Color       { Color(hex: "#F5DEB3") }  // Wheat
    public var textTertiary: Color        { Color(hex: "#DEB887") }  // Burlywood
    public var textDisabled: Color        { Color(hex: "#A0A0A0") }  // Gray
    public var textAccent: Color          { brandPrimary }
    public var textHighlight: Color       { brandSecondary }
    
    // MARK: - Effect Colors
    public var glassOverlay: Color        { brandPrimary.opacity(0.15) }
    public var glassBorder: Color         { brandPrimary.opacity(0.4) }
    public var glowPrimary: Color         { brandPrimary.opacity(0.7) }
    public var glowSecondary: Color       { brandSecondary.opacity(0.6) }
    public var glowAccent: Color          { brandTertiary.opacity(0.8) }
    public var neutralDivider: Color      { Color(hex: "#8B4513").opacity(0.5) }
    
    // MARK: - Shadow Colors
    public var shadowDark: Color          { Color(hex: "#1A0F0A").opacity(0.8) }
    public var shadowLight: Color         { brandSecondary.opacity(0.3) }
    public var shadowMedium: Color        { Color(hex: "#2F1B14").opacity(0.6) }
    public var shadowDeep: Color          { Color.black.opacity(0.9) }
    
    // MARK: - Interactive State Colors
    public var interactiveIdle: Color     { brandPrimary.opacity(0.8) }
    public var interactiveHover: Color    { brandPrimary }
    public var interactivePressed: Color  { brandPrimary.opacity(0.6) }
    public var interactiveDisabled: Color { Color(hex: "#8B4513").opacity(0.4) }
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
    public var neutralHighlight: Color   { Color(hex: "#DAA520").opacity(0.8) }  // Goldenrod highlight
    public var subtleAccent: Color       { Color(hex: "#6D4C41") }               // Brown subtle accent
    public var stateSpecial: Color       { Color(hex: "#5D4037") }               // Brown special state
    public var paleGreenAccent: Color    { Color(hex: "#228B22").opacity(0.6) }  // Forest green accent
    public var panelBackground: Color    { Color(hex: "#2F1B14") }               // Dark brown panel
    public var controlBackground: Color  { Color(hex: "#3D2817") }               // Medium brown control background
} 