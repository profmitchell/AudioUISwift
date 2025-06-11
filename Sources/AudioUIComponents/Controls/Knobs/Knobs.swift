// Knobs.swift
// AudioUI Package - Knob Components
//
// Production-ready knob components with minimal, dotted, and neumorphic design styles

import SwiftUI

// MARK: - Knob Component Exports

// Available Knob Styles:
// - KnobMinimal1: Vertical fill knob with clean design
// - KnobDotted1: Dot pattern knob with concentric rings
// - KnobNeumorphic1: Ultra-clean neumorphic design

// MARK: - Knob Collections

/// Collection of all available knob styles
public enum AudioUIKnobStyle {
    case minimal1
    case dotted1
    case neumorphic1
}

/// Knob design philosophy
public enum AudioUIKnobDesign {
    case minimal
    case dotted
    case neumorphic
}

/// Knob interaction style
public enum AudioUIKnobInteraction {
    case vertical   // Drag up/down
    case rotary     // Circular rotation
    case hybrid     // Both styles supported
} 