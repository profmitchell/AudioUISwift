//
//  DrumPadNeumorphic2.swift
//  AudioUIComponentTesting
//
//  Created by Mitchell Cohen on 6/9/25.
//


import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct DrumPadNeumorphic2: View {
    @State private var isPressed = false
    @State private var padDepth: CGFloat = 0
    @State private var impactScale: CGFloat = 1.0
    
    @Environment(\.theme) private var theme
    
    // Theme-derived colors with enhanced variety
    private var baseColor: Color {
        theme.look.surfacePrimary
    }
    
    private var deepBaseColor: Color {
        theme.look.surfaceDeep
    }
    
    private var raisedColor: Color {
        theme.look.surfaceRaised
    }
    
    private var darkShadow: Color {
        theme.look.shadowDeep
    }
    
    private var lightShadow: Color {
        theme.look.shadowLight
    }
    
    private var mediumShadow: Color {
        theme.look.shadowMedium
    }
    
    private var textColor: Color {
        theme.look.textPrimary
    }
    
    private var accentTextColor: Color {
        theme.look.textAccent
    }
    
    private var highlightColor: Color {
        theme.look.textHighlight
    }
    
    private var glowColor: Color {
        theme.look.glowAccent
    }
    
    public let label: String?
    public let color: Color?
    public let size: CGFloat
    public let action: (() -> Void)?
    
    public init(
        label: String? = nil,
        color: Color? = nil,
        size: CGFloat = 120,
        action: (() -> Void)? = nil
    ) {
        self.label = label
        self.color = color
        self.size = size
        self.action = action
    }
    
    private var padColor: Color {
        color ?? theme.look.padActive
    }
    
    private var inactiveColor: Color {
        theme.look.padInactive
    }
    
    public var body: some View {
        VStack(spacing: 12) {
            Text(label ?? "")
                .font(.system(size: 11, weight: .medium, design: .rounded))
                .tracking(1.2)
                .foregroundColor(isPressed ? highlightColor : accentTextColor)
                .animation(.easeInOut(duration: 0.2), value: isPressed)

            ZStack {
                // Circular pad well with enhanced depth
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                darkShadow.opacity(0.6),
                                deepBaseColor.opacity(0.8),
                                baseColor.opacity(0.7),
                                lightShadow.opacity(0.3)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: size, height: size)
                    .overlay(
                        Circle()
                            .stroke(darkShadow.opacity(0.7), lineWidth: 4)
                            .blur(radius: 4)
                            .offset(x: 4, y: 4)
                    )
                    .overlay(
                        Circle()
                            .stroke(lightShadow.opacity(0.8), lineWidth: 4)
                            .blur(radius: 4)
                            .offset(x: -4, y: -4)
                    )
                    .overlay(
                        Circle()
                            .stroke(mediumShadow.opacity(0.3), lineWidth: 1)
                            .blur(radius: 1)
                    )

                // Pad surface with enhanced materials
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                isPressed ? deepBaseColor : raisedColor.opacity(0.2),
                                isPressed ? baseColor.opacity(0.8) : baseColor,
                                isPressed ? inactiveColor.opacity(0.9) : raisedColor.opacity(0.95),
                                padColor.opacity(0.1)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: size - 20, height: size - 20)
                    .overlay(
                        // Enhanced ring detail with glow
                        Circle()
                            .strokeBorder(
                                LinearGradient(
                                    colors: [
                                        glowColor.opacity(0.4),
                                        mediumShadow.opacity(0.2),
                                        lightShadow.opacity(0.3),
                                        glowColor.opacity(0.6)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 3
                            )
                            .frame(width: size - 40, height: size - 40)
                    )
                    .shadow(
                        color: isPressed ? darkShadow.opacity(0.3) : darkShadow.opacity(0.8),
                        radius: isPressed ? 3 : 10,
                        x: isPressed ? 2 : 6,
                        y: isPressed ? 2 : 6
                    )
                    .shadow(
                        color: isPressed ? lightShadow.opacity(0.8) : lightShadow,
                        radius: isPressed ? 3 : 10,
                        x: isPressed ? -2 : -6,
                        y: isPressed ? -2 : -6
                    )
                    .shadow(
                        color: glowColor.opacity(isPressed ? 0.8 : 0.4),
                        radius: isPressed ? 8 : 12,
                        x: 0,
                        y: 0
                    )
                    .offset(y: padDepth)

                // Enhanced center indicator with multiple colors
                ZStack {
                    Circle()
                        .fill(padColor.opacity(0.4))
                        .frame(width: 16, height: 16)
                    
                    Circle()
                        .fill(glowColor.opacity(0.6))
                        .frame(width: 8, height: 8)
                        .blur(radius: isPressed ? 3 : 1)
                    
                    Circle()
                        .fill(highlightColor.opacity(isPressed ? 0.9 : 0.3))
                        .frame(width: 4, height: 4)
                }
                .offset(y: padDepth)
                .scaleEffect(isPressed ? 1.2 : 1.0)
                .animation(.spring(response: 0.2, dampingFraction: 0.8), value: isPressed)
            }
            .scaleEffect(isPressed ? 0.94 : 1.0)
            .animation(.spring(response: 0.08, dampingFraction: 0.7), value: isPressed)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !isPressed {
                            triggerPad()
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.easeOut(duration: 0.15)) {
                            isPressed = false
                            padDepth = 0
                        }
                    }
            )
        }
        .frame(width: size + 40, height: size + 40) // Extra space for centering
    }
    
    private func triggerPad() {
        withAnimation(.easeOut(duration: 0.05)) {
            isPressed = true
            padDepth = 8
            impactScale = 0.92
        }
        
        action?()
        
        #if canImport(UIKit)
        let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
        impactFeedback.impactOccurred()
        #endif
    }
}

// Self-contained preview
@available(iOS 18.0, macOS 15.0, *)
public struct DrumPadNeumorphic2_Previews: PreviewProvider {
    public static var previews: some View {
        HStack(spacing: 20) {
            DrumPadNeumorphic2(label: "TOM", color: Color.orange.opacity(0.8)) {
                print("Tom hit!")
            }
            DrumPadNeumorphic2(label: "CLAP", color: Color.purple.opacity(0.8)) {
                print("Clap hit!")
            }
            VStack(spacing: 15) {
                DrumPadNeumorphic2(label: "CRASH", color: Color.yellow.opacity(0.8)) {
                    print("Crash hit!")
                }
                DrumPadNeumorphic2(label: "RIDE", color: Color.green.opacity(0.8)) {
                    print("Ride hit!")
                }
            }
        }
        .theme(.audioUINeumorphic)
        .padding(40)
        .previewLayout(.sizeThatFits)
    }
}
