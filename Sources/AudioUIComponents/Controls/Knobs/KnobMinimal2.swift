//
//  KnobMinimal2.swift
//  AudioUIComponentTesting
//
//  Created by Mitchell Cohen on 6/9/25.
//


import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct KnobMinimal2: View {
    @Binding var value: Double
    @State private var isDragging = false
    @State private var dragStart: CGFloat = 0
    @State private var valueStart: Double = 0
    
    @Environment(\.theme) private var theme
    
    // Enhanced theme-derived colors - utilizing rich palette
    private var backgroundColor: Color { theme.look.surfacePrimary }
    private var primaryColor: Color { theme.look.textPrimary }
    private var accentColor: Color { theme.look.surfaceSecondary }
    private var textColor: Color { theme.look.textSecondary }
    
    // Additional rich color palette utilization
    private var segmentActive: Color { theme.look.brandPrimary }
    private var segmentInactive: Color { theme.look.neutralDivider }
    private var centerColor: Color { theme.look.surfaceElevated }
    private var rimColor: Color { theme.look.brandSecondary }
    private var valueColor: Color { theme.look.accent }
    private var glowColor: Color { theme.look.glowPrimary }
    private var highlightColor: Color { theme.look.neutralHighlight }
    private var shadowColor: Color { theme.look.shadowMedium }
    private var interactiveHover: Color { theme.look.interactiveHover }
    private var interactiveActive: Color { theme.look.interactiveActive }
    
    private let segments = 20
    
    public init(value: Binding<Double>) {
        self._value = value
    }
    
    public var body: some View {
        VStack(spacing: 25) {
            // Segmented dial
            ZStack {
                // Background segments - perfectly aligned
                ForEach(0..<segments, id: \.self) { index in
                    Rectangle()
                        .fill(accentColor)
                        .frame(width: 4, height: 20)
                        .offset(y: -50)
                        .rotationEffect(.degrees(Double(index) * 360 / Double(segments)))
                }
                
                // Active segments - exactly aligned with background
                ForEach(0..<segments, id: \.self) { index in
                    Rectangle()
                        .fill(primaryColor)
                        .frame(width: 4, height: 20)
                        .offset(y: -50)
                        .rotationEffect(.degrees(Double(index) * 360 / Double(segments)))
                        .opacity(Double(index) / Double(segments) <= value ? 1 : 0)
                        .animation(.smooth(duration: 0.1), value: value)
                }
                
                // Center
                Circle()
                    .fill(backgroundColor)
                    .frame(width: 60, height: 60)
                    .overlay(
                        Circle()
                            .stroke(primaryColor, lineWidth: 1)
                    )
                
                // Value
                VStack(spacing: 2) {
                    Text("\(Int(value * 100))")
                        .font(.system(size: 20, weight: .ultraLight, design: .default))
                        .foregroundColor(primaryColor)
                    
                    Rectangle()
                        .fill(primaryColor.opacity(0.3))
                        .frame(width: 30, height: 0.5)
                }
            }
            .frame(width: 140, height: 140)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { drag in
                        if !isDragging {
                            isDragging = true
                            dragStart = drag.location.y
                            valueStart = value
                        }
                        
                        let deltaY = dragStart - drag.location.y
                        let sensitivity: Double = 0.004
                        value = max(0, min(1, valueStart + deltaY * sensitivity))
                    }
                    .onEnded { _ in
                        isDragging = false
                    }
            )
            
            // Label
            Text("FILTER")
                .font(.system(size: 10, weight: .medium, design: .default))
                .tracking(2)
                .foregroundColor(textColor.opacity(0.6))
        }
        .frame(width: 200, height: 200)
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct KnobMinimal2_Previews: PreviewProvider {
    @State static var value: Double = 0.5
    
    public static var previews: some View {
        KnobMinimal2(value: $value)
            .theme(.audioUI)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
