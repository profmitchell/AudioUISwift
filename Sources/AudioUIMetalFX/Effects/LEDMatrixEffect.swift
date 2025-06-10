import SwiftUI

@available(iOS 17.0, macOS 14.0, *) public struct LEDMatrixEffect: ViewModifier {
    public let pixelSize: Double

    public init(pixelSize: Double = 4.0) {
        self.pixelSize = pixelSize
    }

    public func body(content: Content) -> some View {
        content
            .layerEffect(
                ShaderLibrary.bundle(.module).ledMatrix(
                    .float(pixelSize)
                ),
                maxSampleOffset: .zero
            )
    }
}

@available(iOS 17.0, macOS 14.0, *)
public extension View {
    func ledMatrix(pixelSize: Double = 4.0) -> some View {
        modifier(LEDMatrixEffect(pixelSize: pixelSize))
    }
}
