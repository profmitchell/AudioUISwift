//
//  XYPadMinimal1.swift
//  AudioUI
//
//  Created by Mitchell Cohen on 6/10/25.
//

import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct XYPadMinimal1: View {
    @Binding public var value: CGPoint
    @State private var isDragging = false
    @Environment(\.theme) private var theme
    
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
                // Background
                Rectangle()
                    .fill(backgroundColor)
                    .overlay(
                        Rectangle()
                            .stroke(neutralDivider, lineWidth: 1)
                    )
                
                // Grid lines
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
                .stroke(secondaryColor.opacity(0.3), lineWidth: 1)
                
                // Quarter grid lines
                Path { path in
                    let quarterX = geometry.size.width / 4
                    let threeQuarterX = geometry.size.width * 3 / 4
                    let quarterY = geometry.size.height / 4
                    let threeQuarterY = geometry.size.height * 3 / 4
                    
                    // Vertical quarter lines
                    path.move(to: CGPoint(x: quarterX, y: 0))
                    path.addLine(to: CGPoint(x: quarterX, y: geometry.size.height))
                    path.move(to: CGPoint(x: threeQuarterX, y: 0))
                    path.addLine(to: CGPoint(x: threeQuarterX, y: geometry.size.height))
                    
                    // Horizontal quarter lines
                    path.move(to: CGPoint(x: 0, y: quarterY))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: quarterY))
                    path.move(to: CGPoint(x: 0, y: threeQuarterY))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: threeQuarterY))
                }
                .stroke(secondaryColor.opacity(0.15), lineWidth: 0.5)
                
                // Touch indicator
                Circle()
                    .fill(accentColor)
                    .frame(width: 16, height: 16)
                    .overlay(
                        Circle()
                            .stroke(primaryColor, lineWidth: 2)
                            .frame(width: 20, height: 20)
                    )
                    .position(
                        x: value.x * geometry.size.width,
                        y: (1.0 - value.y) * geometry.size.height
                    )
                    .scaleEffect(isDragging ? 1.2 : 1.0)
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
                    .stroke(accentColor.opacity(0.5), lineWidth: 1)
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
public struct XYPadMinimal1_Previews: PreviewProvider {
    @State static var position = CGPoint(x: 0.5, y: 0.5)
    
    public static var previews: some View {
        XYPadMinimal1(value: $position)
            .theme(.audioUI)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
