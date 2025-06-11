//
//  DuneDesertLook.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 12/23/25.
//

import SwiftUI

// MARK: - Dune Desert Look
@available(iOS 18.0, macOS 15.0, *)
public struct DuneDesertLook: Look, Sendable {
    public init() {}
    
    // MARK: - Dune Brand Colors (Spice & Desert)
    public var brandPrimary: Color      { Color(hex: "D32F2F") }    // Deep Spice Red
    public var brandSecondary: Color    { Color(hex: "FF6E40") }    // Sunset Orange
    public var brandTertiary: Color     { Color(hex: "FF8A50") }    // Desert Sand Orange
    public var brandQuaternary: Color   { Color(hex: "FFB74D") }    // Hot Sand
    public var brandQuinary: Color      { Color(hex: "FFA726") }    // Burning Orange
    
    // MARK: - State Colors
    public var stateSuccess: Color      { Color(hex: "FF8A50") }    // Desert Success
    public var stateWarning: Color      { Color(hex: "FFB74D") }    // Hot Warning
    public var stateError: Color        { Color(hex: "B71C1C") }    // Blood Red Error
    public var stateInfo: Color         { Color(hex: "FF6E40") }    // Sunset Info
    public var stateLink: Color         { Color(hex: "FF8A50") }    // Sand Link
    
    // MARK: - Background Colors (Deep Space & Shadow)
    public var backgroundPrimary: Color   { Color(hex: "0D0D0D") }  // Deep Space Black
    public var backgroundSecondary: Color { Color(hex: "1A0E0E") }  // Dark Red-Black
    public var backgroundTertiary: Color  { Color(hex: "261414") }  // Shadow Red
    public var surfacePrimary: Color      { Color(hex: "2B1818") }  // Dark Desert Night
    public var surfaceSecondary: Color    { Color(hex: "3D2020") }  // Midnight Sand
    public var surfaceTertiary: Color     { Color(hex: "4A2626") }  // Dune Shadow
    
    // MARK: - Surface Variations
    public var surface: Color               { Color(hex: "2B1818") }
    public var surfacePressed: Color        { Color(hex: "1A0E0E") }
    public var surfaceElevated: Color       { Color(hex: "3D2020") }
    public var surfaceDeep: Color           { Color(hex: "0D0D0D") }
    public var surfaceRaised: Color         { Color(hex: "4A2626") }
    
    // MARK: - Text Colors
    public var textPrimary: Color         { Color(hex: "FFE0B2") }  // Sand Text
    public var textSecondary: Color       { Color(hex: "FFCCBC") }  // Light Sand
    public var textTertiary: Color        { Color(hex: "FFAB91") }  // Dusty Text
    public var textDisabled: Color        { Color(hex: "8D6E63") }  // Faded Sand
    public var textAccent: Color          { brandPrimary }
    public var textHighlight: Color       { Color(hex: "FF6E40") }
    
    // MARK: - Effect Colors (Heat & Spice Glow)
    public var glassOverlay: Color        { Color(hex: "FF6E40").opacity(0.08) }
    public var glassBorder: Color         { Color(hex: "FF8A50").opacity(0.3) }
    public var glowPrimary: Color         { Color(hex: "D32F2F").opacity(0.7) }
    public var glowSecondary: Color       { Color(hex: "FF6E40").opacity(0.5) }
    public var glowAccent: Color          { Color(hex: "FF8A50").opacity(0.8) }
    public var neutralDivider: Color      { Color(hex: "5D4037") }
    
    // MARK: - Shadow Colors (Desert Shadows)
    public var shadowDark: Color          { Color.black.opacity(0.9) }
    public var shadowLight: Color         { Color(hex: "FF6E40").opacity(0.1) }
    public var shadowMedium: Color        { Color(hex: "3E2723").opacity(0.6) }
    public var shadowDeep: Color          { Color.black }
    
    // MARK: - Interactive State Colors
    public var interactiveIdle: Color     { Color(hex: "FF8A50").opacity(0.8) }
    public var interactiveHover: Color    { Color(hex: "FF6E40") }
    public var interactivePressed: Color  { Color(hex: "D32F2F") }
    public var interactiveDisabled: Color { Color(hex: "5D4037") }
    public var interactiveActive: Color   { brandPrimary }
    public var interactiveFocus: Color    { brandSecondary }
    
    // MARK: - Accent Colors
    public var accent: Color             { brandPrimary }
    public var accentSecondary: Color    { brandSecondary }
    public var accentTertiary: Color     { brandTertiary }
    
    // MARK: - Control-specific Colors
    public var knobPrimary: Color        { Color(hex: "8D6E63") }   // Desert Stone
    public var knobSecondary: Color      { Color(hex: "6D4C41") }   // Dark Stone
    public var sliderTrack: Color        { surfaceSecondary }
    public var sliderThumb: Color        { brandPrimary }
    public var buttonPrimary: Color      { brandSecondary }
    public var buttonSecondary: Color    { brandTertiary }
    public var padActive: Color          { Color(hex: "FF5722") }   // Burning Hot
    public var padInactive: Color        { surfacePrimary }
    
    // MARK: - Special Elements
    public var neutralHighlight: Color   { Color(hex: "FFB74D").opacity(0.8) }   // Hot Sand highlight
    public var subtleAccent: Color       { Color(hex: "4A2626") }                // Subtle desert shadow
    public var stateSpecial: Color       { Color(hex: "E64A19") }                // Spice orange special
    public var paleGreenAccent: Color    { Color(hex: "FF8A65").opacity(0.4) }  // Pale desert accent
    public var panelBackground: Color    { Color(hex: "0D0D0D") }                // Deep space panel
    public var controlBackground: Color  { Color(hex: "1A0E0E") }                // Control shadow
}
