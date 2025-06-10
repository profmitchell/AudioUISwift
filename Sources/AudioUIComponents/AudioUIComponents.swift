// AudioUIComponents.swift
// AudioUI Package - Components Module
//
// Production-ready, themed UI components that combine AudioUICore primitives
// with stunning visual design and real-world audio functionality.

import SwiftUI
import AudioUICore
import AudioUITheme

// MARK: - Module Information

public struct AudioUIComponents {
    /// The current version of AudioUIComponents
    public static let version = "2.0.0"
    
    /// Framework information
    public static let description = "Production-ready audio interface components"
}

// MARK: - Component Categories

/// All available component categories in AudioUIComponents
public enum AudioUIComponentCategory {
    case buttons
    case drumPads
    case gyroscopes
    case knobs
    case sliders
    case xyPads
    case displays
    case groups
}

/// Design philosophies available across all components
public enum AudioUIDesignPhilosophy {
    case minimal        // Clean, simple, geometric designs
    case neumorphic     // Soft, tactile, depth-based designs
    case advanced       // Complex, feature-rich designs
}

// MARK: - Component Collections

/// Quick access to component style counts
public struct AudioUIComponentInventory {
    public static let buttonStyles = 3
    public static let drumPadStyles = 6
    public static let gyroscopeStyles = 5
    public static let knobStyles = 7
    public static let sliderStyles = 9
    public static let xyPadStyles = 2
    
    public static let totalComponents = buttonStyles + drumPadStyles + gyroscopeStyles + knobStyles + sliderStyles + xyPadStyles
}

// MARK: - Quick Component Access

/// Provides easy access to component recommendations based on use case
public struct AudioUIQuickAccess {
    
    /// Recommended components for different audio applications
    public enum AudioApplication {
        case mixer
        case synthesizer
        case effectsProcessor
        case drumMachine
        case motionController
        case xyController
    }
    
    /// Get recommended components for a specific audio application
    public static func recommendedComponents(for application: AudioApplication) -> [String] {
        switch application {
        case .mixer:
            return ["VerticalInsetSlider", "InsetHorizontalFader", "InsetToggleButton"]
        case .synthesizer:
            return ["InsetRotaryKnob", "KnobMinimal2", "InsetNeumorphicKnob"]
        case .effectsProcessor:
            return ["SliderNeumorphic2", "UltraMinimalNeumorphicKnob", "InsetMomentaryButton"]
        case .drumMachine:
            return ["DrumPadNeumorphic1", "DrumPadMinimal2", "DrumPadNeumorphic3"]
        case .motionController:
            return ["GyroNeumorphic4", "OrientationDiagram", "GyroMinimal"]
        case .xyController:
            return ["NeumorphicXYPad", "XYPadMinimal1"]
        }
    }
}

// MARK: - Re-exports for convenience
// All components are automatically available when importing AudioUIComponents
