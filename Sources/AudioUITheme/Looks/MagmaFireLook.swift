//
//  MagmaFireLook.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 12/23/25.
//

import SwiftUI

// MARK: - Magma Fire Look
@available(iOS 18.0, macOS 15.0, *)
public struct MagmaFireLook: Look, Sendable {
    public init() {}
    
    // MARK: - Magma Brand Colors (Fire & Lava)
    public var brandPrimary: Color      { Color(hex: "FF3D00") }    // Molten Red
    public var brandSecondary: Color    { Color(hex: "FF5722") }    // Lava Orange
    public var brandTertiary: Color     { Color(hex: "FF6F00") }    // Fire Orange
    public var brandQuaternary: Color   { Color(hex: "FF8F00") }    // Hot Amber
    public var brandQuinary: Color      { Color(hex: "FF9800") }    // Ember Orange
    
    // MARK: - State Colors
    public var stateSuccess: Color      { Color(hex: "FF6F00") }    // Fire Success
    public var stateWarning: Color      { Color(hex: "FF8F00") }    // Ember Warning
    public var stateError: Color        { Color(hex: "D32F2F") }    // Deep Fire Error
    public var stateInfo: Color         { Color(hex: "FF5722") }    // Lava Info
    public var stateLink: Color         { Color(hex: "FF3D00") }    // Molten Link
    
    // MARK: - Background Colors (Volcanic Depths)
    public var backgroundPrimary: Color   { Color(hex: "0D0D0D") }  // Volcanic Black
    public var backgroundSecondary: Color { Color(hex: "1A0F0F") }  // Ash Black
    public var backgroundTertiary: Color  { Color(hex: "2D1B1B") }  // Charcoal
    public var surfacePrimary: Color      { Color(hex: "1F1412") }  // Volcanic Rock
    public var surfaceSecondary: Color    { Color(hex: "2A1C1A") }  // Heated Stone
    public var surfaceTertiary: Color     { Color(hex: "3D2B26") }  // Magma Stone
    
    // MARK: - Surface Variations
    public var surface: Color               { Color(hex: "1F1412") }
    public var surfacePressed: Color        { Color(hex: "0D0D0D") }
    public var surfaceElevated: Color       { Color(hex: "3D2B26") }
    public var surfaceDeep: Color           { Color(hex: "050505") }
    public var surfaceRaised: Color         { Color(hex: "4A3530") }
    
    // MARK: - Text Colors
    public var textPrimary: Color         { Color(hex: "FFCCBC") }  // Ember Glow
    public var textSecondary: Color       { Color(hex: "FFAB91") }  // Fire Glow
    public var textTertiary: Color        { Color(hex: "FF8A65") }  // Warm Glow
    public var textDisabled: Color        { Color(hex: "8D6E63") }  // Ash Gray
    public var textAccent: Color          { brandPrimary }
    public var textHighlight: Color       { Color(hex: "FF5722") }
    
    // MARK: - Effect Colors (Fire & Ember)
    public var glassOverlay: Color        { Color(hex: "FF3D00").opacity(0.15) }
    public var glassBorder: Color         { Color(hex: "FF5722").opacity(0.5) }
    public var glowPrimary: Color         { Color(hex: "FF3D00").opacity(0.9) }
    public var glowSecondary: Color       { Color(hex: "FF5722").opacity(0.7) }
    public var glowAccent: Color          { Color(hex: "FF6F00").opacity(0.8) }
    public var neutralDivider: Color      { Color(hex: "5D4037") }
    
    // MARK: - Shadow Colors (Fire Shadows)
    public var shadowDark: Color          { Color.black.opacity(0.95) }
    public var shadowLight: Color         { Color(hex: "FF5722").opacity(0.2) }
    public var shadowMedium: Color        { Color(hex: "3E2723").opacity(0.8) }
    public var shadowDeep: Color          { Color.black }
    
    // MARK: - Interactive State Colors
    public var interactiveIdle: Color     { Color(hex: "FF5722").opacity(0.8) }
    public var interactiveHover: Color    { Color(hex: "FF3D00") }
    public var interactivePressed: Color  { Color(hex: "D32F2F") }
    public var interactiveDisabled: Color { Color(hex: "5D4037") }
    public var interactiveActive: Color   { brandPrimary }
    public var interactiveFocus: Color    { brandSecondary }
    
    // MARK: - Accent Colors
    public var accent: Color             { brandPrimary }
    public var accentSecondary: Color    { brandSecondary }
    public var accentTertiary: Color     { brandTertiary }
    
    // MARK: - Control-specific Colors
    public var knobPrimary: Color        { Color(hex: "8D6E63") }   // Volcanic Stone
    public var knobSecondary: Color      { Color(hex: "6D4C41") }   // Dark Ash
    public var sliderTrack: Color        { surfaceSecondary }
    public var sliderThumb: Color        { brandPrimary }
    public var buttonPrimary: Color      { brandSecondary }
    public var buttonSecondary: Color    { brandTertiary }
    public var padActive: Color          { Color(hex: "FF1744") }   // Hot Magma
    public var padInactive: Color        { surfacePrimary }
    
    // MARK: - Special Elements
    public var neutralHighlight: Color   { Color(hex: "FF8F00").opacity(0.9) }   // Ember highlight
    public var subtleAccent: Color       { Color(hex: "3D2B26") }                // Subtle fire
    public var stateSpecial: Color       { Color(hex: "FF4081") }                // Pink fire
    public var paleGreenAccent: Color    { Color(hex: "FF7043").opacity(0.6) }  // Pale fire accent
    public var panelBackground: Color    { Color(hex: "050505") }                // Deep fire panel
    public var controlBackground: Color  { Color(hex: "0D0D0D") }                // Control fire
} 