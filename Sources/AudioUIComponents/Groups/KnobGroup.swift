import SwiftUI
import AudioUICore
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *) public struct KnobGroup: View {
    public struct KnobConfig {
        public let label: String
        public let binding: Binding<Double>
        public let range: ClosedRange<Double>

        public init(
            label: String,
            binding: Binding<Double>,
            range: ClosedRange<Double> = 0...1
        ) {
            self.label = label
            self.binding = binding
            self.range = range
        }
    }

    public let title: String?
    public let knobs: [KnobConfig]
    public let knobSize: CGFloat

    @Environment(\.theme) private var theme

    public init(
        title: String? = nil,
        knobs: [KnobConfig],
        knobSize: CGFloat = 50
    ) {
        self.title = title
        self.knobs = knobs
        self.knobSize = knobSize
    }

    public var body: some View {
        ControlGroup(title: title) {
            HStack(spacing: 16) {
                ForEach(Array(knobs.enumerated()), id: \.offset) { index, config in
                    VStack(spacing: 8) {
                        KnobMinimal1(value: config.binding)
                            .frame(width: knobSize, height: knobSize)
                        
                        Text(config.label)
                            .font(.caption2)
                            .foregroundColor(theme.look.textSecondary)
                    }
                }
            }
        }
    }
}
