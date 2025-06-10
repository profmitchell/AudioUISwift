// AudioUITheme.swift
// AudioUI Package - Theme Module
//
// Comprehensive theming system that separates visual appearance (Looks) 
// from interaction styles (Feels).

import SwiftUI

/// AudioUITheme provides a flexible theming system for audio user interfaces.
///
/// This module implements a sophisticated theming architecture that separates visual design (Looks)
/// from interaction behavior (Feels), allowing for highly customizable and consistent UI experiences.
///
/// ## Theming Architecture
///
/// - ``Look`` - Visual styling protocol defining colors, gradients, shadows, and typography
/// - ``Feel`` - Interaction behavior protocol defining animation styles and responsiveness
/// - ``Theme`` - Complete theme combining Look and Feel
/// - ``ThemeApplicator`` - Environment integration for theme application
///
/// ## Built-in Themes
///

/// - ``Theme/audioUINeumorphic`` - Soft UI styling with depth and realistic shadows
/// - ``Theme/darkPro`` - Professional dark theme for studio environments

/// - ``Theme/ocean`` - Cool blue tones with flowing gradients

///
/// ## Usage
///
/// ```swift
/// import AudioUITheme
///
/// struct ThemedInterface: View {
///     var body: some View {
///         VStack {
///             // Your audio controls here
///         }
///         .theme(.darkPro)  // Apply professional dark theme
///     }
/// }
/// ```
///
/// ## Custom Themes
///
/// ```swift
/// let customTheme = Theme(
///     look: CustomLook(
///         primaryColor: .purple,
///         accentColor: .pink
///     ),
///     feel: NeumorphicFeel()
/// )
/// ```
public struct AudioUITheme {
    /// The current version of AudioUITheme
    public static let version = "2.0.0"
    
    /// Framework information
    public static let description = "Advanced theming system for audio interfaces"
}

// MARK: - Re-exports for convenience
// All theme system components are automatically available when importing AudioUITheme due to Package.swift dependencies
