// AudioUI.swift
// AudioUI Package - Comprehensive Audio User Interface Framework
//
// This is the main umbrella module that provides convenient access to the entire framework.
// When you import AudioUI, all sub-modules are automatically available.

import SwiftUI

// Re-export all sub-modules
@_exported import AudioUICore
@_exported import AudioUITheme
@_exported import AudioUIComponents
@_exported import AudioUIMetalFX

// Export all AudioUIComponents public APIs, including the new premium components
@_exported import AudioUIComponents

// MARK: - Framework Information

public struct AudioUI {
    /// The current version of the AudioUI framework
    public static let version = "2.0.0"
    
    /// Framework information
    public static let description = "Unified framework for audio user interfaces"
    
    /// Detailed information about the AudioUI framework
    public static var info: String {
        """
        AudioUI v\(version)
        A comprehensive SwiftUI framework for professional audio interfaces
        
        Modules:
        • AudioUICore: Foundation primitives and utilities
        • AudioUITheme: Theming system with Looks and Feels
        • AudioUIComponents: Ready-to-use UI components
        • AudioUIMetalFX: GPU-accelerated effects and visualizations
        
        Usage:
        import AudioUI  // Imports all modules
        
        Or import individually:
        import AudioUICore
        import AudioUITheme
        import AudioUIComponents
        import AudioUIMetalFX
        """
    }
}
