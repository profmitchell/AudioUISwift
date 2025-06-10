// XYPads.swift
// AudioUI Package - XY Pad Components
//
// Production-ready XY pad components for 2D parameter control

import SwiftUI

// MARK: - XY Pad Component Exports

// Minimal Style XY Pads
// - XYPadMinimal1: Clean crosshair design with position indicator

// Neumorphic Style XY Pads
// - NeumorphicXYPad: Advanced pad with ripple effects and reactive background

// MARK: - XY Pad Collections

/// Collection of all available XY pad styles
public enum AudioUIXYPadStyle {
    case minimal1
    case neumorphic
}

/// XY pad design philosophy
public enum AudioUIXYPadDesign {
    case minimal
    case neumorphic
}

/// XY pad interaction features
public enum AudioUIXYPadFeature {
    case crosshair      // Visual guides
    case ripples        // Touch feedback effects
    case grid           // Background grid
    case reactive       // Dynamic background response
} 