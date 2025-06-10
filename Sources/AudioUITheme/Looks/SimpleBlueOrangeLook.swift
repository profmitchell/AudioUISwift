//
//  SimpleBlueOrangeLook.swift
//  AudioUITheme
//
//  A minimal blue/orange theme using only 3 base colors with strategic variations
//

import SwiftUI

@available(iOS 18.0, macOS 15.0, *)
public struct SimpleBlueOrangeLook: Look {
    
    // MARK: - Base Colors (Only 3 colors!)
    private let baseBlue = Color(red: 0.2, green: 0.4, blue: 0.8)      // Blue accent
    private let baseOrange = Color(red: 1.0, green: 0.6, blue: 0.2)    // Orange accent  
    private let baseNeutral = Color(red: 0.92, green: 0.92, blue: 0.92) // Light neutral
    
    // MARK: - Core Brand Colors (blue variations)
    public var brandPrimary: Color { baseBlue }
    public var brandSecondary: Color { baseBlue.opacity(0.8) }
    public var brandTertiary: Color { baseBlue.opacity(0.6) }
    public var brandQuaternary: Color { baseBlue.opacity(0.4) }
    public var brandQuinary: Color { baseBlue.opacity(0.2) }
    
    // MARK: - State Colors (orange for active states)
    public var stateSuccess: Color { baseOrange }
    public var stateWarning: Color { baseOrange.opacity(0.8) }
    public var stateError: Color { baseOrange }
    public var stateInfo: Color { baseBlue }
    public var stateLink: Color { baseBlue }
    
    // MARK: - Background & Surface Colors (neutral base)
    public var backgroundPrimary: Color { baseNeutral }
    public var backgroundSecondary: Color { baseNeutral.opacity(0.9) }
    public var backgroundTertiary: Color { baseNeutral.opacity(0.8) }
    public var surfacePrimary: Color { baseNeutral }
    public var surfaceSecondary: Color { baseNeutral.opacity(0.95) }
    public var surfaceTertiary: Color { baseNeutral.opacity(0.9) }
    public var surface: Color { baseNeutral }
    public var surfacePressed: Color { baseNeutral.opacity(0.8) }
    public var surfaceElevated: Color { Color.white }
    public var surfaceDeep: Color { baseNeutral.opacity(0.7) }
    public var surfaceRaised: Color { Color.white }
    
    // MARK: - Text Colors (blue for text)
    public var textPrimary: Color { baseBlue }
    public var textSecondary: Color { baseBlue.opacity(0.7) }
    public var textTertiary: Color { baseBlue.opacity(0.5) }
    public var textDisabled: Color { baseBlue.opacity(0.3) }
    public var textAccent: Color { baseOrange }
    public var textHighlight: Color { baseOrange }
    
    // MARK: - Effect Colors
    public var glassOverlay: Color { baseNeutral.opacity(0.1) }
    public var glassBorder: Color { baseBlue.opacity(0.3) }
    public var glowPrimary: Color { baseOrange.opacity(0.4) }
    public var glowSecondary: Color { baseBlue.opacity(0.3) }
    public var glowAccent: Color { baseOrange.opacity(0.6) }
    public var neutralDivider: Color { baseBlue.opacity(0.2) }
    public var shadowDark: Color { baseBlue.opacity(0.2) }
    public var shadowLight: Color { Color.white.opacity(0.8) }
    public var shadowMedium: Color { baseBlue.opacity(0.15) }
    public var shadowDeep: Color { baseBlue.opacity(0.3) }
    
    // MARK: - Interactive State Colors (orange for interactions)
    public var interactiveIdle: Color { baseBlue.opacity(0.5) }
    public var interactiveHover: Color { baseOrange.opacity(0.7) }
    public var interactivePressed: Color { baseOrange.opacity(0.9) }
    public var interactiveDisabled: Color { baseBlue.opacity(0.2) }
    public var interactiveActive: Color { baseOrange }
    public var interactiveFocus: Color { baseOrange.opacity(0.8) }
    
    // MARK: - Accent Colors (orange family)
    public var accent: Color { baseOrange }
    public var accentSecondary: Color { baseOrange.opacity(0.8) }
    public var accentTertiary: Color { baseOrange.opacity(0.6) }
    
    // MARK: - Control-Specific Colors
    public var knobPrimary: Color { baseBlue }
    public var knobSecondary: Color { baseBlue.opacity(0.6) }
    public var sliderTrack: Color { baseBlue.opacity(0.3) }
    public var sliderThumb: Color { baseOrange }
    public var buttonPrimary: Color { baseNeutral }
    public var buttonSecondary: Color { baseNeutral.opacity(0.9) }
    public var padActive: Color { baseOrange }
    public var padInactive: Color { baseNeutral }
    
    // MARK: - Special Elements
    public var neutralHighlight: Color { Color.white.opacity(0.6) }
    public var subtleAccent: Color { baseOrange.opacity(0.3) }
    public var stateSpecial: Color { baseOrange }
    public var paleGreenAccent: Color { baseBlue.opacity(0.6) }
    public var panelBackground: Color { baseNeutral }
    public var controlBackground: Color { baseNeutral.opacity(0.95) }
    
    public init() {}
}
