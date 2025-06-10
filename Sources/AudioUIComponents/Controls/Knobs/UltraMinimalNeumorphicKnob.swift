//
//  UltraMinimalNeumorphicKnob.swift
//  MIDIUITesting
//
//  Created by Mitchell Cohen on 6/2/25.
//


import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct UltraMinimalNeumorphicKnob: View {
    @Binding var value: Double
    @State private var isDragging = false
    @State private var dragStartValue: Double = 0
    
    @Environment(\.theme) private var theme
    
    // Enhanced theme-derived colors - utilizing rich palette
    private var baseColor: Color { theme.look.surfacePrimary }
    private var darkShadow: Color { theme.look.shadowDark }
    private var lightShadow: Color { theme.look.shadowLight }
    private var textColor: Color { theme.look.textSecondary }
    
    // Additional rich color palette utilization
    private var surfaceElevated: Color { theme.look.surfaceElevated }
    private var surfaceDeep: Color { theme.look.surfaceDeep }
    private var brandPrimary: Color { theme.look.brandPrimary }
    private var accent: Color { theme.look.accent }
    private var glowPrimary: Color { theme.look.glowPrimary }
    private var shadowMedium: Color { theme.look.shadowMedium }
    private var interactiveHover: Color { theme.look.interactiveHover }
    private var neutralHighlight: Color { theme.look.neutralHighlight }
    private var textPrimary: Color { theme.look.textPrimary }
    
    public init(value: Binding<Double>) {
        self._value = value
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Text("MINIMAL - ULTRA CLEAN")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(textColor)
                .tracking(1.5)
            
            Text("\(Int(value * 100))%")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(theme.look.textPrimary)
            
        ZStack {
            // Super clean background
            Circle()
                .fill(baseColor)
                .frame(width: 120, height: 120)
                .shadow(color: lightShadow, radius: 15, x: -10, y: -10)
                .shadow(color: darkShadow.opacity(0.08), radius: 15, x: 10, y: 10)
            
            // Enhanced contrast value ring
            Circle()
                .trim(from: 0.125, to: 0.125 + (value * 0.75))
                .stroke(
                    LinearGradient(
                        colors: [
                            interactiveHover.opacity(0.3),
                            brandPrimary.opacity(0.4),
                            accent.opacity(0.5)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    style: StrokeStyle(lineWidth: 40, lineCap: .round)
                )
                .frame(width: 80, height: 80)
                .rotationEffect(.degrees(90))
                .animation(.easeOut(duration: 0.3), value: value)
            
            // Clean center
            Circle()
                .fill(baseColor)
                .frame(width: 60, height: 60)
                .shadow(color: lightShadow, radius: isDragging ? 6 : 8, x: isDragging ? -4 : -6, y: isDragging ? -4 : -6)
                .shadow(color: darkShadow.opacity(0.1), radius: isDragging ? 6 : 8, x: isDragging ? 4 : 6, y: isDragging ? 4 : 6)
                .overlay(
                    // Single dot indicator
                    Circle()
                        .fill(darkShadow.opacity(0.2))
                        .frame(width: 4, height: 4)
                        .offset(y: -20)
                        .rotationEffect(.degrees(value * 270 - 135))
                )
        }
        .scaleEffect(isDragging ? 0.98 : 1.0)
        
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { drag in
                    if !isDragging {
                        isDragging = true
                        dragStartValue = value
                    }
                    let delta = -drag.translation.height * 0.005
                    value = min(max(dragStartValue + delta, 0), 1)
                }
                .onEnded { _ in isDragging = false }
        )
    }
}
}

@available(iOS 18.0, macOS 15.0, *)
public struct UltraMinimalNeumorphicKnob_Previews: PreviewProvider {
    @State static var value: Double = 0.5
    
    public static var previews: some View {
        UltraMinimalNeumorphicKnob(value: $value)
            .theme(.audioUINeumorphic)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
