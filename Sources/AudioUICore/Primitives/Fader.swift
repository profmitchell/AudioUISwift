import SwiftUI

public struct Fader: View {
    @Binding public var value: Double
    public let orientation: Axis
    public let size: CGSize

    public init(
        value: Binding<Double>,
        orientation: Axis = .vertical,
        size: CGSize = CGSize(width: 40, height: 200)
    ) {
        self._value = value
        self.orientation = orientation
        self.size = size
    }

    @State private var isDragging = false

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: orientation == .vertical ? .bottom : .leading) {
                // Track
                RoundedRectangle(cornerRadius: 4)
                    .fill(.quaternary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(.secondary, lineWidth: 1)
                    )

                // Fill
                RoundedRectangle(cornerRadius: 4)
                    .fill(.primary.opacity(0.8))
                    .frame(
                        width: orientation == .vertical ? geometry.size.width : geometry.size.width * value,
                        height: orientation == .vertical ? geometry.size.height * value : geometry.size.height
                    )

                // Thumb
                RoundedRectangle(cornerRadius: 2)
                    .fill(.primary)
                    .frame(
                        width: orientation == .vertical ? geometry.size.width - 4 : 20,
                        height: orientation == .vertical ? 20 : geometry.size.height - 4
                    )
                    .position(
                        x: orientation == .vertical ? geometry.size.width / 2 : geometry.size.width * value,
                        y: orientation == .vertical ? geometry.size.height * (1 - value) : geometry.size.height / 2
                    )
                    .shadow(radius: isDragging ? 4 : 2)
            }
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        isDragging = true
                        if orientation == .vertical {
                            let newValue = 1 - (gesture.location.y / geometry.size.height)
                            value = max(0, min(1, newValue))
                        } else {
                            let newValue = gesture.location.x / geometry.size.width
                            value = max(0, min(1, newValue))
                        }
                    }
                    .onEnded { _ in
                        isDragging = false
                    }
            )
        }
        .frame(width: size.width, height: size.height)
    }
}
