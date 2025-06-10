//
//  KnobMinimal1.swift
//  AudioUIComponentTesting
//
//  Created by Mitchell Cohen on 6/9/25.
//


import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct KnobMinimal1: View {
    @Binding var value: Double
    
    @State private var isDragging = false
    @State private var dragStart: CGFloat = 0
    @State private var valueStart: Double = 0
    
    @Environment(\.theme) private var theme
    
    // Enhanced theme-derived colors - utilizing rich palette
    private var backgroundColor: Color {
        theme.look.surfacePrimary
    }
    
    private var primaryColor: Color {
        theme.look.textPrimary
    }
    
    private var accentColor: Color {
        theme.look.surfaceSecondary
    }
    
    private var textColor: Color {
        theme.look.textSecondary
    }
    
    // Additional rich color palette utilization
    private var knobRimColor: Color {
        theme.look.knobPrimary
    }
    
    private var knobFillColor: Color {
        theme.look.knobSecondary
    }
    
    private var brandAccent: Color {
        theme.look.brandPrimary
    }
    
    private var brandSecondary: Color {
        theme.look.brandSecondary
    }
    
    private var interactiveColor: Color {
        theme.look.interactiveActive
    }
    
    private var focusColor: Color {
        theme.look.interactiveFocus
    }
    
    private var glowColor: Color {
        theme.look.glowPrimary
    }
    
    private var highlightColor: Color {
        theme.look.neutralHighlight
    }
    
    private var valueIndicatorColor: Color {
        theme.look.accent
    }
    
    private var trackColor: Color {
        theme.look.sliderTrack
    }
    
    private var surfaceElevated: Color {
        theme.look.surfaceElevated
    }
    
    public init(value: Binding<Double>) {
        self._value = value
    }
    
    public var body: some View {
        VStack(spacing: 30) {
            // Enhanced Label with richer colors
            Text("TONE")
                .font(.system(size: 10, weight: .medium, design: .default))
                .tracking(3)
                .foregroundColor(isDragging ? brandAccent : textColor.opacity(0.5))
                .animation(.easeInOut(duration: 0.2), value: isDragging)
            
            // Enhanced Dial with multiple color layers
            ZStack {
                // Track ring (removed outer decorative ring)
                Circle()
                    .stroke(trackColor.opacity(0.3), lineWidth: 4)
                    .frame(width: 120, height: 120)
                
                // Value progress ring
                Circle()
                    .trim(from: 0, to: value)
                    .stroke(
                        LinearGradient(
                            colors: [valueIndicatorColor, brandAccent],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        style: StrokeStyle(lineWidth: 4, lineCap: .round)
                    )
                    .frame(width: 120, height: 120)
                    .rotationEffect(.degrees(-90))
                
                // Outer rim removed for cleaner look
                
                // Inner circle with enhanced gradient fill
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                surfaceElevated,
                                backgroundColor,
                                theme.look.surfaceDeep
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 100, height: 100)
                    .overlay(
                        GeometryReader { geometry in
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [knobFillColor, valueIndicatorColor.opacity(0.8)],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .offset(y: geometry.size.height * (1 - value))
                                .frame(width: 100, height: 100)
                                .mask(
                                    Circle()
                                        .frame(width: 100, height: 100)
                                )
                        }
                        .frame(width: 100, height: 100)
                    )
                    .overlay(
                        Circle()
                            .stroke(primaryColor, lineWidth: isDragging ? 2 : 1)
                    )
                
                // Center dot
                Circle()
                    .fill(backgroundColor)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Circle()
                            .stroke(primaryColor, lineWidth: 1)
                    )
                
                // Value text with enhanced contrast
                Text("\(Int(value * 100))")
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .foregroundColor(brandAccent)
                    .background(
                        Circle()
                            .fill(backgroundColor)
                            .shadow(color: brandSecondary, radius: 2, x: 0, y: 1)
                            .frame(width: 45, height: 45)
                    )
            }
            .scaleEffect(isDragging ? 1.05 : 1.0)
            .animation(.smooth(duration: 0.15), value: isDragging)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { drag in
                        if !isDragging {
                            isDragging = true
                            dragStart = drag.location.y
                            valueStart = value
                        }
                        
                        let deltaY = dragStart - drag.location.y
                        let sensitivity: Double = 0.005
                        value = max(0, min(1, valueStart + deltaY * sensitivity))
                    }
                    .onEnded { _ in
                        isDragging = false
                    }
            )
            
            // Indicator line
            Rectangle()
                .fill(primaryColor)
                .frame(width: isDragging ? 40 : 20, height: 1)
                .animation(.spring(response: 0.3), value: isDragging)
        }
        .frame(width: 200, height: 220)
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct KnobMinimal1_Previews: PreviewProvider {
    @State static var value: Double = 0.5
    
    public static var previews: some View {
        KnobMinimal1(value: $value)
            .theme(.audioUI)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
