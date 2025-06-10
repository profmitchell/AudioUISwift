//
//  KnobMinimal4.swift
//  AudioUIComponentTesting
//
//  Created by Mitchell Cohen on 6/9/25.
//


import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct KnobMinimal4: View {
    @Binding var value: Double
    @State private var isDragging = false
    @State private var dragStartY: CGFloat = 0
    @State private var dragStartValue: Double = 0
    @State private var orbitAnimation: Double = 0
    @Environment(\.theme) private var theme
    
    // Enhanced theme-based colors - utilizing rich palette
    private var primaryColor: Color { theme.look.textPrimary }
    private var backgroundColor: Color { theme.look.surfacePrimary }
    private var accentColor: Color { theme.look.surfaceSecondary }
    
    // Additional rich color palette utilization
    private var brandPrimary: Color { theme.look.brandPrimary }
    private var brandSecondary: Color { theme.look.brandSecondary }
    private var accent: Color { theme.look.accent }
    private var accentSecondary: Color { theme.look.accentSecondary }
    private var glowPrimary: Color { theme.look.glowPrimary }
    private var textSecondary: Color { theme.look.textSecondary }
    private var interactiveActive: Color { theme.look.interactiveActive }
    private var neutralHighlight: Color { theme.look.neutralHighlight }
    private var shadowLight: Color { theme.look.shadowLight }
    private var surfaceElevated: Color { theme.look.surfaceElevated }
    
    public init(value: Binding<Double>) {
        self._value = value
    }
    
    public var body: some View {
        VStack(spacing: 30) {
            Text("RESONANCE")
                .font(.system(size: 9, weight: .medium, design: .default))
                .tracking(3)
                .foregroundColor(primaryColor.opacity(0.4))
            
            // Orbital dial
            ZStack {
                // Outer guides
                ForEach(0..<4) { i in
                    Rectangle()
                        .fill(primaryColor.opacity(0.1))
                        .frame(width: 1, height: 140)
                        .rotationEffect(.degrees(Double(i) * 90))
                }
                
                // Track circle
                Circle()
                    .stroke(accentColor, lineWidth: 20)
                    .frame(width: 100, height: 100)
                
                // Progress arc - properly aligned with track
                Circle()
                    .trim(from: 0.125, to: 0.125 + (value * 0.75))
                    .stroke(
                        LinearGradient(
                            colors: [primaryColor, interactiveActive],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        style: StrokeStyle(lineWidth: 4, lineCap: .round)
                    )
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(90))
                
                // Orbiting indicator - aligned with arc
                Circle()
                    .fill(interactiveActive)
                    .frame(width: 12, height: 12)
                    .offset(y: -50)
                    .rotationEffect(.degrees(value * 270 - 135))
                    .shadow(color: glowPrimary, radius: 6, x: 0, y: 0)
                
                // Center
                Circle()
                    .fill(backgroundColor)
                    .frame(width: 60, height: 60)
                    .overlay(
                        Text("\(Int(value * 100))")
                            .font(.system(size: 24, weight: .ultraLight, design: .default))
                            .foregroundColor(primaryColor)
                    )
            }
            .frame(width: 140, height: 140)
            .scaleEffect(isDragging ? 1.02 : 1.0)
            .animation(.smooth(duration: 0.2), value: isDragging)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { drag in
                        if !isDragging {
                            isDragging = true
                            dragStartY = drag.location.y
                            dragStartValue = value
                        }
                        
                        let deltaY = dragStartY - drag.location.y
                        let sensitivity: Double = 0.005
                        value = max(0, min(1, dragStartValue + deltaY * sensitivity))
                    }
                    .onEnded { _ in
                        isDragging = false
                    }
            )
        }
        .frame(width: 200, height: 220)
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct KnobMinimal4_Previews: PreviewProvider {
    @State static var value: Double = 0.5
    
    public static var previews: some View {
        KnobMinimal4(value: $value)
            .theme(.audioUI)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
