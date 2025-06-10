//
//  ForestLook.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 6/6/25.
//

import SwiftUI

// MARK: - Forest Look
@available(iOS 18.0, macOS 15.0, *)
public struct ForestLook: Look, Sendable {
    public init() {}
    
    // MARK: - Forest Brand Colors
    public var brandPrimary: Color      { Color(hex: "#2E7D32") }    // Forest Green
    public var brandSecondary: Color    { Color(hex: "#388E3C") }    // Medium Green
    public var brandTertiary: Color     { Color(hex: "#4CAF50") }    // Light Green
    public var brandQuaternary: Color   { Color(hex: "#66BB6A") }    // Soft Green
    public var brandQuinary: Color      { Color(hex: "#81C784") }    // Pale Green
    
    // MARK: - State Colors
    public var stateSuccess: Color      { Color(hex: "#4CAF50") }    // Success Green
    public var stateWarning: Color      { Color(hex: "#FF8F00") }    // Amber Warning
    public var stateError: Color        { Color(hex: "#D32F2F") }    // Forest Red
    public var stateInfo: Color         { Color(hex: "#1976D2") }    // Forest Blue
    public var stateLink: Color         { Color(hex: "#2E7D32") }    // Green Link
    
    // MARK: - Background Colors
    public var backgroundPrimary: Color   { Color(hex: "#1B5E20") }  // Dark Forest
    public var backgroundSecondary: Color { Color(hex: "#2E7D32") }  // Forest Green
    public var backgroundTertiary: Color  { Color(hex: "#388E3C") }  // Medium Forest
    public var surfacePrimary: Color      { Color(hex: "#4CAF50") }  // Light Forest
    public var surfaceSecondary: Color    { Color(hex: "#66BB6A") }  // Soft Forest
    public var surfaceTertiary: Color     { Color(hex: "#81C784") }  // Pale Forest
    
    // MARK: - Surface Variations
    public var surface: Color               { Color(hex: "#4CAF50") }
    public var surfacePressed: Color        { Color(hex: "#388E3C") }
    public var surfaceElevated: Color       { Color(hex: "#66BB6A") }
    public var surfaceDeep: Color           { Color(hex: "#2E7D32") }
    public var surfaceRaised: Color         { Color(hex: "#81C784") }
    
    // MARK: - Text Colors
    public var textPrimary: Color         { Color.white }
    public var textSecondary: Color       { Color.white.opacity(0.9) }
    public var textTertiary: Color        { Color.white.opacity(0.75) }
    public var textDisabled: Color        { Color.white.opacity(0.5) }
    public var textAccent: Color          { brandPrimary }
    public var textHighlight: Color       { brandSecondary }
    
    // MARK: - Effect Colors
    public var glassOverlay: Color        { brandPrimary.opacity(0.12) }
    public var glassBorder: Color         { brandPrimary.opacity(0.25) }
    public var glowPrimary: Color         { brandPrimary.opacity(0.7) }
    public var glowSecondary: Color       { brandSecondary.opacity(0.6) }
    public var glowAccent: Color          { brandTertiary.opacity(0.8) }
    public var neutralDivider: Color      { Color(hex: "#388E3C").opacity(0.4) }
    
    // MARK: - Shadow Colors
    public var shadowDark: Color          { Color.black.opacity(0.5) }
    public var shadowLight: Color         { brandPrimary.opacity(0.25) }
    public var shadowMedium: Color        { Color.black.opacity(0.25) }
    public var shadowDeep: Color          { Color.black.opacity(0.7) }
    
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
    public var neutralHighlight: Color   { Color(hex: "#2E7D32").opacity(0.8) }  // Forest highlight
    public var subtleAccent: Color       { Color(hex: "#388E3C") }               // Forest subtle accent
    public var stateSpecial: Color       { Color(hex: "#2E7D32") }               // Forest special state
    public var paleGreenAccent: Color    { Color(hex: "#81C784").opacity(0.7) }  // Natural green accent
    public var panelBackground: Color    { Color(hex: "#1B5E20") }               // Dark forest panel
    public var controlBackground: Color  { Color(hex: "#2E7D32") }               // Forest control background
} 