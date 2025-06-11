//
//  DrumPadDotted1.swift
//  AudioUI
//
//  Created by Mitchell Cohen on 6/3/25.
//


//
//  DrumPadDotted1.swift
//  AudioUI
//
//  Created by Mitchell Cohen on 6/3/25.
//

import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct DrumPadDotted1: View {
    @State private var isPressed = false
    @State private var showTap = false
    @State private var dots: [Bool] = Array(repeating: false, count: 9)
    @Environment(\.theme) private var theme
    
    // Theme-derived colors
    private var padBG: Color { theme.look.padInactive }
    private var padBorderColor: Color { theme.look.glassBorder }
    private var padMainShadow: Color { theme.look.shadowDark }
    private var activeDot: Color { theme.look.interactiveActive }
    private var inactiveDot: Color { theme.look.textDisabled }
    private var centerTapText: Color { theme.look.textSecondary }
    private var activeStatusLine: Color { theme.look.accent }
    private var inactiveStatusLine: Color { theme.look.textDisabled }
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 40) {
            // Dot matrix pad
            ZStack {
                // Background
                Circle()
                    .fill(padBG)
                    .frame(width: 180, height: 180)
                    .overlay(
                        Circle()
                            .stroke(padBorderColor, lineWidth: isPressed ? 3 : 1)
                    )
                    .shadow(
                        color: padMainShadow.opacity(isPressed ? 0.4 : 0.05),
                        radius: isPressed ? 20 : 5,
                        x: 0,
                        y: isPressed ? 6 : 2
                    )
                
                // Dot grid
                VStack(spacing: 20) {
                    ForEach(0..<3) { row in
                        HStack(spacing: 20) {
                            ForEach(0..<3) { col in
                                Circle()
                                    .fill(
                                        dots[row * 3 + col] ? activeDot : inactiveDot
                                    )
                                    .frame(width: 8, height: 8)
                                    .scaleEffect(dots[row * 3 + col] ? 1.8 : 1.0)
                                    .animation(
                                        .spring(response: 0.3)
                                        .delay(Double(row * 3 + col) * 0.02),
                                        value: dots[row * 3 + col]
                                    )
                            }
                        }
                    }
                }
                
                // Center area - no text displayed
            }
            .scaleEffect(isPressed ? 0.93 : 1.0)
            .animation(.spring(response: 0.15, dampingFraction: 0.8), value: isPressed)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !isPressed {
                            triggerDots()
                        }
                    }
                    .onEnded { _ in
                        isPressed = false
                    }
            )
            
            // Status line
            HStack(spacing: 4) {
                ForEach(0..<3) { index in
                    Rectangle()
                        .fill(index == 1 && isPressed ? activeStatusLine : inactiveStatusLine)
                        .frame(width: 30, height: 1)
                }
            }
        }
        .frame(width: 260, height: 280)
    }
    
    private func triggerDots() {
        isPressed = true
        
        // Animate dots from center outward
        let center = 4
        dots[center] = true
        
        for ring in 1...2 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(ring) * 0.05) {
                if ring == 1 {
                    dots[1] = true; dots[3] = true
                    dots[5] = true; dots[7] = true
                } else {
                    dots[0] = true; dots[2] = true
                    dots[6] = true; dots[8] = true
                }
            }
        }
        
#if canImport(UIKit)
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
#endif
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            dots = Array(repeating: false, count: 9)
        }
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct DrumPadDotted1_Previews: PreviewProvider {
    public static var previews: some View {
        DrumPadDotted1()
            .theme(.audioUI)
            .background(Theme.audioUI.look.backgroundPrimary)
            .previewLayout(.sizeThatFits)
    }
}
