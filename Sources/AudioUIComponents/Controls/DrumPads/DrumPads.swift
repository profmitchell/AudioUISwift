// DrumPads.swift
// AudioUI Package - Drum Pad Components
//
// Production-ready drum pad components with minimal, dotted, and neumorphic design styles

import SwiftUI

// MARK: - Drum Pad Component Exports

// Available Drum Pad Styles:
// - DrumPadMinimal1: Ultra-clean pad with tap animation
// - DrumPadDotted1: Dot matrix pad with expanding animation
// - DrumPadNeumorphic1: Rubber pad with realistic depth

// MARK: - Drum Pad Collections

/// Collection of all available drum pad styles
public enum AudioUIDrumPadStyle {
    case minimal1
    case dotted1
    case neumorphic1
}

/// Drum pad design philosophy
public enum AudioUIDrumPadDesign {
    case minimal
    case dotted
    case neumorphic
} 