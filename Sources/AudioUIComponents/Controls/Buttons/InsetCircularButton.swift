//
//  InsetCircularButton.swift
//  AudioUIComponentTesting
//
//  Created by Mitchell Cohen on 6/9/25.
//


import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct InsetCircularButton: View {
    @State private var isPressed = false
    @State private var showRipple = false
    
    @Environment(\.theme) private var theme
    
    // Enhanced theme-derived colors - utilizing rich palette
    private var baseColor: Color {
        theme.look.surfacePrimary
    }
    
    private var darkShadow: Color {
        theme.look.shadowDark
    }
    
    private var lightShadow: Color {
        theme.look.shadowLight
    }
    
    // Additional rich color palette utilization
    private var buttonPrimary: Color { theme.look.buttonPrimary }
    private var buttonSecondary: Color { theme.look.buttonSecondary }
    private var brandPrimary: Color { theme.look.brandPrimary }
    private var brandSecondary: Color { theme.look.brandSecondary }
    private var accentColor: Color { theme.look.accent }
    private var interactiveIdle: Color { theme.look.interactiveIdle }
    private var interactiveHover: Color { theme.look.interactiveHover }
    private var interactivePressed: Color { theme.look.interactivePressed }
    private var interactiveActive: Color { theme.look.interactiveActive }
    private var glowColor: Color { theme.look.glowPrimary }
    private var highlightColor: Color { theme.look.neutralHighlight }
    private var surfaceElevated: Color { theme.look.surfaceElevated }
    private var textAccent: Color { theme.look.textAccent }
    
    private var iconColor: Color {
        theme.look.textPrimary
    }
    
    let action: () -> Void
    let icon: String
    let size: CGFloat
    
    public init(icon: String = "play.fill", size: CGFloat = 80, action: @escaping () -> Void = {}) {
        self.icon = icon
        self.size = size
        self.action = action
    }
    
    public var body: some View {
        ZStack {
            // Outer shadow ring
            Circle()
                .fill(baseColor)
                .frame(width: size, height: size)
                .shadow(
                    color: isPressed ? darkShadow.opacity(0.2) : darkShadow.opacity(0.6),
                    radius: isPressed ? 4 : 12,
                    x: isPressed ? 3 : 8,
                    y: isPressed ? 3 : 8
                )
                .shadow(
                    color: isPressed ? lightShadow.opacity(0.6) : lightShadow,
                    radius: isPressed ? 4 : 12,
                    x: isPressed ? -3 : -8,
                    y: isPressed ? -3 : -8
                )
            
            // Inner button surface
            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            isPressed ? darkShadow.opacity(0.3) : lightShadow.opacity(0.7),
                            baseColor,
                            isPressed ? lightShadow.opacity(0.3) : darkShadow.opacity(0.3)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size * 0.85, height: size * 0.85)
                .overlay(
                    Circle()
                        .stroke(
                            LinearGradient(
                                colors: [
                                    isPressed ? darkShadow.opacity(0.4) : lightShadow.opacity(0.5),
                                    Color.clear,
                                    isPressed ? lightShadow.opacity(0.4) : darkShadow.opacity(0.2)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 2
                        )
                        .blur(radius: 0.5)
                )
            
            // Ripple effect
            if showRipple {
                Circle()
                    .fill(theme.look.brandPrimary.opacity(0.3))
                    .frame(width: size * 0.4, height: size * 0.4)
                    .scaleEffect(showRipple ? 2.5 : 0)
                    .opacity(showRipple ? 0 : 1)
            }
            
            // Icon
            Image(systemName: icon)
                .font(.system(size: size * 0.25, weight: .medium))
                .foregroundColor(iconColor.opacity(0.8))
                .scaleEffect(isPressed ? 0.9 : 1.0)
        }
        .scaleEffect(isPressed ? 0.94 : 1.0)
        .animation(.spring(response: 0.12, dampingFraction: 0.7), value: isPressed)
        .animation(.easeOut(duration: 0.6), value: showRipple)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !isPressed {
                        press()
                    }
                }
                .onEnded { _ in
                    isPressed = false
                }
        )
    }
    
    private func press() {
        isPressed = true
        showRipple = true
        action()
        
        #if canImport(UIKit)
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
        #endif
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            showRipple = false
        }
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct InsetCircularButton_Previews: PreviewProvider {
    public static var previews: some View {
        InsetCircularButton {
            print("Button pressed!")
        }
        .theme(.darkPro)
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
