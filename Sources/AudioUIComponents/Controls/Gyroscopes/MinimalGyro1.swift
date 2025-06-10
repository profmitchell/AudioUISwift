import SwiftUI
import AudioUICore
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *) public struct MinimalGyro1: View {
    @Binding public var rotation: GyroRotation
    @State private var isTracking = false
    public let size: CGFloat
    public let onRotationChange: ((GyroRotation) -> Void)?
    
    @Environment(\.theme) private var theme
    
    // Enhanced theme-based colors - utilizing rich palette
    private var surfacePrimary: Color { theme.look.surfacePrimary }
    private var textPrimary: Color { theme.look.textPrimary }
    private var textSecondary: Color { theme.look.textSecondary }
    private var glassBorder: Color { theme.look.glassBorder }
    private var brandPrimary: Color { theme.look.brandPrimary }
    private var brandSecondary: Color { theme.look.brandSecondary }
    private var accent: Color { theme.look.accent }
    private var interactiveActive: Color { theme.look.interactiveActive }
    private var glowPrimary: Color { theme.look.glowPrimary }
    private var surfaceElevated: Color { theme.look.surfaceElevated }
    
    public init(
        rotation: Binding<GyroRotation>,
        size: CGFloat = 300,
        onRotationChange: ((GyroRotation) -> Void)? = nil
    ) {
        self._rotation = rotation
        self.size = size
        self.onRotationChange = onRotationChange
    }
    
    public var body: some View {
        ZStack {
            // Clean background
            RoundedRectangle(cornerRadius: size * 0.1)
                .fill(theme.look.surfacePrimary)
                .frame(width: size * 1.27, height: size * 1.27)
                .themedContainer()
            
            VStack(spacing: size * 0.05) {
                // Main visualization using primitive
                ZStack {
                    // Crosshair with enhanced colors
                    Path { path in
                        let halfSize = size * 0.4
                        path.move(to: CGPoint(x: 0, y: -halfSize))
                        path.addLine(to: CGPoint(x: 0, y: halfSize))
                        path.move(to: CGPoint(x: -halfSize, y: 0))
                        path.addLine(to: CGPoint(x: halfSize, y: 0))
                    }
                    .stroke(brandSecondary.opacity(0.5), lineWidth: 1.5)
                    
                    // Reference circle with brand colors
                    Circle()
                        .stroke(
                            LinearGradient(
                                colors: [glassBorder.opacity(0.3), brandPrimary.opacity(0.2)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 2
                        )
                        .frame(width: size * 0.67, height: size * 0.67)
                    
                    // Motion indicator with glow
                    ZStack {
                        Circle()
                            .fill(glowPrimary.opacity(0.3))
                            .frame(width: 16, height: 16)
                            .blur(radius: 2)
                        
                        Circle()
                            .fill(accent)
                            .frame(width: 12, height: 12)
                    }
                    .offset(
                        x: rotation.roll * size * 0.26,
                        y: -rotation.pitch * size * 0.26 // Inverted pitch for UI
                    )
                    .animation(.smooth(duration: 0.1), value: rotation.roll)
                    .animation(.smooth(duration: 0.1), value: rotation.pitch)
                    
                    // Yaw arc with gradient
                    Circle()
                        .trim(from: 0, to: 0.25)
                        .stroke(
                            LinearGradient(
                                colors: [brandPrimary, accent],
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            style: StrokeStyle(lineWidth: 3, lineCap: .round)
                        )
                        .frame(width: size * 0.8, height: size * 0.8)
                        .rotationEffect(.degrees(rotation.yaw * 180 - 45))
                        .animation(.smooth(duration: 0.1), value: rotation.yaw)
                    
                    // Hidden primitive for motion tracking
                    GyroscopePrimitive(
                        rotation: $rotation,
                        size: CGSize(width: size, height: size),
                        onRotationChange: onRotationChange
                    )
                    .opacity(0.01)
                }
                
                // Minimal data display
                HStack(spacing: size * 0.1) {
                    dataPoint("R", rotation.roll * 180)
                    dataPoint("P", rotation.pitch * 180)
                    dataPoint("Y", rotation.yaw * 180)
                }
            }
        }
        .frame(width: size * 1.33, height: size * 1.33)
    }
    
    private func dataPoint(_ label: String, _ value: Double) -> some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.system(size: 11, weight: .regular))
                .foregroundColor(theme.look.textSecondary.opacity(0.6))
            
            Text(String(format: "%.1f°", value))
                .font(.system(size: 16, weight: .light))
                .foregroundColor(theme.look.textPrimary)
                .monospacedDigit()
                .frame(minWidth: size * 0.2, alignment: .center) // Adjust minWidth based on typical content
        }
    }
} 