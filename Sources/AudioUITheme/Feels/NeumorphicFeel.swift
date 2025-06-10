//
//  NeumorphicFeel.swift
//  AudioUI-Theme
//
//  Created by Mitchell Cohen on 6/6/25.
//


import SwiftUI

@available(iOS 18.0, macOS 15.0, *)
public struct NeumorphicFeel: Feel, Sendable {
    public init() {}
    
    public let cornerRadius: CGFloat = 16
    public let borderWidth: CGFloat = 0
    public let shadowRadius: CGFloat = 15
    public let shadowOpacity: Double = 0.3
    public let glowIntensity: Double = 0.6
    public let blurRadius: CGFloat = 10
    public let animationDuration: Double = 0.35
    public let animationCurve = Animation.spring(response: 0.4, dampingFraction: 0.7)
    
    public func applyToContainer<Content: View>(_ content: Content, look: Look) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(
                        LinearGradient(
                            colors: [
                                look.surfacePrimary.opacity(0.9),
                                look.surfaceSecondary.opacity(0.7)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(
                        color: look.backgroundPrimary.opacity(shadowOpacity),
                        radius: shadowRadius,
                        x: -5,
                        y: -5
                    )
                    .shadow(
                        color: look.backgroundSecondary.opacity(shadowOpacity),
                        radius: shadowRadius,
                        x: 5,
                        y: 5
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        LinearGradient(
                            colors: [
                                look.glassBorder.opacity(0.6),
                                look.glassBorder.opacity(0.2)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
    }
    
    public func applyToButton<Content: View>(_ content: Content, look: Look, isPressed: Bool) -> some View {
        content
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .brightness(isPressed ? -0.05 : 0)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius * 0.5)
                    .fill(
                        isPressed ?
                        look.glowPrimary.opacity(glowIntensity * 0.3) :
                        Color.clear
                    )
                    .blur(radius: blurRadius)
            )
            .animation(animationCurve, value: isPressed)
    }
    
    public func applyToInteractive<Content: View>(_ content: Content, look: Look, isActive: Bool) -> some View {
        content
            .foregroundColor(isActive ? look.interactiveHover : look.interactiveIdle)
            .shadow(
                color: isActive ? look.glowPrimary : Color.clear,
                radius: isActive ? 8 : 0
            )
            .animation(animationCurve, value: isActive)
    }
}
