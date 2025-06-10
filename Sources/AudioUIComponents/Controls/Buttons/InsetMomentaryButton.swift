//
//  InsetMomentaryButton.swift
//  AudioUIComponentTesting
//
//  Created by Mitchell Cohen on 6/9/25.
//


import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct InsetMomentaryButton: View {
    @State private var isPressed = false
    
    @Environment(\.theme) private var theme
    
    // Enhanced theme-derived colors - utilizing rich palette
    private var baseColor: Color {
        theme.look.surfacePrimary
    }
    
    private var surfaceElevated: Color {
        theme.look.surfaceElevated
    }
    
    private var surfacePressed: Color {
        theme.look.surfacePressed
    }
    
    private var darkShadow: Color {
        theme.look.shadowDark
    }
    
    private var lightShadow: Color {
        theme.look.shadowLight
    }
    
    private var mediumShadow: Color {
        theme.look.shadowMedium
    }
    
    private var deepShadow: Color {
        theme.look.shadowDeep
    }
    
    private var textColor: Color {
        theme.look.textPrimary
    }
    
    private var buttonPrimary: Color {
        theme.look.buttonPrimary
    }
    
    private var buttonSecondary: Color {
        theme.look.buttonSecondary
    }
    
    private var brandPrimary: Color {
        theme.look.brandPrimary
    }
    
    private var brandSecondary: Color {
        theme.look.brandSecondary
    }
    
    private var interactiveIdle: Color {
        theme.look.interactiveIdle
    }
    
    private var interactivePressed: Color {
        theme.look.interactivePressed
    }
    
    private var interactiveHover: Color {
        theme.look.interactiveHover
    }
    
    private var accentColor: Color {
        theme.look.accent
    }
    
    private var glowPrimary: Color {
        theme.look.glowPrimary
    }
    
    private var neutralHighlight: Color {
        theme.look.neutralHighlight
    }
    
    private var glassBorder: Color {
        theme.look.glassBorder
    }
    
    let action: () -> Void
    let label: String
    
    public init(label: String = "SEND", action: @escaping () -> Void = {}) {
        self.label = label
        self.action = action
    }
    
    public var body: some View {
        ZStack {
            // Outer frame with more subtle gradient
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [baseColor, baseColor.opacity(0.98), baseColor.opacity(0.96)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 140, height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(glassBorder.opacity(0.3), lineWidth: 1)
                )
                .shadow(color: lightShadow, radius: 8, x: -4, y: -4)
                .shadow(color: darkShadow.opacity(0.4), radius: 8, x: 4, y: 4)
                .shadow(color: deepShadow.opacity(0.2), radius: 20, x: 0, y: 8)
            
            // Inner button surface
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    isPressed ? 
                    LinearGradient(
                        colors: [interactivePressed, buttonSecondary],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ) :
                    LinearGradient(
                        colors: [buttonPrimary, buttonSecondary, brandPrimary.opacity(0.1)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 130, height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(
                            LinearGradient(
                                colors: [neutralHighlight.opacity(0.5), accentColor.opacity(0.3)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
                .shadow(color: mediumShadow.opacity(0.3), radius: 3, x: 0, y: isPressed ? 1 : 3)
            
            // Glow effect when pressed
            if isPressed {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(glowPrimary, lineWidth: 2)
                    .frame(width: 130, height: 50)
                    .blur(radius: 4)
                    .opacity(0.8)
            }
            
            // Text label with enhanced styling
            Text(label)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .tracking(1.5)
                .foregroundStyle(
                    LinearGradient(
                        colors: [textColor, brandSecondary.opacity(0.8)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: darkShadow.opacity(0.5), radius: 1, x: 0, y: 1)
                .offset(y: isPressed ? 1 : 0)
        }
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .animation(.spring(response: 0.15, dampingFraction: 0.7), value: isPressed)
        .onTapGesture {
            // Momentary press
            isPressed = true
            action()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPressed = false
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !isPressed {
                        isPressed = true
                        action()
                    }
                }
                .onEnded { _ in
                    isPressed = false
                }
        )
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct InsetMomentaryButton_Previews: PreviewProvider {
    public static var previews: some View {
        InsetMomentaryButton(label: "SEND") {
            print("Button pressed")
        }
        .theme(.darkPro)
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

