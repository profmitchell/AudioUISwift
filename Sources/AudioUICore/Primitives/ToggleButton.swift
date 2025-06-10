import SwiftUI

public struct ToggleButton: View {
    @Binding public var isOn: Bool
    public let size: CGSize
    public let style: ToggleButtonStyle
    public let onToggle: ((Bool) -> Void)?

    public enum ToggleButtonStyle {
        case rounded
        case square
        case pill
    }

    public init(
        isOn: Binding<Bool>,
        size: CGSize = CGSize(width: 60, height: 40),
        style: ToggleButtonStyle = .rounded,
        onToggle: ((Bool) -> Void)? = nil
    ) {
        self._isOn = isOn
        self.size = size
        self.style = style
        self.onToggle = onToggle
    }

    private var shape: some Shape {
        switch style {
        case .rounded:
            return AnyShape(RoundedRectangle(cornerRadius: 8))
        case .square:
            return AnyShape(Rectangle())
        case .pill:
            return AnyShape(Capsule())
        }
    }

    public var body: some View {
        Button(action: { 
            isOn.toggle()
            onToggle?(isOn)
        }) {
            ZStack {
                shape
                    .fill(isOn ? .primary : .quaternary)
                    .frame(width: size.width, height: size.height)

                shape
                    .stroke(.secondary, lineWidth: 2)
                    .frame(width: size.width, height: size.height)
            }
        }
        .buttonStyle(.plain)
    }
}

// Helper for type erasure
struct AnyShape: Shape {
    private let _path: @Sendable (CGRect) -> Path

    init<S: Shape>(_ shape: S) {
        _path = { rect in
            shape.path(in: rect)
        }
    }

    func path(in rect: CGRect) -> Path {
        _path(rect)
    }
}
