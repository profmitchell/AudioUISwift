//
//  XYPadMinimal3.swift
//  AudioUI
//
//  Created by Mitchell Cohen on 6/3/25.
//

import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct XYPadMinimal3: View {
    @State private var position: CGPoint = CGPoint(x: 0.5, y: 0.5)
    @State private var isDragging = false
    @State private var trails: [[CGPoint]] = [[], [], [], [], []] // Multiple trails
    @State private var lastUpdateTime = Date()
    @Environment(\.theme) private var theme
    
    // Enhanced theme-based colors - utilizing rich palette
    private var primaryColor: Color { theme.look.textPrimary }
    private var secondaryColor: Color { theme.look.textSecondary }
    private var backgroundColor: Color { theme.look.surfacePrimary }
    
    // Additional rich color palette utilization
    private var brandPrimary: Color { theme.look.brandPrimary }
    private var brandSecondary: Color { theme.look.brandSecondary }
    private var accent: Color { theme.look.accent }
    private var glowAccent: Color { theme.look.glowAccent }
    private var neutralDivider: Color { theme.look.neutralDivider }
    private var interactiveActive: Color { theme.look.interactiveActive }
    private var surfaceElevated: Color { theme.look.surfaceElevated }
    private var glassBorder: Color { theme.look.glassBorder }
    
    private let padSize: CGFloat = 300
    private let trailCount = 5
    
    public init(value: Binding<CGPoint>) {
        self._position = State(initialValue: CGPoint(x: value.wrappedValue.x, y: value.wrappedValue.y))
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            // Top value bar
            HStack {
                Text("Y")
                    .font(.system(size: 11, weight: .medium, design: .default))
                    .foregroundColor(secondaryColor)
                    .frame(width: 20)
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(secondaryColor.opacity(0.2))
                            .frame(height: 2)
                        
                        Rectangle()
                            .fill(primaryColor)
                            .frame(width: (1 - position.y) * geometry.size.width, height: 2)
                            .animation(.interactiveSpring(response: 0.2), value: position.y)
                    }
                }
                .frame(height: 20)
                
                Text(String(format: "%.2f", 1 - position.y))
                    .font(.system(size: 12, weight: .regular, design: .monospaced))
                    .foregroundColor(primaryColor)
                    .frame(width: 40, alignment: .trailing)
            }
            .frame(width: padSize)
            .padding(.bottom, 10)
            
            HStack(spacing: 0) {
                // Left value bar
                VStack {
                    Text("X")
                        .font(.system(size: 11, weight: .medium, design: .default))
                        .foregroundColor(secondaryColor)
                        .rotationEffect(.degrees(-90))
                        .frame(height: 20)
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .bottom) {
                            Rectangle()
                                .fill(secondaryColor.opacity(0.2))
                                .frame(width: 2)
                            
                            Rectangle()
                                .fill(primaryColor)
                                .frame(width: 2, height: position.x * geometry.size.height)
                                .animation(.interactiveSpring(response: 0.2), value: position.x)
                        }
                    }
                    
                    Text(String(format: "%.2f", position.x))
                        .font(.system(size: 12, weight: .regular, design: .monospaced))
                        .foregroundColor(primaryColor)
                        .rotationEffect(.degrees(-90))
                        .frame(height: 40)
                }
                .frame(width: 20)
                .padding(.trailing, 10)
                
                // XY Pad
                ZStack {
                    // Background with corner marks
                    Rectangle()
                        .fill(backgroundColor)
                        .frame(width: padSize, height: padSize)
                        .overlay(
                            ZStack {
                                // Corner marks
                                ForEach(0..<4) { index in
                                    CornerMark()
                                        .stroke(primaryColor.opacity(0.3), lineWidth: 1)
                                        .frame(width: 20, height: 20)
                                        .rotationEffect(.degrees(Double(index) * 90))
                                        .offset(
                                            x: index % 2 == 0 ? (index == 0 ? -140 : 140) : (index == 1 ? 140 : -140),
                                            y: index < 2 ? -140 : 140
                                        )
                                }
                            }
                        )
                    
                    // Multiple trails with different characteristics
                    ForEach(0..<trailCount, id: \.self) { index in
                        Path { path in
                            guard !trails[index].isEmpty else { return }
                            path.move(to: trails[index][0])
                            for point in trails[index].dropFirst() {
                                path.addLine(to: point)
                            }
                        }
                        .stroke(
                            primaryColor.opacity(getTrailOpacity(index)),
                            style: StrokeStyle(
                                lineWidth: getTrailWidth(index),
                                lineCap: .round,
                                lineJoin: .round
                            )
                        )
                    }
                    
                    // Position indicator
                    ZStack {
                        // Outer ring pulse
                        Circle()
                            .stroke(primaryColor, lineWidth: 1)
                            .frame(width: 20, height: 20)
                            .scaleEffect(isDragging ? 1.5 : 1.0)
                            .opacity(isDragging ? 0.5 : 0)
                        
                        // Spark effect when dragging - Fixed animation issue
                        if isDragging {
                            ForEach(0..<3, id: \.self) { index in
                                Circle()
                                    .fill(primaryColor.opacity(0.3))
                                    .frame(width: 4, height: 4)
                                    .offset(
                                        x: sin(Double(index) * 2.0) * 10,
                                        y: cos(Double(index) * 2.0) * 10
                                    )
                            }
                        }
                        
                        // Center dot
                        Circle()
                            .fill(primaryColor)
                            .frame(width: 8, height: 8)
                            .scaleEffect(isDragging ? 1.2 : 1.0)
                    }
                    .position(
                        x: position.x * padSize,
                        y: position.y * padSize
                    )
                    .animation(.interactiveSpring(response: 0.2), value: isDragging)
                }
                .frame(width: padSize, height: padSize)
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            isDragging = true
                            updatePosition(value.location)
                            updateTrails(value.location)
                        }
                        .onEnded { _ in
                            isDragging = false
                            fadeTrails()
                        }
                )
            }
        }
        .frame(width: 360, height: 360)
    }
    
    private func getTrailOpacity(_ index: Int) -> Double {
        switch index {
        case 0: return 0.3
        case 1: return 0.25
        case 2: return 0.2
        case 3: return 0.15
        case 4: return 0.1
        default: return 0.1
        }
    }
    
    private func getTrailWidth(_ index: Int) -> CGFloat {
        switch index {
        case 0: return 1.5
        case 1: return 1.2
        case 2: return 1.0
        case 3: return 0.8
        case 4: return 0.5
        default: return 0.5
        }
    }
    
    private func updatePosition(_ location: CGPoint) {
        position = CGPoint(
            x: max(0, min(1, location.x / padSize)),
            y: max(0, min(1, location.y / padSize))
        )
    }
    
    private func updateTrails(_ location: CGPoint) {
        let currentTime = Date()
        let timeDelta = currentTime.timeIntervalSince(lastUpdateTime)
        
        // Only update if enough time has passed (creates spacing between trail points)
        if timeDelta > 0.02 {
            lastUpdateTime = currentTime
            
            let basePoint = CGPoint(
                x: max(0, min(padSize, location.x)),
                y: max(0, min(padSize, location.y))
            )
            
            // Add points to each trail with slight variations
            for i in 0..<trailCount {
                let offset = CGFloat(i - 2) * 2 // Spread trails slightly
                let angle = atan2(
                    trails[i].last?.y ?? basePoint.y - basePoint.y,
                    trails[i].last?.x ?? basePoint.x - basePoint.x
                )
                
                let perpAngle = angle + .pi / 2
                let trailPoint = CGPoint(
                    x: basePoint.x + cos(perpAngle) * offset,
                    y: basePoint.y + sin(perpAngle) * offset
                )
                
                trails[i].append(trailPoint)
                
                // Keep trail length limited (different lengths for variety)
                let maxLength = 15 + i * 3
                if trails[i].count > maxLength {
                    trails[i].removeFirst()
                }
            }
        }
    }
    
    private func fadeTrails() {
        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
            var allEmpty = true
            
            for i in 0..<trailCount {
                if !trails[i].isEmpty {
                    trails[i].removeFirst()
                    allEmpty = false
                }
            }
            
            if allEmpty {
                timer.invalidate()
            }
        }
    }
}

public struct CornerMark: Shape {
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct XYPadMinimal3_Previews: PreviewProvider {
    public static var previews: some View {
        XYPadMinimal3(value: .constant(CGPoint(x: 0.5, y: 0.5)))
            .theme(.audioUI)
            .previewLayout(.sizeThatFits)
    }
}
