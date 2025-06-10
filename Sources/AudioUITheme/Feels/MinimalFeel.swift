//
//  MinimalFeel.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 6/6/25.
//


import SwiftUI

@available(iOS 18.0, macOS 15.0, *)
public struct MinimalFeel: Feel, Sendable {
    public init() {}
    
    public let cornerRadius: CGFloat = 8
    public let borderWidth: CGFloat = 1
    public let shadowRadius: CGFloat = 0
    public let shadowOpacity: Double = 0
    public let glowIntensity: Double = 0
    public let blurRadius: CGFloat = 0
    public let animationDuration: Double = 0.2
    public var animationCurve: Animation { Animation.easeInOut(duration: animationDuration) }
    
    public func applyToContainer<Content: View>(_ content: Content, look: Look) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(look.backgroundPrimary.opacity(0.8))
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(look.glassBorder, lineWidth: borderWidth)
                    )
            )
    }
    
    public func applyToButton<Content: View>(_ content: Content, look: Look, isPressed: Bool) -> some View {
        content
            .scaleEffect(isPressed ? 0.98 : 1.0)
            .opacity(isPressed ? 0.9 : 1.0)
            .animation(animationCurve, value: isPressed)
    }
    
    public func applyToInteractive<Content: View>(_ content: Content, look: Look, isActive: Bool) -> some View {
        content
            .foregroundColor(isActive ? look.interactiveHover : look.interactiveIdle)
            .animation(animationCurve, value: isActive)
    }
}
