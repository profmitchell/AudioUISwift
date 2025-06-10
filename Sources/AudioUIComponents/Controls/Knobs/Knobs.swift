// Knobs.swift
// AudioUI Package - Knob Components
//
// Production-ready knob components with minimal and neumorphic design styles

import SwiftUI

// MARK: - Knob Component Exports

// Minimal Style Knobs
// - KnobMinimal1: Vertical fill knob with clean design
// - KnobMinimal2: Segmented knob with discrete steps  
// - KnobMinimal3: Dot pattern knob with concentric rings
// - KnobMinimal4: Orbital knob with smooth tracking

// Neumorphic Style Knobs
// - InsetNeumorphicKnob: Inset style with value indicators
// - InsetRotaryKnob: Rotary style with grip ridges
// - UltraMinimalNeumorphicKnob: Ultra-clean neumorphic design

// MARK: - Knob Collections

/// Collection of all available knob styles
public enum AudioUIKnobStyle {
    case minimal1
    case minimal2
    case minimal3
    case minimal4
    case insetNeumorphic
    case insetRotary
    case ultraMinimalNeumorphic
}

/// Knob design philosophy
public enum AudioUIKnobDesign {
    case minimal
    case neumorphic
}

/// Knob interaction style
public enum AudioUIKnobInteraction {
    case vertical   // Drag up/down
    case rotary     // Circular rotation
    case hybrid     // Both styles supported
} 