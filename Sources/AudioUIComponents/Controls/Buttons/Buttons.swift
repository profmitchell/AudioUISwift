// Buttons.swift
// AudioUI Package - Button Components
//
// Production-ready button components with neumorphic and minimal design styles

import SwiftUI

// MARK: - Button Component Exports

// All button components are automatically available when importing AudioUIComponents
// Individual imports can be done as needed:
//
// Button Styles Available:
// - InsetCircularButton: Circular neumorphic button with icon support
// - InsetMomentaryButton: Momentary press button with tactile feedback  
// - InsetToggleButton: Toggle state button with visual feedback

// Components are directly available when importing AudioUIComponents
// Use: InsetCircularButton, InsetMomentaryButton, InsetToggleButton

// MARK: - Button Collections

/// Collection of all available button styles
public enum AudioUIButtonStyle {
    case circular
    case momentary  
    case toggle
} 