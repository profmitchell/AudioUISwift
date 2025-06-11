// Gyroscopes.swift
// AudioUI Package - Gyroscope Components
//
// Production-ready motion sensing components with real-time device orientation

import SwiftUI

// MARK: - Gyroscope Component Exports

// Gyroscope Styles Available:
// - GyroMinimal: Clean motion display with orbit indicators
// - GyroDotted1: Dot matrix motion visualization with pattern effects
// - GyroNeumorphic1: 3D neumorphic sphere with realistic depth visualization

// Components are directly available when importing AudioUIComponents
// Use: GyroMinimal, GyroDotted1, GyroNeumorphic1

// MARK: - Gyroscope Collections

/// Collection of all available gyroscope styles
public enum AudioUIGyroscopeStyle {
    case minimal
    case dotted
    case neumorphic
}

/// Gyroscope design philosophy
public enum AudioUIGyroscopeDesign {
    case minimal
    case dotted
    case neumorphic
    case advanced
}

/// Motion data types
public enum AudioUIMotionData {
    case pitch
    case yaw
    case roll
    case combined
} 