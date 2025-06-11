//
//  XYPadNeumorphic1.swift
//  AudioUI
//
//  Created by Mitchell Cohen on 6/10/25.
//

import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct XYPadNeumorphic1: View {
    @Binding public var value: CGPoint
    @State private var isDragging = false
    @Environment(\.theme) private var theme
    
    // Theme-derived colors for neumorphic design
    private var baseColor: Color { theme.look.surfacePrimary }
    private var darkShadow: Color { theme.look.shadowDark }
    private var lightShadow: Color { theme.look.shadowLight }
    private var accentColor: Color { theme.look.brandPrimary }
    private var textColor: Color { theme.look.textPrimary }
    
    public init(value: Binding<CGPoint>) {
        self._value = value
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Neumorphic container background
                RoundedRectangle(cornerRadius: 20)
                    .fill(baseColor)
                    .shadow(color: darkShadow.opacity(0.3), radius: 8, x: 6, y: 6)
                    .shadow(color: lightShadow.opacity(0.9), radius: 8, x: -6, y: -6)
                
                // Inner depression area
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            colors: [
                                darkShadow.opacity(0.2),
                                baseColor.opacity(0.8),
                                lightShadow.opacity(0.1)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(darkShadow.opacity(0.1), lineWidth: 1)
                            .padding(8)
                    )
                
                // Center cross guides
                VStack {
                    Rectangle()
                        .fill(darkShadow.opacity(0.1))
                        .frame(width: 1, height: geometry.size.height - 32)
                }
                
                HStack {
                    Rectangle()
                        .fill(darkShadow.opacity(0.1))
                        .frame(width: geometry.size.width - 32, height: 1)
                }
                
                // Neumorphic touch indicator
                ZStack {
                    // Shadow base for the thumb
                    Circle()
                        .fill(darkShadow.opacity(0.2))
                        .frame(width: 32, height: 32)
                        .blur(radius: 4)
                        .offset(x: 2, y: 2)
                    
                    // Main thumb with neumorphic effect
                    Circle()
                        .fill(baseColor)
                        .frame(width: 28, height: 28)
                        .overlay(
                            Circle()
                                .fill(
                                    RadialGradient(
                                        colors: [
                                            lightShadow.opacity(0.3),
                                            Color.clear,
                                            darkShadow.opacity(0.1)
                                        ],
                                        center: .topLeading,
                                        startRadius: 2,
                                        endRadius: 14
                                    )
                                )
                        )
                        .shadow(color: darkShadow.opacity(isDragging ? 0.2 : 0.4), radius: isDragging ? 3 : 6, x: isDragging ? 2 : 4, y: isDragging ? 2 : 4)
                        .shadow(color: lightShadow.opacity(0.9), radius: isDragging ? 3 : 6, x: isDragging ? -2 : -4, y: isDragging ? -2 : -4)
                        .scaleEffect(isDragging ? 0.95 : 1.0)
                    
                    // Inner dot indicator
                    Circle()
                        .fill(accentColor.opacity(isDragging ? 0.8 : 0.6))
                        .frame(width: 6, height: 6)
                        .shadow(color: accentColor.opacity(0.3), radius: isDragging ? 3 : 1)
                }
                .position(
                    x: max(20, min(geometry.size.width - 20, value.x * (geometry.size.width - 40) + 20)),
                    y: max(20, min(geometry.size.height - 20, (1.0 - value.y) * (geometry.size.height - 40) + 20))
                )
                .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isDragging)
                
                // Soft trail effect when dragging
                if isDragging {
                    let touchX = max(20, min(geometry.size.width - 20, value.x * (geometry.size.width - 40) + 20))
                    let touchY = max(20, min(geometry.size.height - 20, (1.0 - value.y) * (geometry.size.height - 40) + 20))
                    
                    // Vertical guide line
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    accentColor.opacity(0.1),
                                    accentColor.opacity(0.3),
                                    accentColor.opacity(0.1)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: 2, height: geometry.size.height - 32)
                        .position(x: touchX, y: geometry.size.height / 2)
                        .blur(radius: 1)
                    
                    // Horizontal guide line
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    accentColor.opacity(0.1),
                                    accentColor.opacity(0.3),
                                    accentColor.opacity(0.1)
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width - 32, height: 2)
                        .position(x: geometry.size.width / 2, y: touchY)
                        .blur(radius: 1)
                }
                
                // Corner value indicators (neumorphic style)
                VStack {
                    HStack {
                        valueIndicator("X: \(Int(value.x * 100))")
                        Spacer()
                        valueIndicator("Y: \(Int(value.y * 100))")
                    }
                    Spacer()
                }
                .padding(12)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { drag in
                        if !isDragging {
                            isDragging = true
                        }
                        
                        // Account for padding and thumb size
                        let adjustedX = max(0, min(geometry.size.width - 40, drag.location.x - 20))
                        let adjustedY = max(0, min(geometry.size.height - 40, drag.location.y - 20))
                        
                        let newX = adjustedX / (geometry.size.width - 40)
                        let newY = 1.0 - (adjustedY / (geometry.size.height - 40))
                        
                        value = CGPoint(x: newX, y: newY)
                    }
                    .onEnded { _ in
                        isDragging = false
                    }
            )
        }
        .frame(width: 200, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    @ViewBuilder
    private func valueIndicator(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 10, weight: .medium, design: .monospaced))
            .foregroundColor(textColor.opacity(0.7))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                Capsule()
                    .fill(baseColor)
                    .shadow(color: darkShadow.opacity(0.2), radius: 2, x: 1, y: 1)
                    .shadow(color: lightShadow.opacity(0.8), radius: 2, x: -1, y: -1)
            )
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct XYPadNeumorphic1_Previews: PreviewProvider {
    @State static var position = CGPoint(x: 0.5, y: 0.5)
    
    public static var previews: some View {
        XYPadNeumorphic1(value: $position)
            .theme(.audioUI)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
