import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct DrumPadNeumorphic3: View {
    @State private var isPressed = false
    @State private var padDepth: CGFloat = 0
    @State private var cornerScale: CGFloat = 1.0
    @State private var impactIntensity: CGFloat = 0
    
    @Environment(\.theme) private var theme
    
    // Enhanced theme-derived colors - utilizing rich palette
    private var baseColor: Color {
        theme.look.surfacePrimary
    }
    
    private var darkShadow: Color {
        theme.look.shadowDark
    }
    
    private var lightShadow: Color {
        theme.look.shadowLight
    }
    
    private var textColor: Color {
        theme.look.textPrimary
    }
    
    // Additional rich color palette utilization
    private var frameColor: Color {
        theme.look.controlBackground
    }
    
    private var activeStateColor: Color {
        theme.look.padActive
    }
    
    private var inactiveStateColor: Color {
        theme.look.padInactive
    }
    
    private var highlightColor: Color {
        theme.look.neutralHighlight
    }
    
    private var pressedAccent: Color {
        theme.look.brandPrimary
    }
    
    private var cornerDetailColor: Color {
        theme.look.glassBorder
    }
    
    private var gridColor: Color {
        theme.look.neutralDivider
    }
    
    private var glowColor: Color {
        theme.look.glowPrimary
    }
    
    private var surfaceElevated: Color {
        theme.look.surfaceElevated
    }
    
    private var interactiveHover: Color {
        theme.look.interactiveHover
    }
    
    private var interactivePressed: Color {
        theme.look.interactivePressed
    }
    
    private var brandGradientStart: Color {
        theme.look.brandPrimary
    }
    
    private var brandGradientEnd: Color {
        theme.look.brandSecondary
    }
    
    public let label: String?
    public let size: CGFloat
    public let action: (() -> Void)?
    
    public init(
        label: String? = nil,
        size: CGFloat = 120,
        action: (() -> Void)? = nil
    ) {
        self.label = label
        self.size = size
        self.action = action
    }
    
    public var body: some View {
        VStack(spacing: 12) {
            Text(label ?? "")
                .font(.system(size: 11, weight: .semibold, design: .rounded))
                .tracking(1.2)
                .foregroundColor(isPressed ? pressedAccent : textColor)
                .opacity(isPressed ? 0.9 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: isPressed)
            
            ZStack {
                // Enhanced outer frame with brand colors
                RoundedRectangle(cornerRadius: 18)
                    .fill(
                        LinearGradient(
                            colors: [
                                frameColor,
                                surfaceElevated,
                                theme.look.controlBackground
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 110, height: 110)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(
                                LinearGradient(
                                    colors: [cornerDetailColor, theme.look.glassBorder],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1.5
                            )
                    )
                
                // Deep pad well with enhanced gradient
                RoundedRectangle(cornerRadius: 15)
                    .fill(
                        LinearGradient(
                            colors: [
                                isPressed ? interactivePressed.opacity(0.6) : darkShadow.opacity(0.45),
                                isPressed ? activeStateColor.opacity(0.8) : baseColor.opacity(0.65),
                                isPressed ? brandGradientStart.opacity(0.4) : lightShadow.opacity(0.35)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 100, height: 100)
                    .overlay(
                        // Enhanced corner details with brand accents
                        ZStack {
                            ForEach(0..<4) { i in
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                cornerDetailColor.opacity(0.6),
                                                isPressed ? brandGradientStart.opacity(0.8) : darkShadow.opacity(0.3)
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 8, height: 8)
                                    .overlay(
                                        Circle()
                                            .stroke(highlightColor.opacity(0.4), lineWidth: 0.5)
                                    )
                                    .offset(
                                        x: i % 2 == 0 ? -40 : 40,
                                        y: i < 2 ? -40 : 40
                                    )
                                    .scaleEffect(cornerScale)
                            }
                        }
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(
                                isPressed ? brandGradientEnd.opacity(0.7) : darkShadow.opacity(0.5), 
                                lineWidth: 2.5
                            )
                            .blur(radius: 2)
                            .offset(x: 2.5, y: 2.5)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(
                                isPressed ? glowColor.opacity(0.8) : lightShadow, 
                                lineWidth: 2.5
                            )
                            .blur(radius: 2)
                            .offset(x: -2.5, y: -2.5)
                    )
                
                // Enhanced pad surface with rich color gradients
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        LinearGradient(
                            colors: [
                                isPressed ? interactivePressed.opacity(0.85) : inactiveStateColor.opacity(0.98),
                                isPressed ? activeStateColor.opacity(0.80) : baseColor.opacity(0.94),
                                isPressed ? brandGradientStart.opacity(0.75) : surfaceElevated.opacity(0.9)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 80, height: 80)
                    .overlay(
                        // Grid pattern overlay
                        ZStack {
                            ForEach(0..<3) { row in
                                ForEach(0..<3) { col in
                                    RoundedRectangle(cornerRadius: 3)
                                        .stroke(darkShadow.opacity(isPressed ? 0.2 : 0.1), lineWidth: 0.5)
                                        .frame(width: 24, height: 24)
                                        .offset(
                                            x: CGFloat(col - 1) * 26,
                                            y: CGFloat(row - 1) * 26
                                        )
                                }
                            }
                        }
                        .opacity(0.5)
                    )
                    .overlay(
                        // Pressure gradient
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                RadialGradient(
                                    colors: [
                                        darkShadow.opacity(isPressed ? 0.3 : 0),
                                        Color.clear
                                    ],
                                    center: .center,
                                    startRadius: 0,
                                    endRadius: 40
                                )
                            )
                    )
                    .shadow(
                        color: isPressed ? darkShadow.opacity(0.4) : darkShadow.opacity(0.7),
                        radius: isPressed ? 2 : 8,
                        x: isPressed ? 1 : 5,
                        y: isPressed ? 1 : 5
                    )
                    .shadow(
                        color: isPressed ? lightShadow.opacity(0.5) : lightShadow,
                        radius: isPressed ? 2 : 8,
                        x: isPressed ? -1 : -5,
                        y: isPressed ? -1 : -5
                    )
                    .offset(y: padDepth)
                    .scaleEffect(isPressed ? 0.96 : 1.0)
            }
            .animation(.spring(response: 0.08, dampingFraction: 0.6), value: isPressed)
            .animation(.spring(response: 0.15), value: cornerScale)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !isPressed {
                            triggerPadDown()
                        }
                    }
                    .onEnded { _ in
                        triggerPadUp()
                    }
            )
        }
        .frame(width: size, height: 140)
    }
    
    private func triggerPadDown() {
        withAnimation(.easeOut(duration: 0.05)) {
            isPressed = true
            padDepth = 6
            cornerScale = 0.9
        }
        
        // Trigger action immediately on press down
        action?()
    }
    
    private func triggerPadUp() {
        withAnimation(.easeOut(duration: 0.15)) {
            isPressed = false
            padDepth = 0
            cornerScale = 1.0
        }
    }
}

// Self-contained preview
@available(iOS 18.0, macOS 15.0, *)
public struct DrumPadNeumorphic3_Previews: PreviewProvider {
    public static var previews: some View {
        HStack(spacing: 20) {
            VStack(spacing: 15) {
                DrumPadNeumorphic3(label: "PAD 1") {
                    print("Pad 1 hit!")
                }
                DrumPadNeumorphic3(label: "PAD 2") {
                    print("Pad 2 hit!")
                }
            }
            
            VStack(spacing: 15) {
                DrumPadNeumorphic3(label: "PAD 3") {
                    print("Pad 3 hit!")
                }
                DrumPadNeumorphic3(label: "PAD 4") {
                    print("Pad 4 hit!")
                }
            }
        }
        .theme(.audioUINeumorphic)
        .padding(40)
        .previewLayout(.sizeThatFits)
    }
}
