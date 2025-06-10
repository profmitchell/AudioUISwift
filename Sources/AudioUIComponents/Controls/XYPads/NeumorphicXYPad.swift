//
//  NeumorphicXYPad.swift
//  AudioUIComponentTesting
//
//  Created by Mitchell Cohen on 6/9/25.
//

import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct NeumorphicXYPad: View {
    @Binding var value: CGPoint
    @State private var isDragging = false
    @State private var showTrails = false
    
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
    private var glowAccent: Color { theme.look.glowAccent }
    private var shadowMedium: Color { theme.look.shadowMedium }
    private var interactiveActive: Color { theme.look.interactiveActive }
    private var neutralHighlight: Color { theme.look.neutralHighlight }
    
    public init(value: Binding<CGPoint>) {
        self._value = value
    }
    
    public var body: some View {
        VStack(spacing: 30) {
            // Title
            Text("XY PAD - NEUMORPHIC")
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .tracking(1.5)
                .foregroundColor(textColor)
            
            // Main XY Control
            ZStack {
                // Deep inset background
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        RadialGradient(
                            colors: [
                                accentColor.opacity(0.1 * (isDragging ? 0.5 : 0)),
                                accentColor.opacity(0.05 * (isDragging ? 0.5 : 0)),
                                Color.clear
                            ],
                            center: UnitPoint(x: value.x, y: 1 - value.y),
                            startRadius: 10,
                            endRadius: 200
                        )
                    )
                    .frame(width: 280, height: 280)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        darkShadow.opacity(0.2),
                                        lightShadow.opacity(0.8)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 2
                            )
                    )
                    .shadow(color: darkShadow.opacity(0.25), radius: 15, x: -8, y: -8)
                    .shadow(color: lightShadow.opacity(0.9), radius: 15, x: 8, y: 8)
                
                // Grid overlay
                VStack(spacing: 0) {
                    ForEach(0..<4) { _ in
                        Rectangle()
                            .fill(darkShadow.opacity(0.05))
                            .frame(height: 1)
                        Spacer()
                    }
                    Rectangle()
                        .fill(darkShadow.opacity(0.05))
                        .frame(height: 1)
                }
                .frame(width: 240, height: 240)
                
                HStack(spacing: 0) {
                    ForEach(0..<4) { _ in
                        Rectangle()
                            .fill(darkShadow.opacity(0.05))
                            .frame(width: 1)
                        Spacer()
                    }
                    Rectangle()
                        .fill(darkShadow.opacity(0.05))
                        .frame(width: 1)
                }
                .frame(width: 240, height: 240)
                
                // Trail dots
                if showTrails {
                    ForEach(0..<5) { i in
                        Circle()
                            .fill(
                                RadialGradient(
                                    colors: [
                                        accentColor.opacity(0.2),
                                        accentColor.opacity(0.1)
                                    ],
                                    center: .center,
                                    startRadius: 2,
                                    endRadius: 8
                                )
                            )
                            .frame(width: 16 - CGFloat(i) * 2, height: 16 - CGFloat(i) * 2)
                            .position(
                                x: value.x * 240 + 20,
                                y: (1 - value.y) * 240 + 20
                            )
                            .opacity(1.0 - Double(i) * 0.2)
                            .scaleEffect(1.0 - Double(i) * 0.1)
                    }
                }
                
                // Control handle
                ZStack {
                    // Handle shadow
                    Circle()
                        .fill(darkShadow.opacity(0.2))
                        .frame(width: 45, height: 45)
                        .blur(radius: 8)
                        .offset(x: 3, y: 3)
                    
                    // Handle
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    lightShadow.opacity(0.5),
                                    darkShadow.opacity(0.1)
                                ],
                                center: .topLeading,
                                startRadius: 5,
                                endRadius: 25
                            )
                        )
                        .frame(width: 40, height: 40)
                        .overlay(
                            Circle()
                                .stroke(
                                    RadialGradient(
                                        colors: [
                                            accentColor,
                                            accentColor
                                        ],
                                        center: .center,
                                        startRadius: 10,
                                        endRadius: 20
                                    ),
                                    lineWidth: 2
                                )
                        )
                        .shadow(color: lightShadow.opacity(0.9), radius: 3, x: -2, y: -2)
                        .shadow(color: darkShadow.opacity(0.2), radius: 3, x: 2, y: 2)
                    
                    // Center dot
                    Circle()
                        .fill(darkShadow.opacity(0.2))
                        .frame(width: 6, height: 6)
                }
                .position(
                    x: value.x * 240 + 20,
                    y: (1 - value.y) * 240 + 20
                )
                .scaleEffect(isDragging ? 1.1 : 1.0)
                .shadow(color: accentColor.opacity(0.5), radius: 3)
            }
            .frame(width: 280, height: 280)
            .clipped()
            .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isDragging)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { drag in
                        if !isDragging {
                            isDragging = true
                            showTrails = true
                        }
                        
                        let x = max(0, min(1, drag.location.x / 280))
                        let y = max(0, min(1, 1 - (drag.location.y / 280)))
                        value = CGPoint(x: x, y: y)
                    }
                    .onEnded { _ in
                        isDragging = false
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            showTrails = false
                        }
                    }
            )
            
            // Value displays
            HStack(spacing: 40) {
                valueDisplay("X", value.x)
                valueDisplay("Y", value.y)
            }
        }
        .padding(30)
        .frame(width: 400, height: 500)
    }
    
    private func valueDisplay(_ label: String, _ value: Double) -> some View {
        VStack(spacing: 8) {
            Text(label)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundColor(textColor.opacity(0.4))
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(baseColor)
                    .frame(width: 80, height: 35)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        darkShadow.opacity(0.1),
                                        lightShadow.opacity(0.7)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    )
                    .shadow(color: darkShadow.opacity(0.15), radius: 3, x: -2, y: -2)
                    .shadow(color: lightShadow.opacity(0.9), radius: 3, x: 2, y: 2)
                
                Text(String(format: "%.2f", value))
                    .font(.system(size: 14, weight: .medium, design: .monospaced))
                    .foregroundColor(theme.look.textPrimary)
            }
        }
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct NeumorphicXYPad_Previews: PreviewProvider {
    @State static var value = CGPoint(x: 0.5, y: 0.5)
    
    public static var previews: some View {
        NeumorphicXYPad(value: $value)
            .theme(.audioUINeumorphic)
            .previewLayout(.sizeThatFits)
    }
}
