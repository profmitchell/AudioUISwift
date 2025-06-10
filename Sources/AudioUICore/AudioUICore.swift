// AudioUICore.swift
// AudioUI Package - Core Module
//
// Foundation primitives and utilities for audio user interfaces.
// This module contains the essential building blocks for all AudioUI components.

import SwiftUI

/// AudioUICore provides the foundation primitives for building audio user interfaces.
///
/// This module contains essential building blocks including knobs, faders, XY pads,
/// and other fundamental controls with precise gesture handling and performance optimization.
///
/// ## Core Components
///
/// - ``Knob`` - Rotary control with precise gesture handling
/// - ``Fader`` - Linear slider control for levels and parameters
/// - ``XYPad`` - Two-dimensional touch surface for spatial parameters
/// - ``PadButton`` - Velocity-sensitive trigger control
/// - ``ToggleButton`` - State-based switch control
/// - ``LED`` - Status indicator with theming support
/// - ``LevelMeter`` - Real-time audio level visualization
/// - ``GyroscopePrimitive`` - Motion-based control interface
///
/// ## Usage
///
/// ```swift
/// import AudioUICore
///
/// struct BasicMixer: View {
///     @State private var volume: Double = 0.5
///     
///     var body: some View {
///         Knob(value: $volume) { newValue in
///             audioEngine.setVolume(newValue)
///         }
///     }
/// }
/// ```
public struct AudioUICore {
    /// The current version of AudioUICore
    public static let version = "2.0.0"
    
    /// Framework information
    public static let description = "Foundation primitives for audio user interfaces"
}

// MARK: - Re-exports for convenience
// All primitives are automatically available when importing AudioUICore due to Package.swift dependencies
