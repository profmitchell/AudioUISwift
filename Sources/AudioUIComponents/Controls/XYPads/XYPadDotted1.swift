//
//  XYPadDotted1.swift
//  AudioUI
//
//  Created by Mitchell Cohen on 6/10/25.
//

import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct XYPadDotted1: View {
    @Binding public var value: CGPoint
    @State private var isDragging = false
    @Environment(\.theme) private var theme
    
    private let dotSize: CGFloat = 2
    private let spacing: CGFloat = 8
    
    // Enhanced theme-derived colors - utilizing rich palette
    private var primaryColor: Color { theme.look.textPrimary }
    private var backgroundColor: Color { theme.look.surfacePrimary }
    private var accentColor: Color { theme.look.brandPrimary }
    private var secondaryColor: Color { theme.look.textSecondary }
    private var surfaceElevated: Color { theme.look.surfaceElevated }
    private var interactiveActive: Color { theme.look.interactiveActive }
    private var neutralDivider: Color { theme.look.neutralDivider }
    
    public init(value: Binding<CGPoint>) {
        self._value = value
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background with dot pattern
                Canvas { context, size in
                    let cols = Int(size.width / spacing)
                    let rows = Int(size.height / spacing)
                    
                    for row in 0..<rows {
                        for col in 0..<cols {
                            let x = CGFloat(col) * spacing + dotSize/2
                            let y = CGFloat(row) * spacing + dotSize/2
                            
                            // Distance from touch point for interactive effect
                            let touchX = value.x * size.width
                            let touchY = (1.0 - value.y) * size.height
                            let distance = sqrt(pow(x - touchX, 2) + pow(y - touchY, 2))
                            let maxDistance: CGFloat = 50
                            
                            let opacity: Double
                            if distance < maxDistance {
                                opacity = 0.8 - (distance / maxDistance * 0.6)
                            } else {
                                opacity = 0.2
                            }
                            
                            context.fill(
                                Path(ellipseIn: CGRect(x: x-dotSize/2, y: y-dotSize/2, width: dotSize, height: dotSize)),
                                with: .color(primaryColor.opacity(opacity))
                            )
                        }
                    }
                }
                .background(backgroundColor)
                .overlay(
                    Rectangle()
                        .stroke(neutralDivider, lineWidth: 1)
                )
                
                // Center grid lines
                Path { path in
                    // Vertical center line
                    let centerX = geometry.size.width / 2
                    path.move(to: CGPoint(x: centerX, y: 0))
                    path.addLine(to: CGPoint(x: centerX, y: geometry.size.height))
                    
                    // Horizontal center line
                    let centerY = geometry.size.height / 2
                    path.move(to: CGPoint(x: 0, y: centerY))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: centerY))
                }
                .stroke(secondaryColor.opacity(0.4), lineWidth: 2)
                
                // Touch indicator with dot burst effect
                ZStack {
                    // Burst effect when dragging
                    if isDragging {
                        ForEach(0..<8, id: \.self) { index in
                            Circle()
                                .fill(accentColor.opacity(0.3))
                                .frame(width: 8, height: 8)
                                .offset(
                                    x: cos(Double(index) * .pi / 4) * 25,
                                    y: sin(Double(index) * .pi / 4) * 25
                                )
                        }
                        .transition(.scale.combined(with: .opacity))
                    }
                    
                    // Main touch indicator
                    Circle()
                        .fill(accentColor)
                        .frame(width: 20, height: 20)
                        .overlay(
                            Circle()
                                .stroke(primaryColor, lineWidth: 2)
                                .frame(width: 24, height: 24)
                        )
                        .scaleEffect(isDragging ? 1.3 : 1.0)
                }
                .position(
                    x: value.x * geometry.size.width,
                    y: (1.0 - value.y) * geometry.size.height
                )
                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isDragging)
                
                // Crosshair lines from touch point
                if isDragging {
                    Path { path in
                        let touchX = value.x * geometry.size.width
                        let touchY = (1.0 - value.y) * geometry.size.height
                        
                        // Vertical line through touch point
                        path.move(to: CGPoint(x: touchX, y: 0))
                        path.addLine(to: CGPoint(x: touchX, y: geometry.size.height))
                        
                        // Horizontal line through touch point
                        path.move(to: CGPoint(x: 0, y: touchY))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: touchY))
                    }
                    .stroke(accentColor.opacity(0.6), lineWidth: 1)
                    .transition(.opacity)
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { drag in
                        if !isDragging {
                            isDragging = true
                        }
                        
                        let newX = max(0, min(1, drag.location.x / geometry.size.width))
                        let newY = max(0, min(1, 1.0 - (drag.location.y / geometry.size.height)))
                        
                        value = CGPoint(x: newX, y: newY)
                    }
                    .onEnded { _ in
                        isDragging = false
                    }
            )
        }
        .frame(width: 200, height: 200)
        .clipShape(Rectangle())
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct XYPadDotted1_Previews: PreviewProvider {
    @State static var position = CGPoint(x: 0.5, y: 0.5)
    
    public static var previews: some View {
        XYPadDotted1(value: $position)
            .theme(.audioUI)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
