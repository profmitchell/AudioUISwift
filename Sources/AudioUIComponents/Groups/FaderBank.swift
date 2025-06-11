import SwiftUI
import AudioUICore
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *) public struct FaderBank: View {
    public struct FaderConfig {
        public let label: String
        public let binding: Binding<Double>

        public init(label: String, binding: Binding<Double>) {
            self.label = label
            self.binding = binding
        }
    }

    public let title: String?
    public let faders: [FaderConfig]
    public let faderHeight: CGFloat

    @Environment(\.theme) private var theme

    public init(
        title: String? = nil,
        faders: [FaderConfig],
        faderHeight: CGFloat = 150
    ) {
        self.title = title
        self.faders = faders
        self.faderHeight = faderHeight
    }

    public var body: some View {
        ControlGroup(title: title) {
            HStack(spacing: 12) {
                ForEach(Array(faders.enumerated()), id: \.offset) { index, config in
                    SliderMinimal1(
                        value: config.binding
                    )
                }
            }
        }
    }
}
