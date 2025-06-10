import SwiftUI
import CoreMotion
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct OrientationDiagram: View {
    @StateObject private var motion = MotionData()
    @Environment(\.theme) private var theme
    
    // Enhanced theme-based colors - utilizing rich palette
    private var primaryColor: Color { theme.look.textPrimary }
    private var secondaryColor: Color { theme.look.textSecondary }
    private var backgroundColor: Color { theme.look.surfacePrimary }
    private var accentColor: Color { theme.look.accent }
    private var successColor: Color { theme.look.stateSuccess }
    private var errorColor: Color { theme.look.stateError }
    
    // Additional rich color palette utilization
    private var brandPrimary: Color { theme.look.brandPrimary }
    private var brandSecondary: Color { theme.look.brandSecondary }
    private var glowPrimary: Color { theme.look.glowPrimary }
    private var interactiveActive: Color { theme.look.interactiveActive }
    private var surfaceElevated: Color { theme.look.surfaceElevated }
    private var neutralDivider: Color { theme.look.neutralDivider }
    private var warningColor: Color { theme.look.stateWarning }
    
    public var body: some View {
        ZStack {
            // Background gradient
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            backgroundColor.opacity(0.8),
                            backgroundColor.opacity(0.4)
                        ],
                        center: .center,
                        startRadius: 50,
                        endRadius: 150
                    )
                )
                .frame(width: 300, height: 300)
            
            // Gimbal rings with enhanced visual feedback
            ForEach(Array(rings.enumerated()), id: \.offset) { index, ring in
                Circle()
                    .stroke(
                        LinearGradient(
                            colors: [
                                ring.color.opacity(0.8 + abs(ring.getValue()) * 0.4),
                                ring.color.opacity(0.3 + abs(ring.getValue()) * 0.3)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 3 + abs(ring.getValue()) * 2
                    )
                    .frame(width: ring.size, height: ring.size)
                    .rotation3DEffect(
                        .degrees(ring.rotation(motion)),
                        axis: ring.axis
                    )
                    .shadow(color: ring.color, radius: abs(ring.getValue()) * 10, x: 0, y: 0)
                    .scaleEffect(1.0 + abs(ring.getValue()) * 0.1)
            }
            
            // Center sphere with enhanced recalibrate functionality
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            motion.isRecalibrating ? accentColor : primaryColor.opacity(0.9),
                            motion.isRecalibrating ? accentColor.opacity(0.5) : primaryColor.opacity(0.3)
                        ],
                        center: .topLeading,
                        startRadius: 5,
                        endRadius: 35
                    )
                )
                .frame(width: 70, height: 70)
                .overlay(
                    Circle()
                        .stroke(
                            motion.isRecalibrating ? accentColor : primaryColor.opacity(0.2),
                            lineWidth: motion.isRecalibrating ? 2 : 1
                        )
                )
                .overlay(
                    // Recalibrate icon
                    Image(systemName: motion.isRecalibrating ? "checkmark.circle.fill" : "gyroscope")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(motion.isRecalibrating ? primaryColor : secondaryColor.opacity(0.7))
                )
                .scaleEffect(motion.isRecalibrating ? 0.9 : 1.0)
                .shadow(color: motion.isRecalibrating ? accentColor : Color.clear, radius: motion.isRecalibrating ? 10 : 0, x: 0, y: 0)
                .onTapGesture {
                    motion.recalibrate()
                }
            
            // Axis indicators
            VStack(spacing: 100) {
                indicator(label: "Y", color: successColor, value: motion.pitch)
                    .offset(y: -20)
                
                HStack(spacing: 100) {
                    indicator(label: "Z", color: accentColor, value: motion.yaw)
                        .offset(x: -20)
                    
                    indicator(label: "X", color: errorColor, value: motion.roll)
                        .offset(x: 20)
                }
                .offset(y: 20)
            }
            
            // Value display
            VStack(spacing: 4) {
                valueText("R", motion.roll, errorColor)
                valueText("P", motion.pitch, successColor)
                valueText("Y", motion.yaw, accentColor)
            }
            .font(.system(size: 11, weight: .medium, design: .monospaced))
            .offset(y: 170)
        }
        .frame(width: 350, height: 350)
        .onAppear { motion.start() }
        .onDisappear { motion.stop() }
    }
    
    // Ring configurations with enhanced visual feedback
    private var rings: [(color: Color, size: CGFloat, axis: (x: CGFloat, y: CGFloat, z: CGFloat), rotation: (MotionData) -> Double, getValue: () -> Double)] {
        [
            (accentColor, 250, (0, 1, 0), { $0.yaw * 180 }, { motion.yaw }),
            (successColor, 200, (1, 0, 0), { $0.pitch * 90 }, { motion.pitch }),
            (errorColor, 150, (0, 0, 1), { $0.roll * 180 }, { motion.roll })
        ]
    }
    
    private func indicator(label: String, color: Color, value: Double) -> some View {
        ZStack {
            // Background circle
            Circle()
                .fill(color.opacity(0.15))
                .frame(width: 40, height: 40)
            
            // Bipolar fill for X-axis (roll), unipolar for others
            if label == "X" {
                // Bipolar display for X-axis (roll)
                Circle()
                    .trim(from: 0, to: 0.5)
                    .stroke(color.opacity(0.3), lineWidth: 3)
                    .frame(width: 45, height: 45)
                    .rotationEffect(.degrees(-90))
                
                // Active portion based on value direction
                Circle()
                    .trim(from: value >= 0 ? 0.5 : (0.5 + value), to: value >= 0 ? (0.5 + value) : 0.5)
                    .stroke(
                        LinearGradient(
                            colors: [color.opacity(0.6), color],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 4
                    )
                    .frame(width: 45, height: 45)
                    .rotationEffect(.degrees(-90))
                    .shadow(color: color, radius: abs(value) * 8, x: 0, y: 0)
            } else {
                // Unipolar display for Y and Z axes
                Circle()
                    .trim(from: 0, to: abs(value))
                    .stroke(
                        LinearGradient(
                            colors: [color.opacity(0.6), color],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 4
                    )
                    .frame(width: 45, height: 45)
                    .rotationEffect(.degrees(-90))
                    .shadow(color: color, radius: abs(value) * 8, x: 0, y: 0)
            }
            
            Text(label)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(color)
                .shadow(color: color.opacity(0.5), radius: 2, x: 0, y: 0)
        }
        .scaleEffect(1.0 + abs(value) * 0.3) // Make movement more apparent
    }
    
    private func valueText(_ label: String, _ value: Double, _ color: Color) -> some View {
        HStack(spacing: 4) {
            Text(label)
                .foregroundColor(color)
            // Show bipolar format for X-axis (roll), regular format for others
            if label == "R" {
                Text(String(format: "%+.1f°", value * 180))
                    .foregroundColor(value >= 0 ? successColor : errorColor)
                    .font(.system(size: 11, weight: .medium, design: .monospaced))
            } else {
                Text(String(format: "%.1f°", abs(value) * 180))
                    .foregroundColor(primaryColor.opacity(0.8))
                    .font(.system(size: 11, weight: .medium, design: .monospaced))
            }
        }
    }
}

// Minimal motion manager
class MotionData: ObservableObject {
#if os(iOS)
    private let motion = CMMotionManager()
#endif
    
    @Published var roll: Double = 0
    @Published var pitch: Double = 0
    @Published var yaw: Double = 0
    @Published var isRecalibrating: Bool = false
    
    // Calibration offsets
    private var rollOffset: Double = 0
    private var pitchOffset: Double = 0
    private var yawOffset: Double = 0
    
    func start() {
#if os(iOS)
        guard motion.isDeviceMotionAvailable else { return }
        motion.deviceMotionUpdateInterval = 1/60
        motion.startDeviceMotionUpdates(to: .main) { [weak self] data, _ in
            guard let attitude = data?.attitude else { return }
            self?.roll = (attitude.roll / .pi) - (self?.rollOffset ?? 0)
            self?.pitch = (attitude.pitch / .pi) - (self?.pitchOffset ?? 0)
            self?.yaw = (attitude.yaw / .pi) - (self?.yawOffset ?? 0)
        }
#else
        // Simulate motion on macOS for testing
        startSimulation()
#endif
    }
    
    func stop() {
#if os(iOS)
        motion.stopDeviceMotionUpdates()
#endif
    }
    
    func recalibrate() {
        isRecalibrating = true
        
#if os(iOS)
        // On iOS, capture current attitude as the new "zero" point
        if let attitude = motion.deviceMotion?.attitude {
            rollOffset = attitude.roll / .pi
            pitchOffset = attitude.pitch / .pi
            yawOffset = attitude.yaw / .pi
        }
#else
        // On macOS, just reset to zero
        rollOffset = 0
        pitchOffset = 0
        yawOffset = 0
#endif
        
        // Reset current values to zero
        roll = 0
        pitch = 0
        yaw = 0
        
        //        // Visual feedback
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        //            self.isRecalibrating = false
        //        }
    }
    
#if os(macOS)
    private func startSimulation() {
        // Enhanced simulation for macOS testing with more dramatic movement
        Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { _ in
            let time = Date().timeIntervalSince1970
            // More dramatic bipolar movement for roll (X-axis)
            self.roll = sin(time * 0.5) * 0.6 - self.rollOffset
            // Unipolar-like movement for pitch and yaw
            self.pitch = abs(cos(time * 0.3)) * 0.4 - self.pitchOffset
            self.yaw = abs(sin(time * 0.2)) * 0.5 - self.yawOffset
        }
    }
#endif
}


@available(iOS 18.0, macOS 15.0, *)
public struct OrientationDiagram_Previews: PreviewProvider {
    public static var previews: some View {
        OrientationDiagram()
            .theme(.audioUI)
            .preferredColorScheme(.dark)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
 
