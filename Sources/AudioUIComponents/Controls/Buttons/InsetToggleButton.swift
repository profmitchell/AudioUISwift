//
//  InsetToggleButton.swift
//  AudioUIComponentTesting
//
//  Created by Mitchell Cohen on 6/9/25.
//


import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct InsetToggleButton: View {
    @Binding var isOn: Bool
    @State private var isPressed = false
    
    @Environment(\.theme) private var theme
    
    // Enhanced theme-derived colors - utilizing rich palette
    private var baseColor: Color { theme.look.surfacePrimary }
    private var surfaceElevated: Color { theme.look.surfaceElevated }
    private var surfacePressed: Color { theme.look.surfacePressed }
    private var surfaceDeep: Color { theme.look.surfaceDeep }
    private var surfaceRaised: Color { theme.look.surfaceRaised }
    private var darkShadow: Color { theme.look.shadowDark }
    private var lightShadow: Color { theme.look.shadowLight }
    private var mediumShadow: Color { theme.look.shadowMedium }
    private var deepShadow: Color { theme.look.shadowDeep }
    private var textColor: Color { theme.look.textPrimary }
    private var textAccent: Color { theme.look.textAccent }
    private var textHighlight: Color { theme.look.textHighlight }
    private var activeColor: Color { theme.look.brandPrimary }
    private var brandSecondary: Color { theme.look.brandSecondary }
    private var brandTertiary: Color { theme.look.brandTertiary }
    private var buttonPrimary: Color { theme.look.buttonPrimary }
    private var buttonSecondary: Color { theme.look.buttonSecondary }
    private var interactiveActive: Color { theme.look.interactiveActive }
    private var interactiveIdle: Color { theme.look.interactiveIdle }
    private var interactivePressed: Color { theme.look.interactivePressed }
    private var interactiveHover: Color { theme.look.interactiveHover }
    private var accentColor: Color { theme.look.accent }
    private var accentSecondary: Color { theme.look.accentSecondary }
    private var glowPrimary: Color { theme.look.glowPrimary }
    private var glowAccent: Color { theme.look.glowAccent }
    private var neutralHighlight: Color { theme.look.neutralHighlight }
    private var glassBorder: Color { theme.look.glassBorder }
    
    let action: (Bool) -> Void
    let label: String
    
    public init(isOn: Binding<Bool>, label: String = "TOGGLE", action: @escaping (Bool) -> Void = { _ in }) {
        self._isOn = isOn
        self.label = label
        self.action = action
    }
    
    public var body: some View {
        ZStack {
            // Outer bezel - the actual button
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [
                            isPressed ? darkShadow.opacity(0.4) : lightShadow.opacity(0.7),
                            baseColor,
                            isPressed ? lightShadow.opacity(0.3) : darkShadow.opacity(0.3)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 140, height: 60)
                .shadow(
                    color: isPressed ? darkShadow.opacity(0.3) : darkShadow.opacity(0.6),
                    radius: isPressed ? 4 : 10,
                    x: isPressed ? 3 : 6,
                    y: isPressed ? 3 : 6
                )
                .shadow(
                    color: isPressed ? lightShadow.opacity(0.7) : lightShadow,
                    radius: isPressed ? 4 : 10,
                    x: isPressed ? -3 : -6,
                    y: isPressed ? -3 : -6
                )
                .overlay(
                    // Inner bevel
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    isPressed ? darkShadow.opacity(0.5) : lightShadow.opacity(0.5),
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
            
            // Active indicator
            if isOn {
                RoundedRectangle(cornerRadius: 16)
                    .fill(activeColor.opacity(0.3))
                    .frame(width: 130, height: 50)
                    .shadow(color: activeColor.opacity(0.6), radius: 8)
            }
            
            // Text label
            Text(label)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .tracking(1.5)
                .foregroundColor(isOn ? activeColor : textColor.opacity(0.7))
                .offset(y: isPressed ? 1 : 0)
        }
        .scaleEffect(isPressed ? 0.96 : 1.0)
        .animation(.spring(response: 0.12, dampingFraction: 0.7), value: isPressed)
        .animation(.easeInOut(duration: 0.2), value: isOn)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !isPressed {
                        isPressed = true
                        toggle()
                    }
                }
                .onEnded { _ in
                    isPressed = false
                }
        )
    }
    
    private func toggle() {
        isOn.toggle()
        action(isOn)
        
        #if canImport(UIKit)
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
        #endif
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct InsetToggleButton_Previews: PreviewProvider {
    @State static var isOn = false
    
    public static var previews: some View {
        InsetToggleButton(isOn: $isOn)
            .theme(.darkPro)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

