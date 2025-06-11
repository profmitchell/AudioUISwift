//
//  DeepOceanLook.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 6/10/25.
//

import SwiftUI

// MARK: - Deep Ocean Look
@available(iOS 18.0, macOS 15.0, *)
public struct DeepOceanLook: Look, Sendable {
    public init() {}
    
    // MARK: - Deep Ocean Brand Colors
    public var brandPrimary: Color      { Color(hex: "#00ACC1") }    // Cyan Ocean
    public var brandSecondary: Color    { Color(hex: "#0097A7") }    // Deep Cyan
    public var brandTertiary: Color     { Color(hex: "#00BCD4") }    // Light Cyan
    public var brandQuaternary: Color   { Color(hex: "#006064") }    // Dark Teal
    public var brandQuinary: Color      { Color(hex: "#84FFFF") }    // Aqua Light
    
    // MARK: - State Colors
    public var stateSuccess: Color      { Color(hex: "#00E676") }    // Bright Green
    public var stateWarning: Color      { Color(hex: "#FFC107") }    // Amber
    public var stateError: Color        { Color(hex: "#FF5252") }    // Light Red
    public var stateInfo: Color         { Color(hex: "#40C4FF") }    // Light Blue
    public var stateLink: Color         { Color(hex: "#00ACC1") }    // Cyan Link
    
    // MARK: - Background Colors
    public var backgroundPrimary: Color   { Color(hex: "#0A1929") }  // Deep Ocean Blue
    public var backgroundSecondary: Color { Color(hex: "#0F2741") }  // Dark Navy
    public var backgroundTertiary: Color  { Color(hex: "#143553") }  // Medium Navy
    public var surfacePrimary: Color      { Color(hex: "#1A4365") }  // Ocean Surface
    public var surfaceSecondary: Color    { Color(hex: "#205177") }  // Lighter Ocean
    public var surfaceTertiary: Color     { Color(hex: "#265F89") }  // Light Ocean
    
    // MARK: - Surface Variations
    public var surface: Color               { Color(hex: "#1A4365") }
    public var surfacePressed: Color        { Color(hex: "#143553") }
    public var surfaceElevated: Color       { Color(hex: "#205177") }
    public var surfaceDeep: Color           { Color(hex: "#0F2741") }
    public var surfaceRaised: Color         { Color(hex: "#265F89") }
    
    // MARK: - Text Colors
    public var textPrimary: Color         { Color(hex: "#E0F2F1") }         // Pale Cyan
    public var textSecondary: Color       { Color(hex: "#B2DFDB") }         // Light Teal
    public var textTertiary: Color        { Color(hex: "#80CBC4") }         // Medium Teal
    public var textDisabled: Color        { Color(hex: "#4A6572") }         // Gray Blue
    public var textAccent: Color          { brandPrimary }
    public var textHighlight: Color       { brandQuinary }
    
    // MARK: - Effect Colors
    public var glassOverlay: Color        { Color(hex: "#00ACC1").opacity(0.1) }
    public var glassBorder: Color         { Color(hex: "#84FFFF").opacity(0.3) }
    public var glowPrimary: Color         { brandPrimary.opacity(0.8) }
    public var glowSecondary: Color       { brandQuinary.opacity(0.6) }
    public var glowAccent: Color          { brandTertiary.opacity(0.7) }
    public var neutralDivider: Color      { Color(hex: "#265F89").opacity(0.5) }
    
    // MARK: - Shadow Colors
    public var shadowDark: Color          { Color(hex: "#000A12").opacity(0.8) }
    public var shadowLight: Color         { Color(hex: "#00ACC1").opacity(0.2) }
    public var shadowMedium: Color        { Color(hex: "#0A1929").opacity(0.6) }
    public var shadowDeep: Color          { Color(hex: "#000000").opacity(0.9) }
    
    // MARK: - Interactive State Colors
    public var interactiveIdle: Color     { brandPrimary.opacity(0.7) }
    public var interactiveHover: Color    { brandPrimary }
    public var interactivePressed: Color  { brandPrimary.opacity(0.5) }
    public var interactiveDisabled: Color { Color(hex: "#4A6572").opacity(0.4) }
    public var interactiveActive: Color   { brandQuinary }
    public var interactiveFocus: Color    { brandTertiary }
    
    // MARK: - Accent Colors
    public var accent: Color             { brandPrimary }
    public var accentSecondary: Color    { brandSecondary }
    public var accentTertiary: Color     { brandTertiary }
    
    // MARK: - Control-specific Colors
    public var knobPrimary: Color        { Color(hex: "#26C6DA") }     // Light Cyan
    public var knobSecondary: Color      { Color(hex: "#4DD0E1") }     // Lighter Cyan
    public var sliderTrack: Color        { surfaceSecondary }
    public var sliderThumb: Color        { brandPrimary }
    public var buttonPrimary: Color      { brandSecondary }
    public var buttonSecondary: Color    { brandTertiary }
    public var padActive: Color          { brandPrimary }
    public var padInactive: Color        { surfacePrimary }
    
    // MARK: - Special Elements
    public var neutralHighlight: Color   { Color(hex: "#00ACC1").opacity(0.9) }  // Cyan highlight
    public var subtleAccent: Color       { Color(hex: "#205177") }               // Ocean subtle
    public var stateSpecial: Color       { Color(hex: "#006064") }               // Teal special
    public var paleGreenAccent: Color    { Color(hex: "#00E676").opacity(0.4) }  // Soft green accent
    public var panelBackground: Color    { Color(hex: "#0A1929") }               // Deep ocean panel
    public var controlBackground: Color  { Color(hex: "#0F2741") }               // Dark navy control
}
