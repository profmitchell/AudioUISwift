import SwiftUI

@available(iOS 17.0, macOS 14.0, *) public struct OscilloscopeView: View {
    public let lineColor: Color
    public let backgroundColor: Color

    public init(
        lineColor: Color = .green,
        backgroundColor: Color = .black
    ) {
        self.lineColor = lineColor
        self.backgroundColor = backgroundColor
    }

    public var body: some View {
        TimelineView(.animation) { context in
            Rectangle()
                .fill(backgroundColor)
                .overlay(
                    Rectangle()
                        .foregroundStyle(
                            ShaderLibrary.bundle(.module).oscilloscope(
                                .float(context.date.timeIntervalSinceReferenceDate),
                                .color(lineColor)
                            )
                        )
                )
        }
    }
}
