//
//  OceanLook.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 6/6/25.
//

import SwiftUI

// MARK: - Ocean Deep Look
@available(iOS 18.0, macOS 15.0, *)
public struct OceanLook: Look, Sendable {
    public init() {}
    
    // MARK: - Ocean Deep Brand Colors
    public var brandPrimary: Color      { Color(hex: "#26C6DA") }    // Cyan
    public var brandSecondary: Color    { Color(hex: "#42A5F5") }    // Blue
    public var brandTertiary: Color     { Color(hex: "#7E57C2") }    // Purple
    public var brandQuaternary: Color   { Color(hex: "#29B6F6") }    // Light Blue
    public var brandQuinary: Color      { Color(hex: "#5C6BC0") }    // Indigo
    
    // MARK: - State Colors
    public var stateSuccess: Color      { Color(hex: "#66BB6A") }    // Green
    public var stateWarning: Color      { Color(hex: "#FFA726") }    // Orange
    public var stateError: Color        { Color(hex: "#EF5350") }    // Red
    public var stateInfo: Color         { Color(hex: "#42A5F5") }    // Blue
    public var stateLink: Color         { Color(hex: "#26C6DA") }    // Cyan
    
    // MARK: - Background Colors
    public var backgroundPrimary: Color   { Color(hex: "#0D1421") }  // Deep Navy
    public var backgroundSecondary: Color { Color(hex: "#1A2332") }  // Navy
    public var backgroundTertiary: Color  { Color(hex: "#253341") }  // Medium Navy
    public var surfacePrimary: Color      { Color(hex: "#253341") }  // Medium Navy
    public var surfaceSecondary: Color    { Color(hex: "#344155") }  // Light Navy
    public var surfaceTertiary: Color     { Color(hex: "#425069") }  // Lighter Navy
    
    // MARK: - Surface Variations
    public var surface: Color               { Color(hex: "#253341") }
    public var surfacePressed: Color        { Color(hex: "#1A2332") }
    public var surfaceElevated: Color       { Color(hex: "#344155") }
    public var surfaceDeep: Color           { Color(hex: "#0D1421") }
    public var surfaceRaised: Color         { Color(hex: "#425069") }
    
    // MARK: - Text Colors
    public var textPrimary: Color         { Color.white }
    public var textSecondary: Color       { Color.white.opacity(0.85) }
    public var textTertiary: Color        { Color.white.opacity(0.65) }
    public var textDisabled: Color        { Color.white.opacity(0.4) }
    public var textAccent: Color          { brandPrimary }
    public var textHighlight: Color       { brandSecondary }
    
    // MARK: - Effect Colors
    public var glassOverlay: Color        { brandPrimary.opacity(0.08) }
    public var glassBorder: Color         { brandPrimary.opacity(0.25) }
    public var glowPrimary: Color         { brandPrimary.opacity(0.6) }
    public var glowSecondary: Color       { brandSecondary.opacity(0.5) }
    public var glowAccent: Color          { brandTertiary.opacity(0.7) }
    public var neutralDivider: Color      { Color(hex: "#344155").opacity(0.6) }
    
    // MARK: - Shadow Colors
    public var shadowDark: Color          { Color.black.opacity(0.6) }
    public var shadowLight: Color         { brandPrimary.opacity(0.2) }
    public var shadowMedium: Color        { Color.black.opacity(0.3) }
    public var shadowDeep: Color          { Color.black.opacity(0.8) }
    
    // MARK: - Interactive State Colors
    public var interactiveIdle: Color     { brandPrimary.opacity(0.7) }
    public var interactiveHover: Color    { brandPrimary }
    public var interactivePressed: Color  { brandPrimary.opacity(0.5) }
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
    public var neutralHighlight: Color   { Color(hex: "#26C6DA").opacity(0.8) }  // Cyan highlight
    public var subtleAccent: Color       { Color(hex: "#344155") }               // Ocean subtle accent
    public var stateSpecial: Color       { Color(hex: "#1A2332") }               // Ocean special state
    public var paleGreenAccent: Color    { Color(hex: "#66BB6A").opacity(0.6) }  // Ocean green accent
    public var panelBackground: Color    { Color(hex: "#0D1421") }               // Deep navy panel
    public var controlBackground: Color  { Color(hex: "#1A2332") }               // Navy control background
} 