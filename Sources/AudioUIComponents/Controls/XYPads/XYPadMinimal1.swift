//
//  XYPadMinimal1.swift
//  AudioUI
//
//  Created by Mitchell Cohen on 6/3/25.
//

import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct XYPadMinimal1: View {
    @Binding private var position: CGPoint
    @State private var isDragging = false
    
    let onPositionChange: ((CGPoint) -> Void)?
    @Environment(\.theme) private var theme
    
    // Enhanced minimal colors - utilizing rich palette
    private var primaryColor: Color { theme.look.textPrimary }
    private var backgroundColor: Color { theme.look.surfacePrimary }
    
    // Additional rich color palette utilization
    private var gridColor: Color { theme.look.neutralDivider }
    private var thumbColor: Color { theme.look.sliderThumb }
    private var brandPrimary: Color { theme.look.brandPrimary }
    private var brandSecondary: Color { theme.look.brandSecondary }
    private var accent: Color { theme.look.accent }
    private var accentSecondary: Color { theme.look.accentSecondary }
    private var glowPrimary: Color { theme.look.glowPrimary }
    private var interactiveActive: Color { theme.look.interactiveActive }
    private var textSecondary: Color { theme.look.textSecondary }
    private var surfaceElevated: Color { theme.look.surfaceElevated }
    private var highlightColor: Color { theme.look.neutralHighlight }
    private var crosshairColor: Color { theme.look.textTertiary }
    private var frameColor: Color { theme.look.glassBorder }
    private var panelBackground: Color { theme.look.panelBackground }
    
    private let size: CGFloat = 300
    
    public init(
        position: Binding<CGPoint> = .constant(CGPoint(x: 0.5, y: 0.5)),
        onPositionChange: ((CGPoint) -> Void)? = nil
    ) {
        self._position = position
        self.onPositionChange = onPositionChange
    }
    
    public var body: some View {
        VStack(spacing: 30) {
            // Enhanced XY Pad with rich color layers
            ZStack {
                // Outer frame with brand colors
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [panelBackground, surfaceElevated],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: size + 20, height: size + 20)
                    .overlay(
                        Rectangle()
                            .stroke(frameColor, lineWidth: 2)
                    )
                
                // Background with gradient
                Rectangle()
                    .fill(
                        RadialGradient(
                            colors: [
                                backgroundColor,
                                surfaceElevated.opacity(0.8),
                                theme.look.surfaceDeep.opacity(0.6)
                            ],
                            center: UnitPoint(x: position.x, y: position.y),
                            startRadius: 0,
                            endRadius: size * 0.7
                        )
                    )
                    .frame(width: size, height: size)
                    .overlay(
                        Rectangle()
                            .stroke(primaryColor.opacity(0.2), lineWidth: 1)
                    )
                
                // Grid overlay for better interaction feedback
                Path { path in
                    // Vertical grid lines
                    for i in 1..<4 {
                        let x = CGFloat(i) * size / 4
                        path.move(to: CGPoint(x: x, y: 0))
                        path.addLine(to: CGPoint(x: x, y: size))
                    }
                    // Horizontal grid lines
                    for i in 1..<4 {
                        let y = CGFloat(i) * size / 4
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: size, y: y))
                    }
                }
                .stroke(gridColor.opacity(0.3), lineWidth: 0.5)
                
                // Crosshair guides
                Path { path in
                    // Vertical line
                    path.move(to: CGPoint(x: position.x * size, y: 0))
                    path.addLine(to: CGPoint(x: position.x * size, y: size))
                    
                    // Horizontal line
                    path.move(to: CGPoint(x: 0, y: position.y * size))
                    path.addLine(to: CGPoint(x: size, y: position.y * size))
                }
                .stroke(primaryColor.opacity(0.2), lineWidth: 1)
                
                // Position indicator with enhanced feedback
                ZStack {
                    // Outer glow effect during interaction
                    if isDragging {
                        Circle()
                            .fill(
                                RadialGradient(
                                    colors: [
                                        glowPrimary.opacity(0.4),
                                        Color.clear
                                    ],
                                    center: .center,
                                    startRadius: 8,
                                    endRadius: 24
                                )
                            )
                            .frame(width: 48, height: 48)
                    }
                    
                    // Main indicator
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [brandPrimary, interactiveActive],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: isDragging ? 16 : 12, height: isDragging ? 16 : 12)
                        .overlay(
                            Circle()
                                .stroke(frameColor, lineWidth: isDragging ? 2 : 1)
                        )
                        .overlay(
                            // Center dot
                            Circle()
                                .fill(backgroundColor)
                                .frame(width: 6, height: 6)
                        )
                }
                .position(x: position.x * size, y: position.y * size)
                .scaleEffect(isDragging ? 1.2 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isDragging)
                
                // Interactive overlay for proper gesture handling
                Rectangle()
                    .fill(Color.clear)
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { gesture in
                                isDragging = true
                                let x = max(0, min(1, gesture.location.x / size))
                                let y = max(0, min(1, gesture.location.y / size))
                                position = CGPoint(x: x, y: y)
                                handlePositionChange(position)
                            }
                            .onEnded { _ in
                                withAnimation(.easeOut(duration: 0.2)) {
                                    isDragging = false
                                }
                            }
                    )
            }
            .frame(width: size, height: size)
            .contentShape(Rectangle())
            
            // Value display
            HStack(spacing: 40) {
                valueDisplay(label: "X", value: normalizedX)
                valueDisplay(label: "Y", value: normalizedY)
            }
        }
        .frame(width: 360, height: 400)
        .onChange(of: position) { newPosition in
            onPositionChange?(newPosition)
        }
    }
    
    private var normalizedX: Double {
        Double(position.x)
    }
    
    private var normalizedY: Double {
        Double(1 - position.y)
    }
    
    private func handlePositionChange(_ newPosition: CGPoint) {
        onPositionChange?(newPosition)
    }
    
    private func valueDisplay(label: String, value: Double) -> some View {
        VStack(spacing: 8) {
            Text(label)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(theme.look.textSecondary)
            
            ZStack {
                // Clean display
                RoundedRectangle(cornerRadius: 6)
                    .fill(theme.look.surfaceSecondary)
                    .frame(width: 70, height: 30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(theme.look.glassBorder, lineWidth: 1)
                    )
                
                Text(String(format: "%.3f", value))
                    .font(.system(size: 13, weight: .medium, design: .monospaced))
                    .foregroundColor(theme.look.textPrimary)
            }
        }
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct XYPadMinimal1_Previews: PreviewProvider {
    public static var previews: some View {
        XYPadMinimal1()
            .theme(.audioUI)
            .previewLayout(.sizeThatFits)
    }
}
