//
//  InsetNeumorphicKnob.swift
//  MIDIUITesting
//
//  Created by Mitchell Cohen on 6/2/25.
//


import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct InsetNeumorphicKnob: View {
    @Binding var value: Double
    @State private var isDragging = false
    @State private var dragStartValue: Double = 0
    
    @Environment(\.theme) private var theme
    
    // Enhanced theme-derived colors - utilizing rich palette
    private var baseColor: Color { theme.look.surfacePrimary }
    private var darkShadow: Color { theme.look.shadowDark }
    private var lightShadow: Color { theme.look.shadowLight }
    private var accentColor: Color { theme.look.brandPrimary }
    private var textColor: Color { theme.look.textSecondary }
    
    // Additional rich color palette utilization
    private var surfaceElevated: Color { theme.look.surfaceElevated }
    private var surfaceDeep: Color { theme.look.surfaceDeep }
    private var brandSecondary: Color { theme.look.brandSecondary }
    private var accent: Color { theme.look.accent }
    private var glowPrimary: Color { theme.look.glowPrimary }
    private var shadowMedium: Color { theme.look.shadowMedium }
    private var interactiveHover: Color { theme.look.interactiveHover }
    private var interactivePressed: Color { theme.look.interactivePressed }
    private var neutralHighlight: Color { theme.look.neutralHighlight }
    private var textPrimary: Color { theme.look.textPrimary }
    
    public init(value: Binding<Double>) {
        self._value = value
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Text("NEUMORPHIC - INSET")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(textColor)
                .tracking(1.5)
            
            Text("\(Int(value * 100))%")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(theme.look.textPrimary)
            
            ZStack {
                // Recessed base
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                baseColor.opacity(0.7),
                                baseColor
                            ],
                            startPoint: .bottomTrailing,
                            endPoint: .topLeading
                        )
                    )
                    .frame(width: 130, height: 130)
                    .overlay(
                        Circle()
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        darkShadow.opacity(0.15),
                                        lightShadow.opacity(0.9)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 3
                            )
                    )
                    .shadow(color: darkShadow.opacity(0.2), radius: 5, x: -3, y: -3)
                    .shadow(color: lightShadow.opacity(0.9), radius: 5, x: 3, y: 3)
                
                // Value indicators - enhanced dots with better alignment
                ForEach(0..<12) { i in
                    Circle()
                        .fill(value > Double(i) / 12.0 ? 
                              interactiveHover : 
                              neutralHighlight.opacity(0.3))
                        .frame(width: 7, height: 7)
                        .shadow(
                            color: value > Double(i) / 12.0 ? 
                                   glowPrimary.opacity(0.6) : 
                                   shadowMedium.opacity(0.2),
                            radius: value > Double(i) / 12.0 ? 3 : 1,
                            x: 0,
                            y: 0
                        )
                        .offset(y: -52)
                        .rotationEffect(.degrees(Double(i) * 30 - 135))
                        .animation(.easeOut(duration: 0.2), value: value)
                }
                
                // Raised knob
                Circle()
                    .fill(baseColor)
                    .frame(width: 80, height: 80)
                    .shadow(color: lightShadow.opacity(0.95), radius: 6, x: -5, y: -5)
                    .shadow(color: darkShadow.opacity(0.25), radius: 6, x: 5, y: 5)
                    .overlay(
                        // Inner detail
                        Circle()
                            .fill(
                                RadialGradient(
                                    colors: [
                                        baseColor.opacity(0.9),
                                        baseColor
                                    ],
                                    center: .center,
                                    startRadius: 0,
                                    endRadius: 40
                                )
                            )
                            .frame(width: 70, height: 70)
                    )
                
                // Center grip
                ForEach(0..<6) { i in
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    darkShadow.opacity(0.1),
                                    lightShadow.opacity(0.2)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: 2, height: 20)
                        .rotationEffect(.degrees(Double(i) * 60))
                }
                
                // Value display
                if isDragging {
                    Text("\(Int(value * 100))%")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(textColor.opacity(0.6))
                        .transition(.opacity)
                }
            }
            .animation(.spring(response: 0.4), value: isDragging)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { drag in
                        if !isDragging {
                            withAnimation {
                                isDragging = true
                            }
                            dragStartValue = value
                        }
                        let delta = -drag.translation.height * 0.005
                        value = min(max(dragStartValue + delta, 0), 1)
                    }
                    .onEnded { _ in 
                        withAnimation {
                            isDragging = false
                        }
                    }
            )
        }
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct InsetNeumorphicKnob_Previews: PreviewProvider {
    @State static var value: Double = 0.5
    
    public static var previews: some View {
        InsetNeumorphicKnob(value: $value)
            .theme(.audioUINeumorphic)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
