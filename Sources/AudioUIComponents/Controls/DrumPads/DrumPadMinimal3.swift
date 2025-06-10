//
//  DrumPadMinimal3.swift
//  AudioUI
//
//  Created by Mitchell Cohen on 6/3/25.
//


//
//  DrumPadMinimal3.swift
//  AudioUI
//
//  Created by Mitchell Cohen on 6/3/25.
//

import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct DrumPadMinimal3: View {
    @State private var isPressed = false
    @State private var ringScale: CGFloat = 1.0
    @State private var ringOpacity: Double = 0
    @State private var showTap = false
    @State private var showWaves = false
    @Environment(\.theme) private var theme
    
    // Theme-derived colors
    private var padFillColor: Color { theme.look.padInactive }
    private var padBorderColor: Color { isPressed ? theme.look.accent : theme.look.interactiveIdle.opacity(0.5) }
    private var ringEffectColor: Color { theme.look.glowAccent }
    private var cornerMarkingColor: Color { theme.look.textTertiary }
    private var idTextColor: Color { theme.look.textPrimary }
    private var idLineColor: Color { isPressed ? theme.look.accent : theme.look.textDisabled }
    private var dataLabelTextColor: Color { theme.look.textSecondary }
    private var dataValueTextColor: Color { theme.look.textPrimary }
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 35) {
            // Geometric pad
            ZStack {
                // Base square
                Rectangle()
                    .fill(padFillColor)
                    .frame(width: 150, height: 150)
                    .overlay(
                        Rectangle()
                            .stroke(
                                padBorderColor,
                                lineWidth: isPressed ? 4 : 1
                            )
                    )
                    .scaleEffect(isPressed ? 0.94 : 1.0)
                    .shadow(
                        color: theme.look.shadowDark.opacity(isPressed ? 0.4 : 0.1),
                        radius: isPressed ? 15 : 4,
                        x: 0,
                        y: isPressed ? 5 : 2
                    )
                
                // Expanding ring
                Rectangle()
                    .stroke(ringEffectColor.opacity(ringOpacity), lineWidth: 2)
                    .frame(width: 150 * ringScale, height: 150 * ringScale)
                
                // Corner marks
                VStack {
                    HStack {
                        cornerMark(topLeft: true)
                        Spacer()
                        cornerMark(topRight: true)
                    }
                    Spacer()
                    HStack {
                        cornerMark(bottomLeft: true)
                        Spacer()
                        cornerMark(bottomRight: true)
                    }
                }
                .frame(width: 130, height: 130)
                .opacity(isPressed ? 1.0 : 0.3)
                .scaleEffect(isPressed ? 1.1 : 1.0)
                
                // ID
                VStack(spacing: 4) {
                    Text("01")
                        .font(.system(size: 24, weight: isPressed ? .bold : .regular, design: .monospaced))
                        .foregroundColor(dataValueTextColor)
                        .scaleEffect(isPressed ? 0.95 : 1.0)
                    
                    Rectangle()
                        .fill(idLineColor)
                        .frame(width: isPressed ? 45 : 30, height: 1)
                }
            }
            .animation(.easeInOut(duration: 0.1), value: isPressed)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !isPressed {
                            trigger()
                        }
                    }
                    .onEnded { _ in
                        isPressed = false
                    }
            )
            
            // Minimal data - Static values
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("VEL")
                        .font(.system(size: 9, weight: .medium))
                        .foregroundColor(dataLabelTextColor)
                    Text("127")
                        .font(.system(size: 12, weight: .regular, design: .monospaced))
                        .foregroundColor(dataValueTextColor)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("NOTE")
                        .font(.system(size: 9, weight: .medium))
                        .foregroundColor(dataLabelTextColor)
                    Text("C3")
                        .font(.system(size: 12, weight: .regular, design: .monospaced))
                        .foregroundColor(dataValueTextColor)
                }
            }
            .opacity(0.8) // Static opacity
        }
        .frame(width: 220, height: 280)
    }
    
    private func cornerMark(topLeft: Bool = false, topRight: Bool = false, 
                           bottomLeft: Bool = false, bottomRight: Bool = false) -> some View {
        Path { path in
            if topLeft {
                path.move(to: CGPoint(x: 0, y: 10))
                path.addLine(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: 10, y: 0))
            } else if topRight {
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: 10, y: 0))
                path.addLine(to: CGPoint(x: 10, y: 10))
            } else if bottomLeft {
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: 0, y: 10))
                path.addLine(to: CGPoint(x: 10, y: 10))
            } else if bottomRight {
                path.move(to: CGPoint(x: 10, y: 0))
                path.addLine(to: CGPoint(x: 10, y: 10))
                path.addLine(to: CGPoint(x: 0, y: 10))
            }
        }
        .stroke(cornerMarkingColor, lineWidth: 2)
        .frame(width: 10, height: 10)
    }
    
    private func trigger() {
        isPressed = true
        
        // Ring animation
        ringScale = 1.0
        ringOpacity = 0.8
        withAnimation(.easeOut(duration: 0.5)) {
            ringScale = 1.4
            ringOpacity = 0
        }
        
#if canImport(UIKit)
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
#endif
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct DrumPadMinimal3_Previews: PreviewProvider {
    public static var previews: some View {
        DrumPadMinimal3()
            .theme(.audioUI)
            .background(Theme.audioUI.look.backgroundPrimary)
            .previewLayout(.sizeThatFits)
    }
}
