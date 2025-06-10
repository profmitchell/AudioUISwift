// DrumPads.swift
// AudioUI Package - Drum Pad Components
//
// Production-ready drum pad components with minimal and neumorphic design styles

import SwiftUI

// MARK: - Drum Pad Component Exports

// Minimal Style Drum Pads
// - DrumPadMinimal1: Ultra-clean pad with tap animation
// - DrumPadMinimal2: Dot matrix pad with expanding animation
// - DrumPadMinimal3: Geometric pad with ring animation

// Neumorphic Style Drum Pads  
// - DrumPadNeumorphic1: Rubber pad with realistic depth
// - DrumPadNeumorphic2: Circular pad with color accents
// - DrumPadNeumorphic3: Square pad with corner details

// MARK: - Drum Pad Collections

/// Collection of all available drum pad styles
public enum AudioUIDrumPadStyle {
    case minimal1
    case minimal2
    case minimal3
    case neumorphic1
    case neumorphic2
    case neumorphic3
}

/// Drum pad design philosophy
public enum AudioUIDrumPadDesign {
    case minimal
    case neumorphic
} 