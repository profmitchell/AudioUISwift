//
//  ThemeApplicator.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 6/6/25.
//


import SwiftUI

@available(iOS 18.0, macOS 15.0, *)
public struct ThemeApplicator: Sendable {
    public let theme: Theme
    
    public init(theme: Theme) {
        self.theme = theme
    }
    
    // MARK: - Computed Properties
    public var dynamicColors: Look {
        theme.look
    }
    
    public var dynamicFeel: Feel {
        theme.feel
    }
    
    // MARK: - Convenience Properties with Opacity
    public var glassBorderWithOpacity: Color {
        theme.look.glassBorder
    }
    
    public var interactiveIdleWithOpacity: Color {
        theme.look.interactiveIdle
    }
    
    public var textSecondaryWithOpacity: Color {
        theme.look.textSecondary
    }
    
    public var textTertiaryWithOpacity: Color {
        theme.look.textTertiary
    }
    
    public var textDisabledWithOpacity: Color {
        theme.look.textDisabled
    }
}

// MARK: - Environment Key
@available(iOS 18.0, macOS 15.0, *)
private struct ThemeApplicatorKey: EnvironmentKey {
    static let defaultValue = ThemeApplicator(theme: .audioUI)
}

@available(iOS 18.0, macOS 15.0, *)
public extension EnvironmentValues {
    var themeApplicator: ThemeApplicator {
        get { self[ThemeApplicatorKey.self] }
        set { self[ThemeApplicatorKey.self] = newValue }
    }
}
