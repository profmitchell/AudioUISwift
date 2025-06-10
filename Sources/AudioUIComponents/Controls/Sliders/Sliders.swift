// Sliders.swift
// AudioUI Package - Slider Components
//
// Production-ready slider components with minimal and neumorphic design styles

import SwiftUI

// MARK: - Slider Component Exports

// Minimal Style Sliders
// - SliderMinimal1: Circular slider with clean design
// - SliderMinimal2: Stepped blocks slider with discrete values
// - SliderMinimal3: Vertical slider with notches  
// - SliderMinimal4: Dot matrix slider with density visualization
// - SliderMinimal5: Floating handle slider with layers

// Neumorphic Style Sliders
// - InsetHorizontalFader: Horizontal fader with inset design
// - SliderNeumorphic2: Enhanced neumorphic slider with tooltip
// - VerticalInsetSlider: Vertical slider with fill meter
// - VerticalNeumorphicFader: Classic vertical fader design

// MARK: - Slider Collections

/// Collection of all available slider styles
public enum AudioUISliderStyle {
    case minimal1
    case minimal2
    case minimal3
    case minimal4
    case minimal5
    case insetHorizontalFader
    case neumorphic2
    case verticalInset
    case verticalNeumorphicFader
}

/// Slider orientation
public enum AudioUISliderOrientation {
    case horizontal
    case vertical
    case circular
}

/// Slider design philosophy
public enum AudioUISliderDesign {
    case minimal
    case neumorphic
} 