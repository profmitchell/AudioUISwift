import SwiftUI
import AudioUICore
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *) 
public struct GyroNeumorphic1: View {
    public let rotation: Binding<GyroRotation>
    
    @Environment(\.theme) private var theme
    @State private var animationPhase: Double = 0
    
    public init(rotation: Binding<GyroRotation>) {
        self.rotation = rotation
    }
    
    private var backgroundColor: Color {
        theme.look.surfaceElevated
    }
    
    private var lightShadow: Color {
        Color.white.opacity(0.6)
    }
    
    private var darkShadow: Color {
        Color.black.opacity(0.2)
    }
    
    private var sphereRadialGradient: RadialGradient {
        let centerX = 0.5 + rotation.wrappedValue.roll * 0.3
        let centerY = 0.5 + rotation.wrappedValue.pitch * 0.3
        
        return RadialGradient(
            colors: [
                theme.look.brandPrimary.opacity(0.1),
                theme.look.brandPrimary.opacity(0.3)
            ],
            center: UnitPoint(x: centerX, y: centerY),
            startRadius: 20,
            endRadius: 60
        )
    }
    
    private var mainContainer: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(backgroundColor)
            .shadow(color: lightShadow, radius: 6, x: -4, y: -4)
            .shadow(color: darkShadow, radius: 6, x: 4, y: 4)
    }
    
    private var sphereVisualization: some View {
        ZStack {
            // Outer sphere shadow
            Circle()
                .fill(backgroundColor)
                .frame(width: 120, height: 120)
                .shadow(color: darkShadow, radius: 4, x: 2, y: 2)
                .shadow(color: lightShadow, radius: 4, x: -2, y: -2)
            
            // Inner sphere with rotation visualization
            innerSphere
        }
    }
    
    private var innerSphere: some View {
        Circle()
            .fill(sphereRadialGradient)
            .frame(width: 100, height: 100)
            .overlay(rotationIndicators)
            .rotationEffect(.radians(rotation.wrappedValue.yaw))
    }
    
    private var rotationIndicators: some View {
        ZStack {
            // Pitch line
            Rectangle()
                .fill(theme.look.brandSecondary)
                .frame(width: 2, height: 60)
                .rotationEffect(.radians(rotation.wrappedValue.pitch))
            
            // Roll line
            Rectangle()
                .fill(theme.look.brandTertiary)
                .frame(width: 60, height: 2)
                .rotationEffect(.radians(rotation.wrappedValue.roll))
            
            // Center dot
            Circle()
                .fill(theme.look.textPrimary)
                .frame(width: 6, height: 6)
        }
    }
    
    private var dataCards: some View {
        HStack(spacing: 12) {
            neumorphicValueCard(label: "PITCH", value: rotation.wrappedValue.pitch * 180 / .pi, color: theme.look.brandPrimary)
            neumorphicValueCard(label: "ROLL", value: rotation.wrappedValue.roll * 180 / .pi, color: theme.look.brandSecondary)
            neumorphicValueCard(label: "YAW", value: rotation.wrappedValue.yaw * 180 / .pi, color: theme.look.brandTertiary)
        }
    }
    
    public var body: some View {
        ZStack {
            mainContainer
            
            VStack(spacing: 16) {
                sphereVisualization
                dataCards
            }
            .padding(20)
        }
        .onAppear {
            withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                animationPhase = 2 * .pi
            }
        }
    }
    
    @ViewBuilder
    private func neumorphicValueCard(label: String, value: Double, color: Color) -> some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.system(size: 8, weight: .medium))
                .foregroundColor(theme.look.textSecondary)
            
            Text("\(value, specifier: "%.1f")°")
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(color)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(backgroundColor)
                .shadow(color: lightShadow, radius: 2, x: -1, y: -1)
                .shadow(color: darkShadow, radius: 2, x: 1, y: 1)
        )
    }
}

// MARK: - Preview
@available(iOS 18.0, macOS 15.0, *)
struct GyroNeumorphic1_Previews: PreviewProvider {
    static var previews: some View {
        @State var rotation = GyroRotation(
            roll: -0.2,
            pitch: 0.3,
            yaw: 0.5
        )
        
        VStack(spacing: 20) {
            GyroNeumorphic1(rotation: $rotation)
                .frame(width: 220, height: 200)
            
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
