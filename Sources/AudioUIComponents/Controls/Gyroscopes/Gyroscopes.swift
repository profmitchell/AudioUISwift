// Gyroscopes.swift
// AudioUI Package - Gyroscope Components
//
// Production-ready motion sensing components with real-time device orientation

import SwiftUI

// MARK: - Gyroscope Component Exports

// Minimal Style Gyroscopes
// - GyroMinimal: Clean motion display with orbit indicators
// - GyroMinimal1: Crosshair style with simple visualization
// - GyroMinimal2: Ring-based orientation display

// Neumorphic Style Gyroscopes  
// - GyroNeumorphic4: 3D sphere visualization with data cards

// Advanced Gyroscope Components
// - OrientationDiagram: Enhanced 3D gimbal visualization (from GyroscopeView.swift)

// MARK: - Gyroscope Collections

/// Collection of all available gyroscope styles
public enum AudioUIGyroscopeStyle {
    case minimal
    case minimal1
    case minimal2
    case neumorphic4
    case orientationDiagram
}

/// Gyroscope design philosophy
public enum AudioUIGyroscopeDesign {
    case minimal
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