//
//  KnobDotted1.swift
//  AudioUIComponentTesting
//
//  Created by Mitchell Cohen on 6/9/25.
//


import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct KnobDotted1: View {
    @Binding var value: Double
    @State private var isDragging = false
    @State private var dragStartY: CGFloat = 0
    @State private var dragStartValue: Double = 0
    @State private var pulseAnimation = false
    @Environment(\.theme) private var theme
    
    // Enhanced theme-based colors - utilizing rich palette
    private var primaryColor: Color { theme.look.textPrimary }
    private var backgroundColor: Color { theme.look.surfacePrimary }
    private var accentColor: Color { theme.look.surfaceSecondary }
    
    // Additional rich color palette utilization
    private var brandPrimary: Color { theme.look.brandPrimary }
    private var brandSecondary: Color { theme.look.brandSecondary }
    private var brandTertiary: Color { theme.look.brandTertiary }
    private var accent: Color { theme.look.accent }
    private var accentSecondary: Color { theme.look.accentSecondary }
    private var glowPrimary: Color { theme.look.glowPrimary }
    private var glowAccent: Color { theme.look.glowAccent }
    private var interactiveActive: Color { theme.look.interactiveActive }
    private var surfaceElevated: Color { theme.look.surfaceElevated }
    private var neutralHighlight: Color { theme.look.neutralHighlight }
    
    public init(value: Binding<Double>) {
        self._value = value
    }
    
    public var body: some View {
        VStack(spacing: 35) {
            // Dot pattern dial
            ZStack {
                // Concentric circles of dots
                ForEach(0..<3) { ring in
                    ForEach(0..<(ring + 1) * 8, id: \.self) { index in
                        Circle()
                            .fill(dotColor(ring: ring, index: index))
                            .frame(width: 6, height: 6)
                            .offset(y: -CGFloat((ring + 1) * 25))
                            .rotationEffect(.degrees(Double(index) * 360 / Double((ring + 1) * 8)))
                            .scaleEffect(dotScale(ring: ring, index: index))
                    }
                }
                
                // Center display
                ZStack {
                    Circle()
                        .fill(backgroundColor)
                        .frame(width: 40, height: 40)
                    
                    Circle()
                        .stroke(primaryColor, lineWidth: 1)
                        .frame(width: 40, height: 40)
                    
                    Circle()
                        .fill(primaryColor)
                        .frame(width: 4, height: 4)
                        .scaleEffect(pulseAnimation ? 1.5 : 1.0)
                        .opacity(pulseAnimation ? 0.5 : 1.0)
                }
            }
            .frame(width: 160, height: 160)
            .rotation3DEffect(
                .degrees(isDragging ? 5 : 0),
                axis: (x: 1, y: 0, z: 0)
            )
            .animation(.smooth(duration: 0.2), value: isDragging)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { drag in
                        if !isDragging {
                            isDragging = true
                            dragStartY = drag.location.y
                            dragStartValue = value
                            withAnimation(.easeOut(duration: 0.3)) {
                                pulseAnimation = true
                            }
                        }
                        
                        let deltaY = dragStartY - drag.location.y
                        let sensitivity: Double = 0.004
                        value = max(0, min(1, dragStartValue + deltaY * sensitivity))
                    }
                    .onEnded { _ in
                        isDragging = false
                        pulseAnimation = false
                    }
            )
            
            // Value display
            HStack(spacing: 20) {
                Rectangle()
                    .fill(primaryColor.opacity(0.2))
                    .frame(width: 40, height: 1)
                
                Text("\(Int(value * 100))%")
                    .font(.system(size: 16, weight: .light, design: .default))
                    .foregroundColor(primaryColor)
                    .frame(width: 50)
                
                Rectangle()
                    .fill(primaryColor.opacity(0.2))
                    .frame(width: 40, height: 1)
            }
        }
        .frame(width: 240, height: 240)
    }
    
    private func dotColor(ring: Int, index: Int) -> Color {
        let ringProgress = value * 3
        if CGFloat(ring) < ringProgress {
            let localProgress = ringProgress - CGFloat(ring)
            let dotProgress = CGFloat(index) / CGFloat((ring + 1) * 8)
            // Use enhanced theme colors for better visibility
            return dotProgress < localProgress ? interactiveActive : brandSecondary
        }
        return brandSecondary.opacity(0.4)
    }
    
    private func dotScale(ring: Int, index: Int) -> CGFloat {
        let ringProgress = value * 3
        if CGFloat(ring) < ringProgress {
            let localProgress = ringProgress - CGFloat(ring)
            let dotProgress = CGFloat(index) / CGFloat((ring + 1) * 8)
            return dotProgress < localProgress ? 1.2 : 0.8
        }
        return 0.8
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct KnobDotted1_Previews: PreviewProvider {
    @State static var value: Double = 0.5
    
    public static var previews: some View {
        KnobDotted1(value: $value)
            .theme(.audioUI)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
