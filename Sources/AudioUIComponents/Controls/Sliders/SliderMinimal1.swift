//
//  SliderMinimal1.swift
//  AudioUIComponentTesting
//
//  Created by Mitchell Cohen on 6/9/25.
//


import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct SliderMinimal1: View {
    @Binding var value: Double
    @State private var isDragging = false
    @State private var angle: Double = 0
    @Environment(\.theme) private var theme
    
    // Enhanced theme-based colors - utilizing rich palette
    private var primaryColor: Color { theme.look.textPrimary }
    private var backgroundColor: Color { theme.look.surfacePrimary }
    private var accentColor: Color { theme.look.surfaceSecondary }
    
    // Additional rich color palette utilization
    private var trackColor: Color { theme.look.sliderTrack }
    private var thumbColor: Color { theme.look.sliderThumb }
    private var brandPrimary: Color { theme.look.brandPrimary }
    private var brandSecondary: Color { theme.look.brandSecondary }
    private var brandTertiary: Color { theme.look.brandTertiary }
    private var accent: Color { theme.look.accent }
    private var accentSecondary: Color { theme.look.accentSecondary }
    private var glowPrimary: Color { theme.look.glowPrimary }
    private var interactiveActive: Color { theme.look.interactiveActive }
    private var neutralHighlight: Color { theme.look.neutralHighlight }
    private var surfaceElevated: Color { theme.look.surfaceElevated }
    private var textAccent: Color { theme.look.textAccent }
    
    public init(value: Binding<Double>) {
        self._value = value
    }
    
    public var body: some View {
        VStack(spacing: 40) {
            // Enhanced Circular slider with rich color gradients
            ZStack {
                // Background track with gradient
                Circle()
                    .stroke(
                        LinearGradient(
                            colors: [trackColor.opacity(0.3), accentColor.opacity(0.6)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 40
                    )
                    .frame(width: 200, height: 200)
                
                // Outer decorative ring
                Circle()
                    .stroke(
                        LinearGradient(
                            colors: [brandPrimary.opacity(0.4), brandSecondary.opacity(0.6)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 2
                    )
                    .frame(width: 220, height: 220)
                
                // Progress arc with rich color transition
                Circle()
                    .trim(from: 0, to: value)
                    .stroke(
                        LinearGradient(
                            colors: [
                                brandPrimary,
                                interactiveActive,
                                brandTertiary,
                                accentSecondary
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        style: StrokeStyle(
                            lineWidth: isDragging ? 4 : 2,
                            lineCap: .round
                        )
                    )
                    .frame(width: 200, height: 200)
                    .rotationEffect(.degrees(-90))
                
                // Inner circle
                Circle()
                    .fill(backgroundColor)
                    .frame(width: 160, height: 160)
                    .overlay(
                        Circle()
                            .stroke(primaryColor.opacity(0.1), lineWidth: 1)
                    )
                
                // Value display
                VStack(spacing: 4) {
                    Text("\(Int(value * 100))")
                        .font(.system(size: 48, weight: .ultraLight, design: .default))
                        .foregroundColor(primaryColor)
                    
                    Text("VOLUME")
                        .font(.system(size: 10, weight: .medium, design: .default))
                        .tracking(2)
                        .foregroundColor(primaryColor.opacity(0.5))
                }
                
                // Handle dot
                Circle()
                    .fill(primaryColor)
                    .frame(width: isDragging ? 16 : 12, height: isDragging ? 16 : 12)
                    .offset(x: 100 * cos(angle - .pi/2), y: 100 * sin(angle - .pi/2))
            }
            .animation(.smooth(duration: 0.2), value: isDragging)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { drag in
                        isDragging = true
                        let center = CGPoint(x: 100, y: 100)
                        let location = drag.location
                        let angle = atan2(location.y - center.y, location.x - center.x)
                        var normalizedAngle = (angle + .pi/2) / (2 * .pi)
                        if normalizedAngle < 0 { normalizedAngle += 1 }
                        
                        self.angle = angle
                        value = max(0, min(1, normalizedAngle))
                    }
                    .onEnded { _ in
                        isDragging = false
                    }
            )
        }
        .frame(width: 300, height: 300)
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct SliderMinimal1_Previews: PreviewProvider {
    @State static var value: Double = 0.5
    
    public static var previews: some View {
        SliderMinimal1(value: $value)
            .theme(.audioUI)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
