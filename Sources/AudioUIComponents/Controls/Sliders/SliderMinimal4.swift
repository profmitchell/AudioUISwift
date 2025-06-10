//
//  SliderMinimal4.swift
//  AudioUIComponentTesting
//
//  Created by Mitchell Cohen on 6/9/25.
//


import SwiftUI

@available(iOS 18.0, macOS 15.0, *)
public struct SliderMinimal4: View {
    @Binding var value: Double
    @State private var touchLocation: CGPoint = .zero
    @Environment(\.theme) private var theme
    
    // Enhanced theme-based colors - utilizing rich palette
    private var primaryColor: Color { theme.look.textPrimary }
    private var backgroundColor: Color { theme.look.surfacePrimary }
    private var accentColor: Color { theme.look.surfaceSecondary }
    
    // Additional rich color palette utilization
    private var brandPrimary: Color { theme.look.brandPrimary }
    private var brandSecondary: Color { theme.look.brandSecondary }
    private var accent: Color { theme.look.accent }
    private var neutralDivider: Color { theme.look.neutralDivider }
    private var interactiveActive: Color { theme.look.interactiveActive }
    private var glowAccent: Color { theme.look.glowAccent }
    private var textSecondary: Color { theme.look.textSecondary }
    
    private let rows = 5
    private let cols = 20
    
    public init(value: Binding<Double>) {
        self._value = value
    }
    
    public var body: some View {
        VStack(spacing: 30) {
            // Header
            HStack {
                Text("DENSITY")
                    .font(.system(size: 10, weight: .medium, design: .default))
                    .tracking(2)
                    .foregroundColor(primaryColor.opacity(0.6))
                
                Spacer()
                
                Text("\(Int(value * 100))%")
                    .font(.system(size: 14, weight: .light, design: .default))
                    .foregroundColor(primaryColor)
            }
            .frame(width: 300)
            
            // Dot matrix
            VStack(spacing: 8) {
                ForEach(0..<rows, id: \.self) { row in
                    HStack(spacing: 8) {
                        ForEach(0..<cols, id: \.self) { col in
                            Circle()
                                .fill(dotColor(row: row, col: col))
                                .frame(width: 10, height: 10)
                                .scaleEffect(dotScale(row: row, col: col))
                        }
                    }
                }
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(backgroundColor)
                    .overlay(
                        Rectangle()
                            .stroke(primaryColor.opacity(0.1), lineWidth: 1)
                    )
            )
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { drag in
                        touchLocation = drag.location
                        let width: CGFloat = 300
                        value = max(0, min(1, drag.location.x / width))
                    }
            )
            
            // Bottom line
            Rectangle()
                .fill(primaryColor)
                .frame(width: 300 * value, height: 1)
                .frame(width: 300, alignment: .leading)
        }
        .frame(width: 360, height: 240)
    }
    
    private func dotColor(row: Int, col: Int) -> Color {
        let activeColumns = Int(value * Double(cols))
        if col < activeColumns {
            let distance = abs(row - rows/2)
            let opacity = 1.0 - (Double(distance) / Double(rows) * 0.5)
            return primaryColor.opacity(opacity)
        }
        return accentColor
    }
    
    private func dotScale(row: Int, col: Int) -> CGFloat {
        let activeColumns = Int(value * Double(cols))
        if col < activeColumns {
            let distance = abs(row - rows/2)
            return 1.0 - (CGFloat(distance) / CGFloat(rows) * 0.3)
        }
        return 0.8
    }
}
