//
//  ToggleButtonNeumorphic1.swift
//  AudioUI
//
//  Created by Mitchell Cohen on 12/23/25.
//

import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct ToggleButtonNeumorphic1: View {
    @Binding var isOn: Bool
    let onIcon: String
    let offIcon: String
    let onColor: Color?
    let offColor: Color?
    let size: CGFloat
    
    @Environment(\.theme) private var theme
    @State private var isPressed = false
    
    // Theme-derived colors
    private var baseColor: Color { theme.look.surfacePrimary }
    private var accentColor: Color { theme.look.brandPrimary }
    private var textColor: Color { theme.look.textPrimary }
    private var shadowDark: Color { theme.look.shadowDark }
    private var shadowLight: Color { theme.look.shadowLight }
    
    public init(
        isOn: Binding<Bool>,
        onIcon: String = "power",
        offIcon: String = "power",
        onColor: Color? = nil,
        offColor: Color? = nil,
        size: CGFloat = 80
    ) {
        self._isOn = isOn
        self.onIcon = onIcon
        self.offIcon = offIcon
        self.onColor = onColor
        self.offColor = offColor
        self.size = size
    }
    
    public var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                isOn.toggle()
            }
        }) {
            ZStack {
                // Outer neumorphic container
                Circle()
                    .fill(baseColor)
                    .frame(width: size, height: size)
                    .overlay(
                        Circle()
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        shadowLight.opacity(0.8),
                                        shadowDark.opacity(0.3)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    )
                    .shadow(color: shadowDark.opacity(0.3), radius: 8, x: 4, y: 6)
                    .shadow(color: shadowLight.opacity(0.9), radius: 8, x: -4, y: -6)
                
                // Inner button depression/elevation
                Circle()
                    .fill(
                        LinearGradient(
                            colors: isOn || isPressed ? [
                                shadowDark.opacity(0.4),
                                baseColor.opacity(0.8),
                                shadowLight.opacity(0.2)
                            ] : [
                                shadowLight.opacity(0.6),
                                baseColor,
                                shadowDark.opacity(0.2)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: size * 0.8, height: size * 0.8)
                    .overlay(
                        Circle()
                            .stroke(
                                isOn ? (onColor ?? accentColor).opacity(0.6) : shadowDark.opacity(0.1),
                                lineWidth: isOn ? 2 : 1
                            )
                    )
                    .shadow(
                        color: isOn || isPressed ? shadowLight.opacity(0.8) : shadowDark.opacity(0.4),
                        radius: isOn || isPressed ? 3 : 2,
                        x: isOn || isPressed ? -2 : 2,
                        y: isOn || isPressed ? -3 : 3
                    )
                    .shadow(
                        color: isOn || isPressed ? shadowDark.opacity(0.4) : shadowLight.opacity(0.8),
                        radius: isOn || isPressed ? 3 : 2,
                        x: isOn || isPressed ? 2 : -2,
                        y: isOn || isPressed ? 3 : -3
                    )
                
                // Icon
                Image(systemName: isOn ? onIcon : offIcon)
                    .font(.system(size: size * 0.25, weight: .medium))
                    .foregroundColor(
                        isOn ? (onColor ?? accentColor) : (offColor ?? textColor.opacity(0.7))
                    )
                    .scaleEffect(isPressed ? 0.9 : 1.0)
                
                // Active glow
                if isOn {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    (onColor ?? accentColor).opacity(0.3),
                                    (onColor ?? accentColor).opacity(0.1),
                                    Color.clear
                                ],
                                center: .center,
                                startRadius: 0,
                                endRadius: size * 0.5
                            )
                        )
                        .frame(width: size * 1.2, height: size * 1.2)
                        .blur(radius: 6)
                        .allowsHitTesting(false)
                }
                
                // Rim light when active
                if isOn {
                    Circle()
                        .stroke(
                            LinearGradient(
                                colors: [
                                    (onColor ?? accentColor).opacity(0.8),
                                    (onColor ?? accentColor).opacity(0.3),
                                    Color.clear,
                                    (onColor ?? accentColor).opacity(0.3)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 2
                        )
                        .frame(width: size * 0.9, height: size * 0.9)
                        .blur(radius: 1)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, perform: {}, onPressingChanged: { pressing in
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = pressing
            }
        })
        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: isOn)
        .animation(.easeInOut(duration: 0.1), value: isPressed)
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct ToggleButtonNeumorphic1_Previews: PreviewProvider {
    @State static var isPowerOn = false
    @State static var isRecording = false
    
    public static var previews: some View {
        VStack(spacing: 40) {
            ToggleButtonNeumorphic1(
                isOn: $isPowerOn,
                onIcon: "power",
                offIcon: "power",
                onColor: .green
            )
            
            ToggleButtonNeumorphic1(
                isOn: $isRecording,
                onIcon: "record.circle.fill",
                offIcon: "record.circle",
                onColor: .red
            )
        }
        .theme(.audioUI)
        .previewLayout(.sizeThatFits)
        .padding(60)
        .background(Color.gray.opacity(0.1))
    }
} 