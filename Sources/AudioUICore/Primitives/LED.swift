import SwiftUI

public struct LED: View {
    public let isOn: Bool
    public let color: Color
    public let size: CGFloat

    public init(
        isOn: Bool,
        color: Color = .green,
        size: CGFloat = 12
    ) {
        self.isOn = isOn
        self.color = color
        self.size = size
    }

    public var body: some View {
        Circle()
            .fill(isOn ? color : color.opacity(0.2))
            .frame(width: size, height: size)
            .overlay(
                Circle()
                    .stroke(.secondary.opacity(0.5), lineWidth: 1)
            )
            .shadow(color: isOn ? color : .clear, radius: isOn ? size/3 : 0)
            .animation(.easeInOut(duration: 0.1), value: isOn)
    }
}
