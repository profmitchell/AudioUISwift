import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct ControlGroup<Content: View>: View {
    public let title: String?
    public let content: Content

    @Environment(\.theme) private var theme

    public init(
        title: String? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let title = title {
                Text(title)
                    .font(.headline)
                    .foregroundColor(theme.look.textPrimary)
            }

            content
        }
        .padding()
        .themedContainer()
    }
}
