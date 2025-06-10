//
//  DrumPadMinimal1.swift
//  AudioUI
//
//  Created by Mitchell Cohen on 6/3/25.
//


//
//  DrumPadMinimal1.swift
//  AudioUI
//
//  Created by Mitchell Cohen on 6/3/25.
//

import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct DrumPadMinimal1: View {
    @State private var isPressed = false
    @State private var showTap = false
    @Environment(\.theme) private var theme
    
    // Theme-derived colors
    private var unpressedPadFill: Color { theme.look.padInactive }
    private var pressedPadFill: Color { theme.look.padActive }
    private var padBorder: Color { theme.look.interactiveIdle }
    private var labelText: Color { theme.look.textPrimary } 
    private var tapEffect: Color { theme.look.glowAccent.opacity(0.5) } // Added opacity for subtlety if glowAccent is strong
    private var activityLine: Color { theme.look.accent }
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 30) {
            // Ultra-clean pad
            ZStack {
                // Base
                RoundedRectangle(cornerRadius: 8)
                    .fill(isPressed ? pressedPadFill : unpressedPadFill)
                    .frame(width: 160, height: 160)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(padBorder, lineWidth: isPressed ? 3 : 1)
                    )
                    .scaleEffect(isPressed ? 0.92 : 1.0)
                    .shadow(
                        color: theme.look.shadowDark.opacity(isPressed ? 0.4 : 0.1),
                        radius: isPressed ? 12 : 4,
                        x: 0,
                        y: isPressed ? 4 : 2
                    )
                
                // Tap indicator
                if showTap {
                    Circle()
                        .fill(tapEffect)
                        .frame(width: 80, height: 80)
                        .scaleEffect(showTap ? 2.5 : 0)
                        .opacity(showTap ? 0 : 1)
                }
                
                // Label
                Text("A")
                    .font(.system(size: 32, weight: .light, design: .default))
                    .foregroundColor(labelText)
                    .scaleEffect(isPressed ? 0.9 : 1.0)
            }
            .animation(.easeOut(duration: 0.1), value: isPressed)
            .animation(.easeOut(duration: 0.4), value: showTap)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !isPressed {
                            tap()
                        }
                    }
                    .onEnded { _ in
                        isPressed = false
                    }
            )
            
            // Minimal indicator
            Rectangle()
                .fill(activityLine)
                .frame(width: isPressed ? 60 : 20, height: 2)
                .animation(.spring(response: 0.3), value: isPressed)
        }
        .frame(width: 240, height: 240)
    }
    
    private func tap() {
        isPressed = true
        showTap = true
        
#if canImport(UIKit)
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
#endif
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            showTap = false
        }
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct DrumPadMinimal1_Previews: PreviewProvider {
    public static var previews: some View {
        DrumPadMinimal1()
            .background(Theme.audioUI.look.backgroundPrimary)
            .previewLayout(.sizeThatFits)
    }
}
