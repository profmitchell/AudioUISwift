// Sliders.swift
// AudioUI Package - Slider Components
//
// Production-ready slider components with minimal, dotted, and neumorphic design styles

import SwiftUI

// MARK: - Slider Component Exports

// Available Slider Styles:
// - SliderMinimal1: Stepped blocks slider with discrete values
// - SliderDotted1: Dot matrix slider with density visualization
// - SliderNeumorphic1: Enhanced neumorphic slider with tactile feedback

// MARK: - Slider Collections

/// Collection of all available slider styles
public enum AudioUISliderStyle {
    case minimal1
    case dotted1
    case neumorphic1
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
    case dotted
    case neumorphic
} 