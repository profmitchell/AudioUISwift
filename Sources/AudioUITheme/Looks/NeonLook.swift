//
//  NeonLook.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 6/6/25.
//

import SwiftUI

// MARK: - Neon Cyberpunk Look
@available(iOS 18.0, macOS 15.0, *)
public struct NeonLook: Look, Sendable {
    public init() {}
    
    // MARK: - Neon Cyberpunk Brand Colors
    public var brandPrimary: Color      { Color(hex: "#00FF41") }    // Matrix Green
    public var brandSecondary: Color    { Color(hex: "#FF0080") }    // Hot Pink
    public var brandTertiary: Color     { Color(hex: "#00FFFF") }    // Cyan
    public var brandQuaternary: Color   { Color(hex: "#FFFF00") }    // Electric Yellow
    public var brandQuinary: Color      { Color(hex: "#FF4500") }    // Neon Orange
    
    // MARK: - State Colors
    public var stateSuccess: Color      { Color(hex: "#00FF41") }    // Matrix Green
    public var stateWarning: Color      { Color(hex: "#FFFF00") }    // Electric Yellow
    public var stateError: Color        { Color(hex: "#FF0080") }    // Hot Pink
    public var stateInfo: Color         { Color(hex: "#00FFFF") }    // Cyan
    public var stateLink: Color         { Color(hex: "#00FF41") }    // Matrix Green
    
    // MARK: - Background Colors
    public var backgroundPrimary: Color   { Color(hex: "#0A0A0A") }  // Almost Black
    public var backgroundSecondary: Color { Color(hex: "#1A1A1A") }  // Dark Gray
    public var backgroundTertiary: Color  { Color(hex: "#2A2A2A") }  // Medium Gray
    public var surfacePrimary: Color      { Color(hex: "#1A1A1A") }  // Dark Gray
    public var surfaceSecondary: Color    { Color(hex: "#2A2A2A") }  // Medium Gray
    public var surfaceTertiary: Color     { Color(hex: "#3A3A3A") }  // Light Gray
    
    // MARK: - Surface Variations
    public var surface: Color               { Color(hex: "#1A1A1A") }
    public var surfacePressed: Color        { Color(hex: "#0A0A0A") }
    public var surfaceElevated: Color       { Color(hex: "#2A2A2A") }
    public var surfaceDeep: Color           { Color(hex: "#000000") }
    public var surfaceRaised: Color         { Color(hex: "#3A3A3A") }
    
    // MARK: - Text Colors
    public var textPrimary: Color         { Color.white }
    public var textSecondary: Color       { Color(hex: "#00FFFF") }    // Cyan text
    public var textTertiary: Color        { Color.white.opacity(0.7) }
    public var textDisabled: Color        { Color.white.opacity(0.3) }
    public var textAccent: Color          { brandPrimary }
    public var textHighlight: Color       { brandSecondary }
    
    // MARK: - Effect Colors
    public var glassOverlay: Color        { brandPrimary.opacity(0.1) }
    public var glassBorder: Color         { brandPrimary.opacity(0.6) }
    public var glowPrimary: Color         { brandPrimary.opacity(0.9) }
    public var glowSecondary: Color       { brandSecondary.opacity(0.8) }
    public var glowAccent: Color          { brandTertiary.opacity(0.8) }
    public var neutralDivider: Color      { Color(hex: "#00FFFF").opacity(0.4) }
    
    // MARK: - Shadow Colors
    public var shadowDark: Color          { Color.black.opacity(0.9) }
    public var shadowLight: Color         { brandPrimary.opacity(0.4) }
    public var shadowMedium: Color        { Color.black.opacity(0.5) }
    public var shadowDeep: Color          { Color.black.opacity(0.95) }
    
    // MARK: - Interactive State Colors
    public var interactiveIdle: Color     { brandPrimary.opacity(0.8) }
    public var interactiveHover: Color    { brandPrimary }
    public var interactivePressed: Color  { brandSecondary }
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
    public var neutralHighlight: Color   { Color(hex: "#00FF41").opacity(0.8) }  // Matrix green highlight
    public var subtleAccent: Color       { Color(hex: "#2A2A2A") }               // Dark subtle accent
    public var stateSpecial: Color       { Color(hex: "#1A1A1A") }               // Dark special state
    public var paleGreenAccent: Color    { Color(hex: "#00FF41").opacity(0.6) }  // Matrix green accent
    public var panelBackground: Color    { Color(hex: "#0A0A0A") }               // Almost black panel
    public var controlBackground: Color  { Color(hex: "#1A1A1A") }               // Dark control background
} 