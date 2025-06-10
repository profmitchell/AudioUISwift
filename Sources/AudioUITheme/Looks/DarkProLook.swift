//
//  DarkProLook.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 6/6/25.
//

import SwiftUI

// MARK: - Dark Professional Look
@available(iOS 18.0, macOS 15.0, *)
public struct DarkProLook: Look, Sendable {
    public init() {}
    
    // MARK: - Professional Dark Brand Colors
    public var brandPrimary: Color      { Color(hex: "#00D4FF") }    // Electric Blue
    public var brandSecondary: Color    { Color(hex: "#FF6B6B") }    // Coral Red
    public var brandTertiary: Color     { Color(hex: "#4ECDC4") }    // Teal
    public var brandQuaternary: Color   { Color(hex: "#FFE66D") }    // Bright Yellow
    public var brandQuinary: Color      { Color(hex: "#A8E6CF") }    // Mint Green
    
    // MARK: - State Colors
    public var stateSuccess: Color      { Color(hex: "#4ECDC4") }    // Success Teal
    public var stateWarning: Color      { Color(hex: "#FFE66D") }    // Warning Yellow
    public var stateError: Color        { Color(hex: "#FF6B6B") }    // Error Red
    public var stateInfo: Color         { Color(hex: "#00D4FF") }    // Info Blue
    public var stateLink: Color         { Color(hex: "#00D4FF") }    // Link Blue
    
    // MARK: - Background Colors
    public var backgroundPrimary: Color   { Color(hex: "#1A1A1A") }  // Almost Black
    public var backgroundSecondary: Color { Color(hex: "#2D2D2D") }  // Dark Gray
    public var backgroundTertiary: Color  { Color(hex: "#3A3A3A") }  // Medium Gray
    public var surfacePrimary: Color      { Color(hex: "#3A3A3A") }  // Medium Gray
    public var surfaceSecondary: Color    { Color(hex: "#4A4A4A") }  // Light Gray
    public var surfaceTertiary: Color     { Color(hex: "#5A5A5A") }  // Lighter Gray
    
    // MARK: - Surface Variations
    public var surface: Color               { Color(hex: "#3A3A3A") }
    public var surfacePressed: Color        { Color(hex: "#2D2D2D") }
    public var surfaceElevated: Color       { Color(hex: "#4A4A4A") }
    public var surfaceDeep: Color           { Color(hex: "#1A1A1A") }
    public var surfaceRaised: Color         { Color(hex: "#5A5A5A") }
    
    // MARK: - Text Colors
    public var textPrimary: Color         { Color.white }
    public var textSecondary: Color       { Color.white.opacity(0.85) }
    public var textTertiary: Color        { Color.white.opacity(0.6) }
    public var textDisabled: Color        { Color.white.opacity(0.3) }
    public var textAccent: Color          { brandPrimary }
    public var textHighlight: Color       { brandSecondary }
    
    // MARK: - Effect Colors
    public var glassOverlay: Color        { brandPrimary.opacity(0.05) }
    public var glassBorder: Color         { brandPrimary.opacity(0.3) }
    public var glowPrimary: Color         { brandPrimary.opacity(0.8) }
    public var glowSecondary: Color       { brandSecondary.opacity(0.6) }
    public var glowAccent: Color          { brandTertiary.opacity(0.7) }
    public var neutralDivider: Color      { Color.gray.opacity(0.3) }
    
    // MARK: - Shadow Colors
    public var shadowDark: Color          { Color.black.opacity(0.8) }
    public var shadowLight: Color         { Color.white.opacity(0.1) }
    public var shadowMedium: Color        { Color.black.opacity(0.4) }
    public var shadowDeep: Color          { Color.black.opacity(0.9) }
    
    // MARK: - Interactive State Colors
    public var interactiveIdle: Color     { brandPrimary.opacity(0.7) }
    public var interactiveHover: Color    { brandPrimary }
    public var interactivePressed: Color  { brandPrimary.opacity(0.5) }
    public var interactiveDisabled: Color { Color.gray.opacity(0.3) }
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
    public var neutralHighlight: Color   { Color(hex: "#00D4FF").opacity(0.8) }  // Electric Blue highlight
    public var subtleAccent: Color       { Color(hex: "#4A4A4A") }               // Dark subtle accent
    public var stateSpecial: Color       { Color(hex: "#2D2D2D") }               // Dark special state
    public var paleGreenAccent: Color    { Color(hex: "#A8E6CF").opacity(0.6) }  // Mint green accent
    public var panelBackground: Color    { Color(hex: "#1A1A1A") }               // Panel background
    public var controlBackground: Color  { Color(hex: "#2D2D2D") }               // Control background
} 