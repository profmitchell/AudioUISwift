import SwiftUI

public struct PadButton: View {
    @Binding public var isPressed: Bool
    public let size: CGFloat
    public let cornerRadius: CGFloat
    public let onTap: (() -> Void)?

    public init(
        isPressed: Binding<Bool>,
        size: CGFloat = 80,
        cornerRadius: CGFloat = 8,
        onTap: (() -> Void)? = nil
    ) {
        self._isPressed = isPressed
        self.size = size
        self.cornerRadius = cornerRadius
        self.onTap = onTap
    }

    @State private var isPressing = false

    public var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(isPressed || isPressing ? .primary : .quaternary)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(.secondary, lineWidth: 2)
            )
            .frame(width: size, height: size)
            .scaleEffect(isPressing ? 0.95 : 1.0)
            .brightness(isPressed ? 0.2 : 0)
            .animation(.spring(response: 0.15, dampingFraction: 0.7), value: isPressing)
            .animation(.spring(response: 0.15, dampingFraction: 0.7), value: isPressed)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !isPressing {
                            isPressing = true
                            isPressed = true
                            onTap?() // Trigger immediately on tap down
                        }
                    }
                    .onEnded { _ in
                        isPressing = false
                        isPressed = false
                    }
            )
    }
}
