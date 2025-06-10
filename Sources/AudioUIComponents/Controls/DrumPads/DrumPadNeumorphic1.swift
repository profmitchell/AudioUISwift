import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct DrumPadNeumorphic1: View {
    @State private var isPressed = false
    @State private var padDepth: CGFloat = 0
    @State private var impactScale: CGFloat = 1.0
    @State private var animationScale: CGFloat = 1.0
    
    @Environment(\.theme) private var theme
    
    // Theme-derived colors
    private var baseColor: Color {
        theme.look.surfacePrimary
    }
    
    private var darkShadow: Color {
        theme.look.shadowDark
    }
    
    private var lightShadow: Color {
        theme.look.shadowLight
    }
    
    private var padColor: Color {
        theme.look.surfaceSecondary
    }
    
    private var textColor: Color {
        theme.look.textPrimary
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
        HStack {
            Spacer()
            VStack(spacing: 15) {
                Text(label ?? "")
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .tracking(1.5)
                    .foregroundColor(textColor)
                
                ZStack {
                // Pad housing/rim
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            colors: [
                                darkShadow.opacity(0.5),
                                baseColor.opacity(0.6),
                                lightShadow.opacity(0.4)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: size, height: size)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(darkShadow.opacity(0.6), lineWidth: 3)
                            .blur(radius: 2)
                            .offset(x: 3, y: 3)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(lightShadow, lineWidth: 3)
                            .blur(radius: 2)
                            .offset(x: -3, y: -3)
                    )
                
                // Inner rim bevel
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            colors: [
                                darkShadow.opacity(0.3),
                                Color.clear
                            ],
                            startPoint: .bottomTrailing,
                            endPoint: .topLeading
                        )
                    )
                    .frame(width: size - 20, height: size - 20)
                
                // Rubber pad surface
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            colors: [
                                padColor,
                                padColor.opacity(0.95),
                                padColor.opacity(0.9)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: size - 20, height: size - 20)
                    .overlay(
                        // Subtle surface texture
                        RoundedRectangle(cornerRadius: 12)
                            .fill(
                                RadialGradient(
                                    colors: [
                                        lightShadow.opacity(0.05), // Changed from Color.white
                                        Color.clear,
                                        darkShadow.opacity(0.05)
                                    ],
                                    center: .topLeading,
                                    startRadius: 10,
                                    endRadius: 60
                                )
                            )
                    )
                    .shadow(
                        color: isPressed ? Color.clear : darkShadow.opacity(0.8),
                        radius: isPressed ? 0 : 8,
                        x: isPressed ? 0 : 5,
                        y: isPressed ? 0 : 5
                    )
                    .shadow(
                        color: isPressed ? Color.clear : lightShadow.opacity(0.9),
                        radius: isPressed ? 0 : 8,
                        x: isPressed ? 0 : -5,
                        y: isPressed ? 0 : -5
                    )
                    .offset(y: padDepth)
                    .scaleEffect(impactScale)
            }
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.06, dampingFraction: 0.7), value: isPressed)
            .animation(.spring(response: 0.08, dampingFraction: 0.6), value: impactScale)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !isPressed {
                            triggerPad()
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.easeOut(duration: 0.15)) {
                            isPressed = false
                            padDepth = 0
                            impactScale = 1.0
                        }
                    }
            )
            }
            Spacer()
        }
        .frame(width: size + 40, height: size + 40) // Extra space for centering
    }
    
    private func triggerPad() {
        withAnimation(.easeOut(duration: 0.05)) {
            isPressed = true
            padDepth = 6
            impactScale = 0.94
        }
        
        action?()
        
        #if canImport(UIKit)
        let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
        impactFeedback.impactOccurred()
        #endif
    }
}

// Self-contained preview
@available(iOS 18.0, macOS 15.0, *)
public struct DrumPadNeumorphic1_Previews: PreviewProvider {
    public static var previews: some View {
        HStack(spacing: 20) {
            DrumPadNeumorphic1(label: "KICK") {
                print("KICK hit!")
            }
            DrumPadNeumorphic1(label: "SNARE") {
                print("SNARE hit!")
            }
            DrumPadNeumorphic1(label: "HAT") {
                print("HAT hit!")
            }
        }
        .theme(.audioUINeumorphic)
        .padding(40)
        .previewLayout(.sizeThatFits)
    }
}
