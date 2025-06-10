import SwiftUI

// MARK: - Enhanced Glow Effect

@available(iOS 17.0, macOS 14.0, *) public struct GlowEffect: ViewModifier {
    public let color: Color
    public let radius: CGFloat
    public let intensity: Double

    public init(color: Color = .blue, radius: CGFloat = 10, intensity: Double = 1.0) {
        self.color = color
        self.radius = radius
        self.intensity = intensity
    }

    public func body(content: Content) -> some View {
        content
            .foregroundStyle(
                ShaderLibrary.bundle(.module).glowEffect(
                    .float(intensity),
                    .color(color)
                )
            )
    }
}

// MARK: - Ripple Effect

@available(iOS 17.0, macOS 14.0, *) public struct RippleEffect: ViewModifier {
    public let intensity: Double
    public let center: CGPoint
    @State private var time: Double = 0

    public init(intensity: Double = 1.0, center: CGPoint = CGPoint(x: 0.5, y: 0.5)) {
        self.intensity = intensity
        self.center = center
    }

    public func body(content: Content) -> some View {
        TimelineView(.animation) { context in
            content
                .foregroundStyle(
                    ShaderLibrary.bundle(.module).rippleEffect(
                        .float(context.date.timeIntervalSinceReferenceDate),
                        .float(intensity),
                        .float4(Float(center.x), Float(center.y), 0, 0)
                    )
                )
        }
    }
}

// MARK: - Enhanced Knob Glow Effect

@available(iOS 17.0, macOS 14.0, *) public struct KnobGlowEffect: ViewModifier {
    public let knobValue: Double
    public let glowIntensity: Double
    public let glowColor: Color

    public init(knobValue: Double, glowIntensity: Double = 1.0, glowColor: Color = .cyan) {
        self.knobValue = knobValue
        self.glowIntensity = glowIntensity
        self.glowColor = glowColor
    }

    public func body(content: Content) -> some View {
        content
            .foregroundStyle(
                ShaderLibrary.bundle(.module).knobGlow(
                    .float(knobValue),
                    .float(glowIntensity),
                    .color(glowColor)
                )
            )
    }
}

// MARK: - Pad Ripple Effect

@available(iOS 17.0, macOS 14.0, *) public struct PadRippleEffect: ViewModifier {
    public let isPressed: Bool
    public let rippleColor: Color
    @State private var time: Double = 0

    public init(isPressed: Bool, rippleColor: Color = .cyan) {
        self.isPressed = isPressed
        self.rippleColor = rippleColor
    }

    public func body(content: Content) -> some View {
        TimelineView(.animation) { context in
            content
                .foregroundStyle(
                    ShaderLibrary.bundle(.module).padRipple(
                        .float(context.date.timeIntervalSinceReferenceDate),
                        .float(isPressed ? 1.0 : 0.0),
                        .color(rippleColor)
                    )
                )
        }
    }
}

// MARK: - Particle Effect

@available(iOS 17.0, macOS 14.0, *) public struct ParticleEffect: ViewModifier {
    public let intensity: Double
    public let particleColor: Color
    @State private var time: Double = 0

    public init(intensity: Double = 1.0, particleColor: Color = .cyan) {
        self.intensity = intensity
        self.particleColor = particleColor
    }

    public func body(content: Content) -> some View {
        TimelineView(.animation) { context in
            content
                .background(
                    Rectangle()
                        .foregroundStyle(
                            ShaderLibrary.bundle(.module).particleEffect(
                                .float(context.date.timeIntervalSinceReferenceDate),
                                .float(intensity),
                                .color(particleColor)
                            )
                        )
                        .blendMode(.plusLighter)
                )
        }
    }
}

// MARK: - Audio Reactive Background

@available(iOS 17.0, macOS 14.0, *) public struct AudioReactiveBackground: ViewModifier {
    public let audioLevel: Double
    public let baseColor: Color
    @State private var time: Double = 0

    public init(audioLevel: Double, baseColor: Color = .blue) {
        self.audioLevel = audioLevel
        self.baseColor = baseColor
    }

    public func body(content: Content) -> some View {
        TimelineView(.animation) { context in
            content
                .background(
                    Rectangle()
                        .foregroundStyle(
                            ShaderLibrary.bundle(.module).audioReactiveBackground(
                                .float(context.date.timeIntervalSinceReferenceDate),
                                .float(audioLevel),
                                .color(baseColor)
                            )
                        )
                        .opacity(0.3)
                )
        }
    }
}

// MARK: - View Extensions

@available(iOS 17.0, macOS 14.0, *)
public extension View {
    func glowEffect(color: Color = .blue, radius: CGFloat = 10, intensity: Double = 1.0) -> some View {
        modifier(GlowEffect(color: color, radius: radius, intensity: intensity))
    }
    
    func rippleEffect(intensity: Double = 1.0, center: CGPoint = CGPoint(x: 0.5, y: 0.5)) -> some View {
        modifier(RippleEffect(intensity: intensity, center: center))
    }
    
    func knobGlow(value: Double, intensity: Double = 1.0, color: Color = .cyan) -> some View {
        modifier(KnobGlowEffect(knobValue: value, glowIntensity: intensity, glowColor: color))
    }
    
    func padRipple(isPressed: Bool, color: Color = .cyan) -> some View {
        modifier(PadRippleEffect(isPressed: isPressed, rippleColor: color))
    }
    
    func particleEffect(intensity: Double = 1.0, color: Color = .cyan) -> some View {
        modifier(ParticleEffect(intensity: intensity, particleColor: color))
    }
    
    func audioReactiveBackground(level: Double, color: Color = .blue) -> some View {
        modifier(AudioReactiveBackground(audioLevel: level, baseColor: color))
    }
}
