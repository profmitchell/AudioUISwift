import SwiftUI
import AudioUICore

@available(iOS 17.0, macOS 14.0, *) public struct SpectrumVisualizer: View {
    public let intensity: Double
    public let barCount: Int
    @State private var time: Double = 0

    public init(intensity: Double = 0.8, barCount: Int = 32) {
        self.intensity = intensity
        self.barCount = barCount
    }

    public var body: some View {
        TimelineView(.animation) { context in
            Rectangle()
                .foregroundStyle(
                    ShaderLibrary.bundle(.module).spectrumVisualizer(
                        .float(context.date.timeIntervalSinceReferenceDate),
                        .float(intensity)
                    )
                )
        }
    }
}
