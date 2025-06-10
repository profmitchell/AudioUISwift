import SwiftUI

@available(iOS 17.0, macOS 14.0, *) public struct WaveDistortionEffect: ViewModifier {
    public let amplitude: Double
    public let frequency: Double
    public let speed: Double
    @State private var time: Double = 0

    public init(amplitude: Double = 10.0, frequency: Double = 0.1, speed: Double = 2.0) {
        self.amplitude = amplitude
        self.frequency = frequency
        self.speed = speed
    }

    public func body(content: Content) -> some View {
        TimelineView(.animation) { context in
            content
                .distortionEffect(
                    ShaderLibrary.bundle(.module).waveDistortion(
                        .float(context.date.timeIntervalSinceReferenceDate),
                        .float(amplitude),
                        .float(frequency),
                        .float(speed)
                    ),
                    maxSampleOffset: CGSize(width: amplitude * 2, height: 0)
                )
        }
    }
}

@available(iOS 17.0, macOS 14.0, *)
public extension View {
    func waveDistortion(amplitude: Double = 10.0, frequency: Double = 0.1, speed: Double = 2.0) -> some View {
        modifier(WaveDistortionEffect(amplitude: amplitude, frequency: frequency, speed: speed))
    }
}
