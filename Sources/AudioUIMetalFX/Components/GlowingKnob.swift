import SwiftUI
import AudioUICore

@available(iOS 17.0, macOS 14.0, *) public struct GlowingKnob: View {
    @Binding public var value: Double
    public let size: CGFloat
    public let glowColor: Color
    public let glowIntensity: Double

    public init(
        value: Binding<Double>,
        size: CGFloat = 100,
        glowColor: Color = .cyan,
        glowIntensity: Double = 1.0
    ) {
        self._value = value
        self.size = size
        self.glowColor = glowColor
        self.glowIntensity = glowIntensity
    }

    public var body: some View {
        Knob(value: $value, size: size)
            .knobGlow(
                value: value,
                intensity: glowIntensity,
                color: glowColor
            )
            .scaleEffect(1.0 + (value * 0.05)) // Slight scale based on value
            .animation(.easeInOut(duration: 0.2), value: value)
            .background(
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [glowColor.opacity(0.3), .clear],
                            center: .center,
                            startRadius: 0,
                            endRadius: size * 0.8
                        )
                    )
                    .scaleEffect(1.0 + (value * glowIntensity * 0.2))
                    .blur(radius: 8)
                    .animation(.easeInOut(duration: 0.3), value: value)
            )
    }
}

// MARK: - Enhanced Waveform Pad with Ripples

@available(iOS 17.0, macOS 14.0, *) public struct EnhancedWaveformPad: View {
    @Binding public var isPressed: Bool
    public let size: CGFloat
    public let rippleColor: Color

    public init(
        isPressed: Binding<Bool>,
        size: CGFloat = 100,
        rippleColor: Color = .cyan
    ) {
        self._isPressed = isPressed
        self.size = size
        self.rippleColor = rippleColor
    }

    public var body: some View {
        WaveformPad(isPressed: $isPressed, size: size)
            .padRipple(isPressed: isPressed, color: rippleColor)
            .particleEffect(
                intensity: isPressed ? 1.0 : 0.0,
                color: rippleColor
            )
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
    }
}

// MARK: - Audio Reactive Slider

@available(iOS 17.0, macOS 14.0, *) public struct AudioReactiveSlider: View {
    @Binding public var value: Double
    public let audioLevel: Double
    public let width: CGFloat
    public let height: CGFloat
    public let color: Color

    public init(
        value: Binding<Double>,
        audioLevel: Double = 0.0,
        width: CGFloat = 200,
        height: CGFloat = 40,
        color: Color = .cyan
    ) {
        self._value = value
        self.audioLevel = audioLevel
        self.width = width
        self.height = height
        self.color = color
    }

    public var body: some View {
        Slider(value: $value, in: 0...1)
            .frame(width: width, height: height)
            .accentColor(color)
            .audioReactiveBackground(level: audioLevel, color: color)
            .glowEffect(color: color, intensity: value + audioLevel)
            .cornerRadius(height / 2)
    }
}

// MARK: - Particle Button

@available(iOS 17.0, macOS 14.0, *) public struct ParticleButton: View {
    public let title: String
    public let action: () -> Void
    @State private var isPressed = false
    public let particleColor: Color

    public init(
        title: String,
        particleColor: Color = .cyan,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.particleColor = particleColor
        self.action = action
    }

    public var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3)) {
                isPressed = true
                action()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isPressed = false
            }
        }) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal, 30)
                .padding(.vertical, 15)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(particleColor.opacity(0.8))
                )
        }
        .particleEffect(
            intensity: isPressed ? 1.5 : 0.0,
            color: particleColor
        )
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .animation(.spring(response: 0.2), value: isPressed)
    }
}
