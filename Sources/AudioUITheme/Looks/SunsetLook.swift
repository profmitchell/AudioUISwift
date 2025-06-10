//
//  SunsetLook.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 6/6/25.
//

import SwiftUI

// MARK: - Sunset Look
@available(iOS 18.0, macOS 15.0, *)
public struct SunsetLook: Look, Sendable {
    public init() {}
    
    // MARK: - Sunset Brand Colors
    public var brandPrimary: Color      { Color(hex: "#FF6B35") }    // Vibrant Orange
    public var brandSecondary: Color    { Color(hex: "#F7931E") }    // Golden Orange
    public var brandTertiary: Color     { Color(hex: "#FFB74D") }    // Light Orange
    public var brandQuaternary: Color   { Color(hex: "#FF8A65") }    // Coral
    public var brandQuinary: Color      { Color(hex: "#FFAB91") }    // Peach
    
    // MARK: - State Colors
    public var stateSuccess: Color      { Color(hex: "#81C784") }    // Soft Green
    public var stateWarning: Color      { Color(hex: "#FFB74D") }    // Orange Warning
    public var stateError: Color        { Color(hex: "#E57373") }    // Soft Red
    public var stateInfo: Color         { Color(hex: "#64B5F6") }    // Sky Blue
    public var stateLink: Color         { Color(hex: "#FF6B35") }    // Orange Link
    
    // MARK: - Background Colors
    public var backgroundPrimary: Color   { Color(hex: "#2E1065") }  // Deep Purple
    public var backgroundSecondary: Color { Color(hex: "#4A148C") }  // Purple
    public var backgroundTertiary: Color  { Color(hex: "#6A1B9A") }  // Medium Purple
    public var surfacePrimary: Color      { Color(hex: "#7B1FA2") }  // Light Purple
    public var surfaceSecondary: Color    { Color(hex: "#8E24AA") }  // Lighter Purple
    public var surfaceTertiary: Color     { Color(hex: "#9C27B0") }  // Lightest Purple
    
    // MARK: - Surface Variations
    public var surface: Color               { Color(hex: "#7B1FA2") }
    public var surfacePressed: Color        { Color(hex: "#6A1B9A") }
    public var surfaceElevated: Color       { Color(hex: "#8E24AA") }
    public var surfaceDeep: Color           { Color(hex: "#4A148C") }
    public var surfaceRaised: Color         { Color(hex: "#9C27B0") }
    
    // MARK: - Text Colors
    public var textPrimary: Color         { Color.white }
    public var textSecondary: Color       { Color.white.opacity(0.9) }
    public var textTertiary: Color        { Color.white.opacity(0.7) }
    public var textDisabled: Color        { Color.white.opacity(0.4) }
    public var textAccent: Color          { brandPrimary }
    public var textHighlight: Color       { brandSecondary }
    
    // MARK: - Effect Colors
    public var glassOverlay: Color        { brandPrimary.opacity(0.1) }
    public var glassBorder: Color         { brandPrimary.opacity(0.3) }
    public var glowPrimary: Color         { brandPrimary.opacity(0.8) }
    public var glowSecondary: Color       { brandSecondary.opacity(0.6) }
    public var glowAccent: Color          { brandTertiary.opacity(0.7) }
    public var neutralDivider: Color      { Color(hex: "#8E24AA").opacity(0.5) }
    
    // MARK: - Shadow Colors
    public var shadowDark: Color          { Color.black.opacity(0.6) }
    public var shadowLight: Color         { brandPrimary.opacity(0.3) }
    public var shadowMedium: Color        { Color.black.opacity(0.3) }
    public var shadowDeep: Color          { Color.black.opacity(0.8) }
    
    // MARK: - Interactive State Colors
    public var interactiveIdle: Color     { brandPrimary.opacity(0.8) }
    public var interactiveHover: Color    { brandPrimary }
    public var interactivePressed: Color  { brandPrimary.opacity(0.6) }
    public var interactiveDisabled: Color { Color.gray.opacity(0.4) }
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
    public var neutralHighlight: Color   { Color(hex: "#FF6B35").opacity(0.8) }  // Orange highlight
    public var subtleAccent: Color       { Color(hex: "#8E24AA") }               // Purple subtle accent
    public var stateSpecial: Color       { Color(hex: "#6A1B9A") }               // Purple special state
    public var paleGreenAccent: Color    { Color(hex: "#81C784").opacity(0.6) }  // Soft green accent
    public var panelBackground: Color    { Color(hex: "#2E1065") }               // Deep purple panel
    public var controlBackground: Color  { Color(hex: "#4A148C") }               // Purple control background
} 