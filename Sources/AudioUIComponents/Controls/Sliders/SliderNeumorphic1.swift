//
//  SliderNeumorphic1.swift
//  AudioUI
//
//  Created by Mitchell Cohen on 6/3/25.
//

import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct SliderNeumorphic1: View {
    @Binding var value: Double
    @State private var isDragging = false
    @State private var showTooltip = false
    
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
    private var interactiveActive: Color { theme.look.interactiveActive }
    private var neutralHighlight: Color { theme.look.neutralHighlight }
    
    private let sliderWidth: CGFloat = 280
    
    public init(value: Binding<Double>) {
        self._value = value
    }
    
    public var body: some View {
        VStack(spacing: 40) {
            // Title card
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(baseColor)
                    .frame(width: 120, height: 40)
                    .shadow(color: darkShadow.opacity(0.4), radius: 5, x: 3, y: 3)
                    .shadow(color: lightShadow.opacity(0.9), radius: 5, x: -3, y: -3)
                
                Text("VOLUME")
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .tracking(1.5)
                    .foregroundColor(textColor)
            }
            
            // Slider well
            ZStack(alignment: .leading) {
                // Inset container
                RoundedRectangle(cornerRadius: 30)
                    .fill(
                        LinearGradient(
                            colors: [
                                darkShadow.opacity(0.15),
                                baseColor
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: sliderWidth, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(lightShadow.opacity(0.8), lineWidth: 2)
                            .blur(radius: 1)
                            .offset(x: -1, y: -1)
                            .mask(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.white, Color.clear],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                            )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(darkShadow.opacity(0.3), lineWidth: 2)
                            .blur(radius: 1)
                            .offset(x: 1, y: 1)
                            .mask(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.clear, Color.white],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                            )
                    )
                
                // Progress fill meter - aligned with thumb center
                let thumbWidth: CGFloat = 90
                let availableTrackWidth = sliderWidth - thumbWidth
                let thumbOffset = availableTrackWidth * value
                
                HStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(
                            LinearGradient(
                                colors: [
                                    accentColor.opacity(0.2),
                                    accentColor.opacity(0.4),
                                    accentColor.opacity(0.3)
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: max(0, thumbOffset + thumbWidth/2), height: 40)
                        .overlay(
                            // Inner glow effect
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(
                                    LinearGradient(
                                        colors: [
                                            accentColor.opacity(0.6),
                                            accentColor.opacity(0.2)
                                        ],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    ),
                                    lineWidth: 1
                                )
                                .blur(radius: 1)
                        )
                        .shadow(color: accentColor.opacity(0.3), radius: 4, x: 0, y: 0)
                    
                    Spacer()
                }
                .frame(width: sliderWidth - 10, height: 40)
                .padding(.horizontal, 5)
                .mask(RoundedRectangle(cornerRadius: 25))
                .animation(.smooth(duration: 0.1), value: value)
                
                // Floating pill handle - perfectly aligned to track
                ZStack {
                    // Handle shadow in the well
                    Capsule()
                        .fill(darkShadow.opacity(0.2))
                        .frame(width: 100, height: 36)
                        .blur(radius: 4)
                        .offset(y: 2)
                    
                    // Handle
                    Capsule()
                        .fill(baseColor)
                        .frame(width: thumbWidth, height: 34)
                        .overlay(
                            Capsule()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            lightShadow.opacity(0.6),
                                            Color.clear,
                                            darkShadow.opacity(0.1)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        )
                        .shadow(color: darkShadow.opacity(0.5), radius: 4, x: 3, y: 3)
                        .shadow(color: lightShadow.opacity(0.9), radius: 4, x: -3, y: -3)
                    
                    // Handle dots
                    HStack(spacing: 8) {
                        ForEach(0..<3) { _ in
                            Circle()
                                .fill(darkShadow.opacity(0.2))
                                .frame(width: 4, height: 4)
                        }
                    }
                }
                .offset(x: thumbOffset)
                .scaleEffect(isDragging ? 1.05 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isDragging)
                
                // Tooltip
                if showTooltip || isDragging {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(baseColor)
                            .frame(width: 60, height: 35)
                            .shadow(color: darkShadow.opacity(0.4), radius: 4, x: 2, y: 2)
                            .shadow(color: lightShadow.opacity(0.8), radius: 4, x: -2, y: -2)
                        
                        Text(String(format: "%.0f", value * 100))
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(textColor)
                    }
                    .offset(x: thumbOffset + thumbWidth/2, y: -45)
                    .transition(.scale.combined(with: .opacity))
                }
            }
            .frame(width: sliderWidth, height: 50)
            .onHover { hovering in
                withAnimation(.easeInOut(duration: 0.2)) {
                    showTooltip = hovering
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        isDragging = true
                        let newValue = gesture.location.x / sliderWidth
                        value = max(0, min(1, newValue))
                    }
                    .onEnded { _ in
                        isDragging = false
                    }
            )
        }
        .padding(50)
        .frame(width: 400, height: 250)
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct SliderNeumorphic1_Previews: PreviewProvider {
    public static var previews: some View {
        PreviewWrapper()
            .theme(.audioUI)
            .containerRelativeFrame([.horizontal, .vertical])
    }
    
    private struct PreviewWrapper: View {
        @State var sampleValue: Double = 0.5
        
        var body: some View {
            SliderNeumorphic1(value: $sampleValue)
        }
    }
}
