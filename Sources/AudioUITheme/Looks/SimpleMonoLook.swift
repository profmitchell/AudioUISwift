//
//  SimpleMonoLook.swift
//  AudioUITheme
//
//  A minimal monochromatic theme using only 2 base colors with strategic opacity variations
//

import SwiftUI

@available(iOS 18.0, macOS 15.0, *)
public struct SimpleMonoLook: Look {
    
    // MARK: - Base Colors (Only 2 colors!)
    private let baseLight = Color(red: 0.95, green: 0.95, blue: 0.95)  // Light gray
    private let baseDark = Color(red: 0.15, green: 0.15, blue: 0.15)   // Dark gray
    
    // MARK: - Core Brand Colors (variations of base)
    public var brandPrimary: Color { baseDark }
    public var brandSecondary: Color { baseDark.opacity(0.7) }
    public var brandTertiary: Color { baseDark.opacity(0.5) }
    public var brandQuaternary: Color { baseDark.opacity(0.3) }
    public var brandQuinary: Color { baseDark.opacity(0.2) }
    
    // MARK: - State Colors (subtle variations)
    public var stateSuccess: Color { baseDark }
    public var stateWarning: Color { baseDark.opacity(0.8) }
    public var stateError: Color { baseDark }
    public var stateInfo: Color { baseDark.opacity(0.6) }
    public var stateLink: Color { baseDark }
    
    // MARK: - Background & Surface Colors
    public var backgroundPrimary: Color { baseLight }
    public var backgroundSecondary: Color { baseLight.opacity(0.9) }
    public var backgroundTertiary: Color { baseLight.opacity(0.8) }
    public var surfacePrimary: Color { baseLight }
    public var surfaceSecondary: Color { baseLight.opacity(0.95) }
    public var surfaceTertiary: Color { baseLight.opacity(0.9) }
    public var surface: Color { baseLight }
    public var surfacePressed: Color { baseLight.opacity(0.8) }
    public var surfaceElevated: Color { Color.white }
    public var surfaceDeep: Color { baseLight.opacity(0.7) }
    public var surfaceRaised: Color { Color.white }
    
    // MARK: - Text Colors
    public var textPrimary: Color { baseDark }
    public var textSecondary: Color { baseDark.opacity(0.7) }
    public var textTertiary: Color { baseDark.opacity(0.5) }
    public var textDisabled: Color { baseDark.opacity(0.3) }
    public var textAccent: Color { baseDark }
    public var textHighlight: Color { baseDark }
    
    // MARK: - Effect Colors
    public var glassOverlay: Color { baseLight.opacity(0.1) }
    public var glassBorder: Color { baseDark.opacity(0.2) }
    public var glowPrimary: Color { baseDark.opacity(0.3) }
    public var glowSecondary: Color { baseDark.opacity(0.2) }
    public var glowAccent: Color { baseDark.opacity(0.4) }
    public var neutralDivider: Color { baseDark.opacity(0.2) }
    public var shadowDark: Color { baseDark.opacity(0.3) }
    public var shadowLight: Color { Color.white.opacity(0.8) }
    public var shadowMedium: Color { baseDark.opacity(0.2) }
    public var shadowDeep: Color { baseDark.opacity(0.4) }
    
    // MARK: - Interactive State Colors
    public var interactiveIdle: Color { baseDark.opacity(0.5) }
    public var interactiveHover: Color { baseDark.opacity(0.7) }
    public var interactivePressed: Color { baseDark.opacity(0.9) }
    public var interactiveDisabled: Color { baseDark.opacity(0.2) }
    public var interactiveActive: Color { baseDark }
    public var interactiveFocus: Color { baseDark.opacity(0.8) }
    
    // MARK: - Accent Colors
    public var accent: Color { baseDark }
    public var accentSecondary: Color { baseDark.opacity(0.7) }
    public var accentTertiary: Color { baseDark.opacity(0.5) }
    
    // MARK: - Control-Specific Colors
    public var knobPrimary: Color { baseDark }
    public var knobSecondary: Color { baseDark.opacity(0.6) }
    public var sliderTrack: Color { baseDark.opacity(0.3) }
    public var sliderThumb: Color { baseDark }
    public var buttonPrimary: Color { baseLight }
    public var buttonSecondary: Color { baseLight.opacity(0.9) }
    public var padActive: Color { baseDark }
    public var padInactive: Color { baseLight }
    
    // MARK: - Special Elements
    public var neutralHighlight: Color { Color.white.opacity(0.5) }
    public var subtleAccent: Color { baseDark.opacity(0.3) }
    public var stateSpecial: Color { baseDark }
    public var paleGreenAccent: Color { baseDark.opacity(0.6) }
    public var panelBackground: Color { baseLight }
    public var controlBackground: Color { baseLight.opacity(0.95) }
    
    public init() {}
}
