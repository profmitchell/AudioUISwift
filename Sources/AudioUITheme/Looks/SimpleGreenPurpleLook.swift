//
//  SimpleGreenPurpleLook.swift
//  AudioUITheme
//
//  A minimal green/purple theme using only 3 base colors with strategic variations
//

import SwiftUI

@available(iOS 18.0, macOS 15.0, *)
public struct SimpleGreenPurpleLook: Look {
    
    // MARK: - Base Colors (Only 3 colors!)
    private let baseGreen = Color(red: 0.2, green: 0.8, blue: 0.4)     // Green accent
    private let basePurple = Color(red: 0.6, green: 0.3, blue: 0.8)    // Purple accent
    private let baseLight = Color(red: 0.96, green: 0.96, blue: 0.96)  // Very light neutral
    
    // MARK: - Core Brand Colors (green variations)
    public var brandPrimary: Color { baseGreen }
    public var brandSecondary: Color { baseGreen.opacity(0.8) }
    public var brandTertiary: Color { baseGreen.opacity(0.6) }
    public var brandQuaternary: Color { baseGreen.opacity(0.4) }
    public var brandQuinary: Color { baseGreen.opacity(0.2) }
    
    // MARK: - State Colors (purple for states)
    public var stateSuccess: Color { baseGreen }
    public var stateWarning: Color { basePurple.opacity(0.8) }
    public var stateError: Color { basePurple }
    public var stateInfo: Color { baseGreen.opacity(0.7) }
    public var stateLink: Color { baseGreen }
    
    // MARK: - Background & Surface Colors (light base)
    public var backgroundPrimary: Color { baseLight }
    public var backgroundSecondary: Color { baseLight.opacity(0.95) }
    public var backgroundTertiary: Color { baseLight.opacity(0.9) }
    public var surfacePrimary: Color { baseLight }
    public var surfaceSecondary: Color { baseLight.opacity(0.98) }
    public var surfaceTertiary: Color { baseLight.opacity(0.95) }
    public var surface: Color { baseLight }
    public var surfacePressed: Color { baseLight.opacity(0.85) }
    public var surfaceElevated: Color { Color.white }
    public var surfaceDeep: Color { baseLight.opacity(0.8) }
    public var surfaceRaised: Color { Color.white }
    
    // MARK: - Text Colors (green primary, purple accents)
    public var textPrimary: Color { baseGreen }
    public var textSecondary: Color { baseGreen.opacity(0.7) }
    public var textTertiary: Color { baseGreen.opacity(0.5) }
    public var textDisabled: Color { baseGreen.opacity(0.3) }
    public var textAccent: Color { basePurple }
    public var textHighlight: Color { basePurple }
    
    // MARK: - Effect Colors
    public var glassOverlay: Color { baseLight.opacity(0.1) }
    public var glassBorder: Color { baseGreen.opacity(0.3) }
    public var glowPrimary: Color { basePurple.opacity(0.4) }
    public var glowSecondary: Color { baseGreen.opacity(0.3) }
    public var glowAccent: Color { basePurple.opacity(0.6) }
    public var neutralDivider: Color { baseGreen.opacity(0.2) }
    public var shadowDark: Color { baseGreen.opacity(0.2) }
    public var shadowLight: Color { Color.white.opacity(0.9) }
    public var shadowMedium: Color { baseGreen.opacity(0.15) }
    public var shadowDeep: Color { baseGreen.opacity(0.3) }
    
    // MARK: - Interactive State Colors (purple for interactions)
    public var interactiveIdle: Color { baseGreen.opacity(0.5) }
    public var interactiveHover: Color { basePurple.opacity(0.7) }
    public var interactivePressed: Color { basePurple.opacity(0.9) }
    public var interactiveDisabled: Color { baseGreen.opacity(0.2) }
    public var interactiveActive: Color { basePurple }
    public var interactiveFocus: Color { basePurple.opacity(0.8) }
    
    // MARK: - Accent Colors (purple family)
    public var accent: Color { basePurple }
    public var accentSecondary: Color { basePurple.opacity(0.8) }
    public var accentTertiary: Color { basePurple.opacity(0.6) }
    
    // MARK: - Control-Specific Colors
    public var knobPrimary: Color { baseGreen }
    public var knobSecondary: Color { baseGreen.opacity(0.6) }
    public var sliderTrack: Color { baseGreen.opacity(0.3) }
    public var sliderThumb: Color { basePurple }
    public var buttonPrimary: Color { baseLight }
    public var buttonSecondary: Color { baseLight.opacity(0.95) }
    public var padActive: Color { basePurple }
    public var padInactive: Color { baseLight }
    
    // MARK: - Special Elements
    public var neutralHighlight: Color { Color.white.opacity(0.7) }
    public var subtleAccent: Color { basePurple.opacity(0.3) }
    public var stateSpecial: Color { basePurple }
    public var paleGreenAccent: Color { baseGreen.opacity(0.4) }
    public var panelBackground: Color { baseLight }
    public var controlBackground: Color { baseLight.opacity(0.98) }
    
    public init() {}
}
