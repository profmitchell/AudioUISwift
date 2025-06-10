//
//  Look.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 6/6/25.
//


import SwiftUI

@available(iOS 18.0, macOS 15.0, *)
public protocol Look: Sendable {
    // Brand Colors
    var brandPrimary: Color { get }
    var brandSecondary: Color { get }
    var brandTertiary: Color { get }
    var brandQuaternary: Color { get }
    var brandQuinary: Color { get }
    
    // State Colors
    var stateSuccess: Color { get }
    var stateWarning: Color { get }
    var stateError: Color { get }
    var stateInfo: Color { get }
    var stateLink: Color { get }
    
    // Background Colors
    var backgroundPrimary: Color { get }
    var backgroundSecondary: Color { get }
    var backgroundTertiary: Color { get }
    var surfacePrimary: Color { get }
    var surfaceSecondary: Color { get }
    var surfaceTertiary: Color { get }
    
    // Additional surface variations for neumorphic design
    var surface: Color { get }
    var surfacePressed: Color { get }
    var surfaceElevated: Color { get }
    var surfaceDeep: Color { get }
    var surfaceRaised: Color { get }
    
    // Text Colors
    var textPrimary: Color { get }
    var textSecondary: Color { get }
    var textTertiary: Color { get }
    var textDisabled: Color { get }
    var textAccent: Color { get }
    var textHighlight: Color { get }
    
    // Effect Colors
    var glassOverlay: Color { get }
    var glassBorder: Color { get }
    var glowPrimary: Color { get }
    var glowSecondary: Color { get }
    var glowAccent: Color { get }
    var neutralDivider: Color { get }
    
    // Shadow Colors
    var shadowDark: Color { get }
    var shadowLight: Color { get }
    var shadowMedium: Color { get }
    var shadowDeep: Color { get }
    
    // Interactive State Colors
    var interactiveIdle: Color { get }
    var interactiveHover: Color { get }
    var interactivePressed: Color { get }
    var interactiveDisabled: Color { get }
    var interactiveActive: Color { get }
    var interactiveFocus: Color { get }
    
    // Accent colors for knobs and controls
    var accent: Color { get }
    var accentSecondary: Color { get }
    var accentTertiary: Color { get }
    
    // Control-specific colors
    var knobPrimary: Color { get }
    var knobSecondary: Color { get }
    var sliderTrack: Color { get }
    var sliderThumb: Color { get }
    var buttonPrimary: Color { get }
    var buttonSecondary: Color { get }
    var padActive: Color { get }
    var padInactive: Color { get }
    
    // Special Elements (for backward compatibility and extended theming)
    var neutralHighlight: Color { get }
    var subtleAccent: Color { get }
    var stateSpecial: Color { get }
    var paleGreenAccent: Color { get }
    var panelBackground: Color { get }
    var controlBackground: Color { get }
}
