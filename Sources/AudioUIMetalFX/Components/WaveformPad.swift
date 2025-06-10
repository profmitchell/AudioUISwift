import SwiftUI
import AudioUICore

@available(iOS 17.0, macOS 14.0, *) public struct WaveformPad: View {
    @Binding public var isPressed: Bool
    public let size: CGFloat

    public init(
        isPressed: Binding<Bool>,
        size: CGFloat = 100
    ) {
        self._isPressed = isPressed
        self.size = size
    }

    public var body: some View {
        PadButton(isPressed: $isPressed, size: size)
            .waveDistortion(
                amplitude: isPressed ? 5.0 : 0.0,
                frequency: 0.1,
                speed: 4.0
            )
            .animation(.spring(response: 0.3), value: isPressed)
    }
}
