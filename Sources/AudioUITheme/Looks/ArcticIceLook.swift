//
//  ArcticIceLook.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 12/23/25.
//

import SwiftUI

// MARK: - Arctic Ice Look
@available(iOS 18.0, macOS 15.0, *)
public struct ArcticIceLook: Look, Sendable {
    public init() {}
    
    // MARK: - Arctic Brand Colors (Ice & Crystal)
    public var brandPrimary: Color      { Color(hex: "4FC3F7") }    // Glacier Blue
    public var brandSecondary: Color    { Color(hex: "81D4FA") }    // Ice Blue
    public var brandTertiary: Color     { Color(hex: "B3E5FC") }    // Crystal Blue
    public var brandQuaternary: Color   { Color(hex: "E1F5FE") }    // Frost White
    public var brandQuinary: Color      { Color(hex: "29B6F6") }    // Deep Ice
    
    // MARK: - State Colors
    public var stateSuccess: Color      { Color(hex: "4DD0E1") }    // Ice Success
    public var stateWarning: Color      { Color(hex: "FFE082") }    // Arctic Sun
    public var stateError: Color        { Color(hex: "F48FB1") }    // Aurora Pink
    public var stateInfo: Color         { Color(hex: "81D4FA") }    // Ice Info
    public var stateLink: Color         { Color(hex: "4FC3F7") }    // Ice Link
    
    // MARK: - Background Colors (Frozen Depths)
    public var backgroundPrimary: Color   { Color(hex: "0A1929") }  // Deep Arctic Night
    public var backgroundSecondary: Color { Color(hex: "132F4C") }  // Ice Shadow
    public var backgroundTertiary: Color  { Color(hex: "1E3A5F") }  // Glacier Base
    public var surfacePrimary: Color      { Color(hex: "1A2027") }  // Ice Surface
    public var surfaceSecondary: Color    { Color(hex: "1C2833") }  // Frost Surface
    public var surfaceTertiary: Color     { Color(hex: "21344A") }  // Crystal Surface
    
    // MARK: - Surface Variations
    public var surface: Color               { Color(hex: "1A2027") }
    public var surfacePressed: Color        { Color(hex: "0A1929") }
    public var surfaceElevated: Color       { Color(hex: "21344A") }
    public var surfaceDeep: Color           { Color(hex: "051922") }
    public var surfaceRaised: Color         { Color(hex: "2A3F5F") }
    
    // MARK: - Text Colors
    public var textPrimary: Color         { Color(hex: "F8FAFC") }  // Snow White
    public var textSecondary: Color       { Color(hex: "E2E8F0") }  // Ice White
    public var textTertiary: Color        { Color(hex: "CBD5E1") }  // Frost Gray
    public var textDisabled: Color        { Color(hex: "64748B") }  // Ice Gray
    public var textAccent: Color          { brandPrimary }
    public var textHighlight: Color       { Color(hex: "81D4FA") }
    
    // MARK: - Effect Colors (Crystal & Aurora)
    public var glassOverlay: Color        { Color(hex: "4FC3F7").opacity(0.12) }
    public var glassBorder: Color         { Color(hex: "81D4FA").opacity(0.4) }
    public var glowPrimary: Color         { Color(hex: "4FC3F7").opacity(0.8) }
    public var glowSecondary: Color       { Color(hex: "81D4FA").opacity(0.6) }
    public var glowAccent: Color          { Color(hex: "B3E5FC").opacity(0.9) }
    public var neutralDivider: Color      { Color(hex: "334155") }
    
    // MARK: - Shadow Colors (Ice Shadows)
    public var shadowDark: Color          { Color.black.opacity(0.8) }
    public var shadowLight: Color         { Color(hex: "81D4FA").opacity(0.15) }
    public var shadowMedium: Color        { Color(hex: "1E293B").opacity(0.7) }
    public var shadowDeep: Color          { Color(hex: "020617") }
    
    // MARK: - Interactive State Colors
    public var interactiveIdle: Color     { Color(hex: "4FC3F7").opacity(0.7) }
    public var interactiveHover: Color    { Color(hex: "29B6F6") }
    public var interactivePressed: Color  { Color(hex: "0288D1") }
    public var interactiveDisabled: Color { Color(hex: "475569") }
    public var interactiveActive: Color   { brandPrimary }
    public var interactiveFocus: Color    { brandSecondary }
    
    // MARK: - Accent Colors
    public var accent: Color             { brandPrimary }
    public var accentSecondary: Color    { brandSecondary }
    public var accentTertiary: Color     { brandTertiary }
    
    // MARK: - Control-specific Colors
    public var knobPrimary: Color        { Color(hex: "475569") }   // Ice Stone
    public var knobSecondary: Color      { Color(hex: "334155") }   // Dark Ice
    public var sliderTrack: Color        { surfaceSecondary }
    public var sliderThumb: Color        { brandPrimary }
    public var buttonPrimary: Color      { brandSecondary }
    public var buttonSecondary: Color    { brandTertiary }
    public var padActive: Color          { Color(hex: "29B6F6") }   // Active Ice
    public var padInactive: Color        { surfacePrimary }
    
    // MARK: - Special Elements
    public var neutralHighlight: Color   { Color(hex: "E1F5FE").opacity(0.9) }   // Crystal highlight
    public var subtleAccent: Color       { Color(hex: "21344A") }                // Subtle ice
    public var stateSpecial: Color       { Color(hex: "40C4FF") }                // Electric ice
    public var paleGreenAccent: Color    { Color(hex: "80DEEA").opacity(0.5) }  // Pale ice accent
    public var panelBackground: Color    { Color(hex: "051922") }                // Deep ice panel
    public var controlBackground: Color  { Color(hex: "0A1929") }                // Control ice
} 