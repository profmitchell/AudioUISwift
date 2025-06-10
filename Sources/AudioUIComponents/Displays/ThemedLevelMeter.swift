import SwiftUI
import AudioUICore
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *) public struct ThemedLevelMeter: View {
    public let level: Double
    public let peak: Double?
    public let label: String?
    public let orientation: Axis
    public let size: CGSize

    @Environment(\.theme) private var theme

    public init(
        level: Double,
        peak: Double? = nil,
        label: String? = nil,
        orientation: Axis = .vertical,
        size: CGSize = CGSize(width: 20, height: 200)
    ) {
        self.level = level
        self.peak = peak
        self.label = label
        self.orientation = orientation
        self.size = size
    }

    public var body: some View {
        VStack(spacing: 4) {
            if let label = label {
                Text(label)
                    .font(.caption)
                    .foregroundColor(theme.look.textSecondary)
            }

            LevelMeter(
                level: level,
                peak: peak,
                orientation: orientation,
                size: size
            )
            .overlay(
                RoundedRectangle(cornerRadius: 2)
                    .stroke(theme.look.glassBorder, lineWidth: 1)
            )
        }
    }
}
