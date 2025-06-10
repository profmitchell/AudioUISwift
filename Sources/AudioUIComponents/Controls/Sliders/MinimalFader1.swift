import SwiftUI
import AudioUICore
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *) public struct MinimalFader1: View {
    @Binding public var value: Double
    public let range: ClosedRange<Double>
    public let height: CGFloat
    public let label: String?
    public let onValueChange: ((Double) -> Void)?
    
    public init(
        value: Binding<Double>,
        range: ClosedRange<Double> = 0...1,
        height: CGFloat = 120,
        label: String? = nil,
        onValueChange: ((Double) -> Void)? = nil
    ) {
        self._value = value
        self.range = range
        self.height = height
        self.label = label
        self.onValueChange = onValueChange
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            // Fader primitive with minimal theming
            Fader(
                value: $value,
                orientation: .vertical,
                size: CGSize(width: 40, height: height)
            )
            .themedContainer()
            
            // Optional label
            if let label = label {
                Text(label)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    if #available(iOS 18.0, macOS 15.0, *) {
        MinimalFader1(
            value: .constant(0.7),
            label: "Volume"
        )
        .frame(width: 60, height: 160)
    }
} 