// XYPads.swift
// AudioUI Package - XY Pad Components
//
// Production-ready XY pad components for 2D parameter control

import SwiftUI

// MARK: - XY Pad Component Exports

// Minimal Style XY Pads
// - XYPadMinimal1: Clean crosshair design with grid lines and position indicator

// Dotted Style XY Pads  
// - XYPadDotted1: Dot matrix design with ripple effects and proximity lighting

// Neumorphic Style XY Pads
// - XYPadNeumorphic1: Elevated neumorphic design with soft shadows and ripple effects

// MARK: - XY Pad Collections

/// Collection of all available XY pad styles
public enum AudioUIXYPadStyle {
    case minimal1
    case dotted1
    case neumorphic1
}

/// XY pad design philosophy
public enum AudioUIXYPadDesign {
    case minimal
    case dotted
    case neumorphic
}

/// XY pad interaction features
public enum AudioUIXYPadFeature {
    case crosshair      // Visual guides
    case ripples        // Touch feedback effects
    case grid           // Background grid
    case dots           // Dot matrix pattern
    case neumorphic     // Soft shadow effects
    case proximity      // Distance-based lighting
} 