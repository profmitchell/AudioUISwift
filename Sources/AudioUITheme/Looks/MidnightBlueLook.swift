//
//  MidnightBlueLook.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 12/23/25.
//

import SwiftUI

// MARK: - Midnight Blue Look
@available(iOS 18.0, macOS 15.0, *)
public struct MidnightBlueLook: Look, Sendable {
    public init() {}
    
    // MARK: - Midnight Blue Brand Colors (Deep Navy & Sapphire)
    public var brandPrimary: Color      { Color(hex: "1E3A8A") }    // Deep Navy
    public var brandSecondary: Color    { Color(hex: "3B82F6") }    // Royal Blue
    public var brandTertiary: Color     { Color(hex: "60A5FA") }    // Sky Blue
    public var brandQuaternary: Color   { Color(hex: "93C5FD") }    // Light Blue
    public var brandQuinary: Color      { Color(hex: "1E40AF") }    // Midnight Blue
    
    // MARK: - State Colors
    public var stateSuccess: Color      { Color(hex: "10B981") }    // Emerald Success
    public var stateWarning: Color      { Color(hex: "F59E0B") }    // Amber Warning
    public var stateError: Color        { Color(hex: "EF4444") }    // Red Error
    public var stateInfo: Color         { Color(hex: "3B82F6") }    // Blue Info
    public var stateLink: Color         { Color(hex: "60A5FA") }    // Sky Blue Link
    
    // MARK: - Background Colors (Deep Night)
    public var backgroundPrimary: Color   { Color(hex: "0F172A") }  // Slate 900
    public var backgroundSecondary: Color { Color(hex: "1E293B") }  // Slate 800
    public var backgroundTertiary: Color  { Color(hex: "334155") }  // Slate 700
    public var surfacePrimary: Color      { Color(hex: "1E293B") }  // Slate 800
    public var surfaceSecondary: Color    { Color(hex: "334155") }  // Slate 700
    public var surfaceTertiary: Color     { Color(hex: "475569") }  // Slate 600
    
    // MARK: - Surface Variations
    public var surface: Color               { Color(hex: "1E293B") }
    public var surfacePressed: Color        { Color(hex: "0F172A") }
    public var surfaceElevated: Color       { Color(hex: "334155") }
    public var surfaceDeep: Color           { Color(hex: "020617") }
    public var surfaceRaised: Color         { Color(hex: "475569") }
    
    // MARK: - Text Colors
    public var textPrimary: Color         { Color(hex: "F8FAFC") }  // Slate 50
    public var textSecondary: Color       { Color(hex: "E2E8F0") }  // Slate 200
    public var textTertiary: Color        { Color(hex: "CBD5E1") }  // Slate 300
    public var textDisabled: Color        { Color(hex: "64748B") }  // Slate 500
    public var textAccent: Color          { brandPrimary }
    public var textHighlight: Color       { Color(hex: "60A5FA") }
    
    // MARK: - Effect Colors (Midnight Glow)
    public var glassOverlay: Color        { Color(hex: "1E3A8A").opacity(0.1) }
    public var glassBorder: Color         { Color(hex: "3B82F6").opacity(0.4) }
    public var glowPrimary: Color         { Color(hex: "1E3A8A").opacity(0.8) }
    public var glowSecondary: Color       { Color(hex: "3B82F6").opacity(0.6) }
    public var glowAccent: Color          { Color(hex: "60A5FA").opacity(0.7) }
    public var neutralDivider: Color      { Color(hex: "475569") }
    
    // MARK: - Shadow Colors (Deep Shadows)
    public var shadowDark: Color          { Color.black.opacity(0.8) }
    public var shadowLight: Color         { Color(hex: "3B82F6").opacity(0.15) }
    public var shadowMedium: Color        { Color(hex: "334155").opacity(0.7) }
    public var shadowDeep: Color          { Color(hex: "000000") }
    
    // MARK: - Interactive State Colors
    public var interactiveIdle: Color     { Color(hex: "1E3A8A").opacity(0.8) }
    public var interactiveHover: Color    { Color(hex: "1E40AF") }
    public var interactivePressed: Color  { Color(hex: "1D4ED8") }
    public var interactiveDisabled: Color { Color(hex: "64748B") }
    public var interactiveActive: Color   { brandPrimary }
    public var interactiveFocus: Color    { brandSecondary }
    
    // MARK: - Accent Colors
    public var accent: Color             { brandPrimary }
    public var accentSecondary: Color    { brandSecondary }
    public var accentTertiary: Color     { brandTertiary }
    
    // MARK: - Control-specific Colors
    public var knobPrimary: Color        { Color(hex: "64748B") }   // Slate knob
    public var knobSecondary: Color      { Color(hex: "475569") }   // Dark slate
    public var sliderTrack: Color        { surfaceSecondary }
    public var sliderThumb: Color        { brandPrimary }
    public var buttonPrimary: Color      { brandSecondary }
    public var buttonSecondary: Color    { brandTertiary }
    public var padActive: Color          { Color(hex: "1D4ED8") }   // Active Blue
    public var padInactive: Color        { surfacePrimary }
    
    // MARK: - Special Elements
    public var neutralHighlight: Color   { Color(hex: "93C5FD").opacity(0.8) }   // Light blue highlight
    public var subtleAccent: Color       { Color(hex: "334155") }                // Subtle slate
    public var stateSpecial: Color       { Color(hex: "2563EB") }                // Blue 600 special
    public var paleGreenAccent: Color    { Color(hex: "DBEAFE").opacity(0.3) }  // Pale blue accent
    public var panelBackground: Color    { Color(hex: "020617") }                // Deep panel
    public var controlBackground: Color  { Color(hex: "0F172A") }                // Control background
} 