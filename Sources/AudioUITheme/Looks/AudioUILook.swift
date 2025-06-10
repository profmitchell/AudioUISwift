import SwiftUI

@available(iOS 18.0, macOS 15.0, *)
public struct AudioUILook: Look, Sendable {
    public init() {}
    
    // MARK: - Core Brand Colors
    public var brandPrimary: Color      { Color(hex: "#AFCBEB") }    // Light Sky
    public var brandSecondary: Color    { Color(hex: "#E7B1B0") }    // Pale Blush
    public var brandTertiary: Color     { Color(hex: "#C8D4C8") }    // Pale Sage
    public var brandQuaternary: Color   { Color(hex: "#D8A8B8") }    // Soft Pink
    public var brandQuinary: Color      { Color(hex: "#B8D8C8") }    // Soft Mint
    
    // MARK: - State Colors
    public var stateSuccess: Color      { Color(hex: "#87A8C4") }    // Soft Blue
    public var stateWarning: Color      { Color(hex: "#C69A98") }    // Dusty Rose
    public var stateError: Color        { Color(hex: "#8F7A79") }    // Warm Taupe
    public var stateInfo: Color         { Color(hex: "#AFCBEB") }    // Light Sky
    public var stateLink: Color         { Color(hex: "#87A8C4") }    // Soft Blue
    
    // MARK: - Background Colors
    public var backgroundPrimary: Color   { Color(hex: "#4E6578") }  // Muted Indigo
    public var backgroundSecondary: Color { Color(hex: "#6B8AA3") }  // Slate Blue
    public var backgroundTertiary: Color  { Color(hex: "#5A7A8E") }  // Medium Blue Gray
    public var surfacePrimary: Color      { Color(hex: "#87A8C4") }  // Soft Blue
    public var surfaceSecondary: Color    { Color(hex: "#AFCBEB") }  // Light Sky
    public var surfaceTertiary: Color     { Color(hex: "#9BC0D9") }  // Mid Sky
    
    // MARK: - Additional Surface Variations for Neumorphic Design
    public var surface: Color               { Color(hex: "#87A8C4") }      // Base surface
    public var surfacePressed: Color        { Color(hex: "#6B8AA3") }      // Pressed state
    public var surfaceElevated: Color       { Color(hex: "#AFCBEB") }      // Elevated elements
    public var surfaceDeep: Color           { Color(hex: "#4E6578") }      // Deep inset
    public var surfaceRaised: Color         { Color(hex: "#C8D4C8") }      // Raised elements
    
    // MARK: - Text Colors
    public var textPrimary: Color         { Color.white }
    public var textSecondary: Color       { Color.white.opacity(0.85) }
    public var textTertiary: Color        { Color.white.opacity(0.8) }
    public var textDisabled: Color        { Color.white.opacity(0.6) }
    public var textAccent: Color          { brandPrimary }
    public var textHighlight: Color       { brandSecondary }
    
    // MARK: - Effect Colors
    public var glassOverlay: Color        { brandPrimary.opacity(0.1) }
    public var glassBorder: Color         { brandPrimary.opacity(0.2) }
    public var glowPrimary: Color         { brandPrimary.opacity(0.6) }
    public var glowSecondary: Color       { brandSecondary.opacity(0.5) }
    public var glowAccent: Color          { brandTertiary.opacity(0.7) }
    public var neutralDivider: Color      { Color(hex: "#8F7A79") }    // Warm Taupe
    
    // MARK: - Shadow Colors
    public var shadowDark: Color          { Color.black.opacity(0.3) }
    public var shadowLight: Color         { Color.white.opacity(0.8) }
    public var shadowMedium: Color        { Color.black.opacity(0.15) }
    public var shadowDeep: Color          { Color.black.opacity(0.5) }
    
    // MARK: - Interactive State Colors
    public var interactiveIdle: Color     { brandPrimary.opacity(0.8) }
    public var interactiveHover: Color    { brandPrimary }
    public var interactivePressed: Color  { brandPrimary.opacity(0.6) }
    public var interactiveDisabled: Color { Color(hex: "#8F7A79").opacity(0.5) }
    public var interactiveActive: Color   { brandSecondary }
    public var interactiveFocus: Color    { brandTertiary }
    
    // MARK: - Accent Colors for Knobs and Controls
    public var accent: Color             { brandPrimary }                  // Primary accent
    public var accentSecondary: Color    { brandSecondary }               // Secondary accent
    public var accentTertiary: Color     { brandTertiary }                // Tertiary accent
    
    // MARK: - Control-specific Colors
    public var knobPrimary: Color        { brandQuaternary }              // Knob primary
    public var knobSecondary: Color      { brandQuinary }                 // Knob secondary
    public var sliderTrack: Color        { surfaceSecondary }             // Slider track
    public var sliderThumb: Color        { brandPrimary }                 // Slider thumb
    public var buttonPrimary: Color      { brandSecondary }               // Button primary
    public var buttonSecondary: Color    { brandTertiary }                // Button secondary
    public var padActive: Color          { brandPrimary }                 // Active pad
    public var padInactive: Color        { surfacePrimary }               // Inactive pad
    
    // MARK: - Special Elements (maintaining backward compatibility)
    public var neutralHighlight: Color  { Color(hex: "#AFCBEB") }    // Light Sky
    public var subtleAccent: Color      { Color(hex: "#6B8AA3") }    // Slate Blue
    public var stateSpecial: Color      { Color(hex: "#4E6578") }    // Muted Indigo
    public var paleGreenAccent: Color   { Color(hex: "#B8C8B8") }    // Very pale green
    public var panelBackground: Color   { Color(hex: "#4E6578") }    // Muted Indigo
    public var controlBackground: Color { Color(hex: "#6B8AA3") }    // Slate Blue
}
