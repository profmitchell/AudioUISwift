import SwiftUI
import AudioUICore
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *) public struct StatusBar: View {
    public struct StatusItem {
        public let label: String
        public let value: String
        public let isActive: Bool

        public init(label: String, value: String, isActive: Bool = false) {
            self.label = label
            self.value = value
            self.isActive = isActive
        }
    }

    public let items: [StatusItem]

    @Environment(\.theme) private var theme

    public init(items: [StatusItem]) {
        self.items = items
    }

    public var body: some View {
        HStack(spacing: 20) {
            statusItemsView
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .themedContainer()
    }
    
    @ViewBuilder
    private var statusItemsView: some View {
        if !items.isEmpty {
            statusItem(for: items[0], showDivider: items.count > 1)
        }
        if items.count > 1 {
            statusItem(for: items[1], showDivider: items.count > 2)
        }
        if items.count > 2 {
            statusItem(for: items[2], showDivider: items.count > 3)
        }
        if items.count > 3 {
            statusItem(for: items[3], showDivider: items.count > 4)
        }
        if items.count > 4 {
            statusItem(for: items[4], showDivider: items.count > 5)
        }
        // Add more as needed for typical use cases
    }
    
    @ViewBuilder
    private func statusItem(for item: StatusItem, showDivider: Bool) -> some View {
        HStack(spacing: 8) {
            LED(
                isOn: item.isActive,
                color: theme.look.stateSuccess,
                size: 8
            )

            Text(item.label)
                .font(.caption)
                .foregroundColor(theme.look.textSecondary)

            Text(item.value)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(
                    item.isActive ?
                    theme.look.textPrimary :
                    theme.look.textTertiary
                )
        }

        if showDivider {
            Divider()
                .frame(height: 16)
                .overlay(theme.look.textTertiary.opacity(0.3))
        }
    }
}
