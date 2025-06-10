import SwiftUI

public struct LevelMeter: View {
    public let level: Double // 0.0 to 1.0
    public let peak: Double?
    public let orientation: Axis
    public let size: CGSize

    public init(
        level: Double,
        peak: Double? = nil,
        orientation: Axis = .vertical,
        size: CGSize = CGSize(width: 20, height: 200)
    ) {
        self.level = level
        self.peak = peak
        self.orientation = orientation
        self.size = size
    }

    private var gradient: LinearGradient {
        LinearGradient(
            colors: [.green, .green, .yellow, .orange, .red],
            startPoint: orientation == .vertical ? .bottom : .leading,
            endPoint: orientation == .vertical ? .top : .trailing
        )
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: orientation == .vertical ? .bottom : .leading) {
                // Background
                Rectangle()
                    .fill(.black.opacity(0.8))
                    .overlay(
                        Rectangle()
                            .stroke(.secondary, lineWidth: 1)
                    )

                // Level
                Rectangle()
                    .fill(gradient)
                    .frame(
                        width: orientation == .vertical ? geometry.size.width : geometry.size.width * level,
                        height: orientation == .vertical ? geometry.size.height * level : geometry.size.height
                    )
                    .animation(.linear(duration: 0.05), value: level)

                // Peak indicator
                if let peak = peak {
                    Rectangle()
                        .fill(.white)
                        .frame(
                            width: orientation == .vertical ? geometry.size.width : 2,
                            height: orientation == .vertical ? 2 : geometry.size.height
                        )
                        .position(
                            x: orientation == .vertical ? geometry.size.width / 2 : geometry.size.width * peak,
                            y: orientation == .vertical ? geometry.size.height * (1 - peak) : geometry.size.height / 2
                        )
                }
            }
        }
        .frame(width: size.width, height: size.height)
    }
}
