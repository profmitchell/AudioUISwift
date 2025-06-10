//
//  ThemedContainer.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 6/6/25.
//


import SwiftUI

@available(iOS 18.0, macOS 15.0, *)
public struct ThemedContainer: ViewModifier {
    @Environment(\.theme) var theme
    
    public func body(content: Content) -> some View {
        AnyView(theme.feel.applyToContainer(content, look: theme.look))
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct ThemedButton: ViewModifier {
    @Environment(\.theme) var theme
    let isPressed: Bool
    
    public func body(content: Content) -> some View {
        AnyView(theme.feel.applyToButton(content, look: theme.look, isPressed: isPressed))
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct ThemedInteractive: ViewModifier {
    @Environment(\.theme) var theme
    let isActive: Bool
    
    public func body(content: Content) -> some View {
        AnyView(theme.feel.applyToInteractive(content, look: theme.look, isActive: isActive))
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct ThemedSurface: ViewModifier {
    @Environment(\.theme) var theme
    let style: SurfaceStyle
    
    public enum SurfaceStyle {
        case primary, secondary, elevated, pressed
    }
    
    public func body(content: Content) -> some View {
        content
            .background(surfaceColor)
            .foregroundColor(theme.look.textPrimary)
    }
    
    private var surfaceColor: Color {
        switch style {
        case .primary: return theme.look.surface
        case .secondary: return theme.look.surfaceSecondary
        case .elevated: return theme.look.surfaceElevated
        case .pressed: return theme.look.surfacePressed
        }
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct ThemedText: ViewModifier {
    @Environment(\.theme) var theme
    let style: TextStyle
    
    public enum TextStyle {
        case primary, secondary, tertiary, disabled
    }
    
    public func body(content: Content) -> some View {
        content
            .foregroundColor(textColor)
    }
    
    private var textColor: Color {
        switch style {
        case .primary: return theme.look.textPrimary
        case .secondary: return theme.look.textSecondary
        case .tertiary: return theme.look.textTertiary
        case .disabled: return theme.look.textDisabled
        }
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct ThemedAccent: ViewModifier {
    @Environment(\.theme) var theme
    let isPrimary: Bool
    
    public func body(content: Content) -> some View {
        content
            .foregroundColor(isPrimary ? theme.look.accent : theme.look.accentSecondary)
    }
}

// MARK: - View Extensions
public extension View {
    @available(iOS 18.0, macOS 15.0, *)
    func themedContainer() -> some View {
        modifier(ThemedContainer())
    }
    
    @available(iOS 18.0, macOS 15.0, *)
    func themedButton(isPressed: Bool) -> some View {
        modifier(ThemedButton(isPressed: isPressed))
    }
    
    @available(iOS 18.0, macOS 15.0, *)
    func themedInteractive(isActive: Bool) -> some View {
        modifier(ThemedInteractive(isActive: isActive))
    }
    
    @available(iOS 18.0, macOS 15.0, *)
    func themedSurface(_ style: ThemedSurface.SurfaceStyle = .primary) -> some View {
        modifier(ThemedSurface(style: style))
    }
    
    @available(iOS 18.0, macOS 15.0, *)
    func themedText(_ style: ThemedText.TextStyle = .primary) -> some View {
        modifier(ThemedText(style: style))
    }
    
    @available(iOS 18.0, macOS 15.0, *)
    func themedAccent(isPrimary: Bool = true) -> some View {
        modifier(ThemedAccent(isPrimary: isPrimary))
    }
}
