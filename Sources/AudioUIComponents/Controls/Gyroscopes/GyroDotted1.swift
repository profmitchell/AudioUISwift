import SwiftUI
import AudioUICore
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *) 
public struct GyroDotted1: View {
    public let rotation: Binding<GyroRotation>
    
    @Environment(\.theme) private var theme
    @State private var animationOffset: CGFloat = 0
    
    public init(rotation: Binding<GyroRotation>) {
        self.rotation = rotation
    }
    
    private let dotSize: CGFloat = 1.5
    private let spacing: CGFloat = 6
    
    public var body: some View {
        ZStack {
            // Background dot matrix
            Canvas { context, size in
                let centerX = size.width / 2
                let centerY = size.height / 2
                let radius = min(size.width, size.height) / 2 - 20
                
                // Create dot matrix in circles
                for ring in 1...5 {
                    let ringRadius = radius * CGFloat(ring) / 5
                    let dotCount = ring * 8
                    
                    for i in 0..<dotCount {
                        let angle = (Double(i) / Double(dotCount)) * 2 * .pi
                        let x = centerX + cos(angle) * ringRadius
                        let y = centerY + sin(angle) * ringRadius
                        
                        let opacity = 0.2 + sin(animationOffset + Double(ring)) * 0.1
                        
                        context.fill(
                            Path(ellipseIn: CGRect(x: x-dotSize/2, y: y-dotSize/2, width: dotSize, height: dotSize)),
                            with: .color(theme.look.brandPrimary.opacity(opacity))
                        )
                    }
                }
            }
            .background(theme.look.surfaceElevated)
            
            // Central gyroscope indicator with dots
            VStack(spacing: 8) {
                // Pitch indicator
                HStack {
                    Text("PITCH")
                        .font(.system(size: 8, weight: .medium))
                        .foregroundColor(theme.look.textSecondary)
                    Spacer()
                    Text("\(rotation.wrappedValue.pitch * 180 / .pi, specifier: "%.1f")°")
                        .font(.system(size: 8, weight: .medium))
                        .foregroundColor(theme.look.textPrimary)
                }
                
                // Central dot pattern 
                Canvas { context, size in
                    let centerX = size.width / 2
                    let centerY = size.height / 2
                    
                    // Create a 5x5 dot grid
                    for row in 0..<5 {
                        for col in 0..<5 {
                            let x = CGFloat(col) * spacing - spacing * 2 + centerX
                            let y = CGFloat(row) * spacing - spacing * 2 + centerY
                            
                            // Intensity based on distance from center and rotation
                            let distanceFromCenter = sqrt(pow(x - centerX, 2) + pow(y - centerY, 2))
                            let normalizedDistance = distanceFromCenter / 20
                            let rotationIntensity = abs(rotation.wrappedValue.roll) + abs(rotation.wrappedValue.pitch)
                            let opacity = 0.3 + (1.0 - normalizedDistance) * 0.4 + rotationIntensity * 0.3
                            
                            context.fill(
                                Path(ellipseIn: CGRect(x: x-dotSize, y: y-dotSize, width: dotSize*2, height: dotSize*2)),
                                with: .color(theme.look.brandPrimary.opacity(min(opacity, 1.0)))
                            )
                        }
                    }
                }
                .frame(width: 60, height: 60)
                
                // Roll indicator
                HStack {
                    Text("ROLL")
                        .font(.system(size: 8, weight: .medium))
                        .foregroundColor(theme.look.textSecondary)
                    Spacer()
                    Text("\(rotation.wrappedValue.roll * 180 / .pi, specifier: "%.1f")°")
                        .font(.system(size: 8, weight: .medium))
                        .foregroundColor(theme.look.textPrimary)
                }
                
                // Yaw indicator
                HStack {
                    Text("YAW")
                        .font(.system(size: 8, weight: .medium))
                        .foregroundColor(theme.look.textSecondary)
                    Spacer()
                    Text("\(rotation.wrappedValue.yaw * 180 / .pi, specifier: "%.1f")°")
                        .font(.system(size: 8, weight: .medium))
                        .foregroundColor(theme.look.textPrimary)
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(theme.look.surfaceElevated.opacity(0.9))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(theme.look.glassBorder, lineWidth: 1)
                    )
            )
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(theme.look.glassBorder, lineWidth: 1)
        )
        .onAppear {
            withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                animationOffset = 2 * .pi
            }
        }
    }
}

// MARK: - Preview
@available(iOS 18.0, macOS 15.0, *)
struct GyroDotted1_Previews: PreviewProvider {
    static var previews: some View {
        @State var rotation = GyroRotation(
            roll: -0.1,
            pitch: 0.2,
            yaw: 0.3
        )
        
        VStack(spacing: 20) {
            GyroDotted1(rotation: $rotation)
                .frame(width: 200, height: 200)
            
            // Controls for testing
            VStack {
                HStack {
                    Text("Pitch:")
                    Slider(value: Binding(
                        get: { rotation.pitch },
                        set: { rotation.pitch = $0 }
                    ), in: -1...1)
                }
                HStack {
                    Text("Roll:")
                    Slider(value: Binding(
                        get: { rotation.roll },
                        set: { rotation.roll = $0 }
                    ), in: -1...1)
                }
                HStack {
                    Text("Yaw:")
                    Slider(value: Binding(
                        get: { rotation.yaw },
                        set: { rotation.yaw = $0 }
                    ), in: -1...1)
                }
            }
            .padding()
        }
        .padding()
        .theme(.audioUI)
    }
}
