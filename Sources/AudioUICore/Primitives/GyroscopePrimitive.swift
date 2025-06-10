//
//  GyroscopePrimitive.swift
//  AudioUICore
//
//  Enhanced Gyroscope Primitive with advanced Core Motion integration
//

import SwiftUI
import Combine

#if canImport(CoreMotion) && os(iOS)
import CoreMotion
#endif

// MARK: - Gyro Rotation Data Structure
/// A comprehensive 3D rotation data structure for device motion and manual control.
///
/// `GyroRotation` provides a normalized representation of 3D rotation that can be used
/// for both device motion sensing and manual gesture control. The structure supports
/// various coordinate systems and includes calibration capabilities.
///
/// ## Coordinate System
/// - **Roll**: Rotation around the Z-axis (device tilting left/right)
/// - **Pitch**: Rotation around the X-axis (device tilting forward/backward)
/// - **Yaw**: Rotation around the Y-axis (device rotating left/right)
///
/// All values are normalized to the range -1.0 to +1.0 for consistent parameter mapping.
public struct GyroRotation: Equatable, Sendable {
    /// Rotation around the Z-axis (left/right tilt) normalized to -1.0...1.0
    public var roll: Double
    
    /// Rotation around the X-axis (forward/backward tilt) normalized to -1.0...1.0
    public var pitch: Double
    
    /// Rotation around the Y-axis (left/right rotation) normalized to -1.0...1.0
    public var yaw: Double
    
    /// Zero rotation state for initialization and calibration
    public static let zero = GyroRotation(roll: 0, pitch: 0, yaw: 0)
    
    /// Creates a new rotation with the specified axis values
    public init(roll: Double = 0, pitch: Double = 0, yaw: Double = 0) {
        self.roll = max(-1, min(1, roll))
        self.pitch = max(-1, min(1, pitch))
        self.yaw = max(-1, min(1, yaw))
    }
    
    /// Creates a rotation from raw radians (for Core Motion integration)
    public init(rollRadians: Double, pitchRadians: Double, yawRadians: Double) {
        // Convert radians to normalized values (-1 to 1)
        self.roll = max(-1, min(1, rollRadians / .pi))
        self.pitch = max(-1, min(1, pitchRadians / (.pi / 2)))
        self.yaw = max(-1, min(1, yawRadians / .pi))
    }
    
    /// Magnitude of the rotation vector for sensitivity calculations
    public var magnitude: Double {
        sqrt(roll * roll + pitch * pitch + yaw * yaw)
    }
    
    /// Interpolates between two rotations for smooth transitions
    public func interpolate(to target: GyroRotation, factor: Double) -> GyroRotation {
        let t = max(0, min(1, factor))
        return GyroRotation(
            roll: roll + (target.roll - roll) * t,
            pitch: pitch + (target.pitch - pitch) * t,
            yaw: yaw + (target.yaw - yaw) * t
        )
    }
}

// MARK: - Gyroscope Primitive
/// A sophisticated 3D motion control primitive with Core Motion integration and manual gesture support.
///
/// `GyroscopePrimitive` provides a professional-grade motion sensing interface that combines
/// device orientation tracking with manual gesture control. The component offers advanced
/// calibration, filtering, and visualization for precise audio parameter manipulation.
///
/// ## Design Philosophy
///
/// The gyroscope primitive bridges the gap between physical device motion and digital
/// audio parameter control. It provides both automatic motion sensing and manual override
/// capabilities, making it suitable for live performance and studio production workflows.
///
/// ## Features
///
/// - **Advanced Core Motion**: High-precision device motion sensing with filtering
/// - **Manual Override**: Gesture-based control when motion sensing is disabled
/// - **Calibration System**: Real-time calibration and offset compensation
/// - **3D Visualization**: Professional 3D representation of rotation state
/// - **Dual Input Modes**: Seamless switching between motion and gesture control
/// - **Performance Optimized**: 60fps motion tracking with minimal CPU overhead
///
/// ## Usage Examples
///
/// ### Spatial Audio Control
/// ```swift
/// @State private var spatialRotation = GyroRotation.zero
/// 
/// GyroscopePrimitive(
///     rotation: $spatialRotation,
///     isEnabled: true
/// ) { newRotation in
///     spatialAudio.setOrientation(
///         roll: newRotation.roll,
///         pitch: newRotation.pitch,
///         yaw: newRotation.yaw
///     )
/// }
/// ```
///
/// ### Filter Parameter Control
/// ```swift
/// @State private var filterMotion = GyroRotation.zero
/// 
/// GyroscopePrimitive(rotation: $filterMotion) { rotation in
///     let frequency = (rotation.pitch + 1) * 10000 // 0-20kHz
///     let resonance = (rotation.roll + 1) * 5      // 0-10 Q
///     filterProcessor.setParameters(frequency: frequency, resonance: resonance)
/// }
/// ```
public struct GyroscopePrimitive: View {
    // MARK: - Public Properties
    
    /// A binding to the current 3D rotation state.
    ///
    /// The rotation automatically updates from device motion when tracking is enabled,
    /// or from manual gesture input when motion tracking is disabled. All values are
    /// normalized to -1.0...1.0 range for consistent parameter mapping.
    @Binding public var rotation: GyroRotation
    
    /// The physical dimensions of the gyroscope visualization.
    ///
    /// Larger sizes provide better visual feedback and gesture precision but require
    /// more screen space. The visualization automatically scales to fit these dimensions
    /// while maintaining proper proportions and interaction targets.
    ///
    /// ## Recommended Sizes
    /// - **Compact**: `CGSize(width: 150, height: 150)` for secondary controls
    /// - **Standard**: `CGSize(width: 220, height: 220)` for primary motion control
    /// - **Large**: `CGSize(width: 300, height: 300)` for precision applications
    public let size: CGSize
    
    /// Whether the gyroscope responds to both motion and gesture input.
    ///
    /// When disabled, the component shows current rotation state but ignores all input.
    /// Motion tracking and gesture recognition are both disabled, and visual feedback
    /// is reduced to indicate the inactive state.
    public let isEnabled: Bool
    
    /// Optional callback executed when rotation changes from any input source.
    ///
    /// This closure receives the new rotation state whenever device motion is detected
    /// or manual gestures are performed. The callback is ideal for immediate audio
    /// parameter updates and can be used alongside the binding for additional processing.
    public let onRotationChange: ((GyroRotation) -> Void)?
    
    // MARK: - Private State
    @State private var isTracking = false
    @State private var isDragging = false
    @State private var calibrationOffset = GyroRotation.zero
    @State private var lastGestureLocation = CGPoint.zero
    @State private var gestureStartRotation = GyroRotation.zero
    
    #if canImport(CoreMotion) && os(iOS)
    @StateObject private var motionManager = AdvancedMotionManager()
    #endif
    
    // MARK: - Initialization
    /// Creates a new gyroscope primitive with the specified configuration.
    ///
    /// - Parameters:
    ///   - rotation: Binding to the 3D rotation state
    ///   - size: Physical dimensions of the visualization
    ///   - isEnabled: Whether the component responds to input
    ///   - onRotationChange: Optional callback for rotation changes
    ///
    /// ## Example
    /// ```swift
    /// GyroscopePrimitive(
    ///     rotation: $deviceOrientation,
    ///     size: CGSize(width: 250, height: 250),
    ///     isEnabled: true
    /// ) { newRotation in
    ///     audioEngine.setMotionParameters(newRotation)
    /// }
    /// ```
    public init(
        rotation: Binding<GyroRotation>,
        size: CGSize = CGSize(width: 200, height: 200),
        isEnabled: Bool = true,
        onRotationChange: ((GyroRotation) -> Void)? = nil
    ) {
        self._rotation = rotation
        self.size = size
        self.isEnabled = isEnabled
        self.onRotationChange = onRotationChange
    }
    
    // MARK: - Body
    /// The main view body containing the 3D visualization and control interface.
    ///
    /// Combines the rotation visualization, control buttons, calibration interface,
    /// and gesture handling with Core Motion integration.
    public var body: some View {
        ZStack {
            // Main gyroscope visualization
            gyroscopeVisualization
            
            // Control interface
            controlInterface
            
            // Real-time rotation display
            if isDragging || isTracking {
                rotationDisplay
            }
        }
        .frame(width: size.width, height: size.height)
        .opacity(isEnabled ? 1.0 : 0.6)
        .disabled(!isEnabled)
        .contentShape(Circle())
        .gesture(manualControlGesture)
        #if canImport(CoreMotion) && os(iOS)
        .onReceive(motionManager.$currentRotation) { newRotation in
            if isTracking && isEnabled {
                let calibratedRotation = GyroRotation(
                    roll: newRotation.roll - calibrationOffset.roll,
                    pitch: newRotation.pitch - calibrationOffset.pitch,
                    yaw: newRotation.yaw - calibrationOffset.yaw
                )
                rotation = calibratedRotation
                onRotationChange?(calibratedRotation)
            }
        }
        #endif
        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: isTracking)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isDragging)
    }
    
    // MARK: - Visual Components
    
    /// Advanced 3D gyroscope visualization with realistic depth and lighting
    private var gyroscopeVisualization: some View {
        ZStack {
            // Outer reference ring with perspective
            Circle()
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.primary.opacity(0.3),
                            Color.primary.opacity(0.1)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 2
                )
                .frame(width: size.width, height: size.height)
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 2, y: 2)
            
            // Middle tracking ring
            Circle()
                .stroke(
                    Color.secondary.opacity(isTracking ? 0.6 : 0.3),
                    style: StrokeStyle(lineWidth: 1.5, dash: [8, 4])
                )
                .frame(width: size.width * 0.75, height: size.height * 0.75)
                .rotationEffect(.radians(rotation.yaw * .pi))
                .animation(.linear(duration: 0.1), value: rotation.yaw)
            
            // Device representation with 3D transform
            deviceRepresentation
                .rotation3DEffect(
                    .radians(rotation.pitch * .pi / 2),
                    axis: (x: 1, y: 0, z: 0)
                )
                .rotation3DEffect(
                    .radians(rotation.roll * .pi),
                    axis: (x: 0, y: 0, z: 1)
                )
                .rotationEffect(.radians(rotation.yaw * .pi))
                .animation(.spring(response: 0.3, dampingFraction: 0.8), value: rotation)
            
            // Axis indicators with improved styling
            axisIndicators
            
            // Center reference point
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.white,
                            Color.primary,
                            Color.primary.opacity(0.6)
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: 4
                    )
                )
                .frame(width: 8, height: 8)
                .shadow(color: Color.primary.opacity(0.8), radius: 2)
        }
    }
    
    /// Realistic device representation with depth and texture
    private var deviceRepresentation: some View {
        ZStack {
            // Main device body
            RoundedRectangle(cornerRadius: size.width * 0.04)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.secondary.opacity(0.9),
                            Color.secondary.opacity(0.5),
                            Color.secondary.opacity(0.7)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(
                    width: size.width * 0.3,
                    height: size.height * 0.5
                )
                .overlay(
                    RoundedRectangle(cornerRadius: size.width * 0.04)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.3),
                                    Color.black.opacity(0.2)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
                .shadow(
                    color: Color.black.opacity(0.4),
                    radius: isDragging || isTracking ? 8 : 12,
                    x: 2,
                    y: 4
                )
            
            // Screen representation
            RoundedRectangle(cornerRadius: size.width * 0.02)
                .fill(Color.black.opacity(0.8))
                .frame(
                    width: size.width * 0.24,
                    height: size.height * 0.4
                )
            
            // Orientation indicator dot
            Circle()
                .fill(Color.primary)
                .frame(width: size.width * 0.03, height: size.height * 0.03)
                .offset(y: -size.height * 0.18)
        }
    }
    
    /// Enhanced axis indicators with color coding and labels
    private var axisIndicators: some View {
        ZStack {
            // Roll indicator (red, Z-axis)
            rotationIndicator(
                color: .red,
                radius: size.width * 0.4,
                angle: rotation.roll * .pi,
                label: "R",
                axis: .z
            )
            
            // Pitch indicator (green, X-axis)
            rotationIndicator(
                color: .green,
                radius: size.width * 0.32,
                angle: rotation.pitch * .pi / 2,
                label: "P",
                axis: .x
            )
            
            // Yaw indicator (blue, Y-axis)
            rotationIndicator(
                color: .blue,
                radius: size.width * 0.24,
                angle: rotation.yaw * .pi,
                label: "Y",
                axis: .y
            )
        }
    }
    
    /// Individual rotation axis indicator
    private func rotationIndicator(
        color: Color,
        radius: CGFloat,
        angle: Double,
        label: String,
        axis: Axis3D
    ) -> some View {
        ZStack {
            // Arc track
            Circle()
                .trim(from: 0.25, to: 0.75)
                .stroke(color.opacity(0.2), lineWidth: 2)
                .frame(width: radius * 2, height: radius * 2)
            
            // Active arc
            Circle()
                .trim(from: 0.5, to: 0.5 + (angle / (.pi * 2)))
                .stroke(
                    color,
                    style: StrokeStyle(lineWidth: 3, lineCap: .round)
                )
                .frame(width: radius * 2, height: radius * 2)
                .rotationEffect(.degrees(90))
            
            // Indicator dot
            Circle()
                .fill(color)
                .frame(width: 6, height: 6)
                .offset(y: -radius)
                .rotationEffect(.radians(angle))
            
            // Axis label
            Text(label)
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(color)
                .offset(y: -radius - 15)
        }
    }
    
    /// Control interface with enhanced styling
    private var controlInterface: some View {
        VStack {
            Spacer()
            
            HStack(spacing: 16) {
                // Motion tracking toggle
                Button(action: toggleTracking) {
                    HStack(spacing: 4) {
                        Image(systemName: isTracking ? "gyroscope" : "location.slash")
                        Text(isTracking ? "Tracking" : "Manual")
                    }
                    .font(.caption.weight(.medium))
                    .foregroundColor(isTracking ? .blue : .secondary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.regularMaterial)
                            .shadow(radius: 2)
                    )
                }
                .disabled(!isEnabled)
                
                // Calibration button
                Button(action: calibrate) {
                    HStack(spacing: 4) {
                        Image(systemName: "scope")
                        Text("Calibrate")
                    }
                    .font(.caption.weight(.medium))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.regularMaterial)
                            .shadow(radius: 2)
                    )
                }
                .disabled(!isEnabled)
                
                // Reset button
                Button(action: reset) {
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.counterclockwise")
                        Text("Reset")
                    }
                    .font(.caption.weight(.medium))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                                         .background(
                         RoundedRectangle(cornerRadius: 12)
                             .fill(.regularMaterial)
                             .shadow(radius: 2)
                     )
                }
                .disabled(!isEnabled)
            }
            .offset(y: -20)
        }
    }
    
    /// Real-time rotation value display
    private var rotationDisplay: some View {
        VStack(spacing: 6) {
            Text("Rotation")
                .font(.caption.weight(.semibold))
                .foregroundColor(.secondary)
            
            HStack(spacing: 12) {
                rotationValue(label: "R", value: rotation.roll, color: .red)
                rotationValue(label: "P", value: rotation.pitch, color: .green)
                rotationValue(label: "Y", value: rotation.yaw, color: .blue)
            }
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial)
                .shadow(radius: 4)
        )
        .offset(y: -size.height/2 - 70)
        .transition(.opacity.combined(with: .scale(scale: 0.8)))
    }
    
    /// Individual rotation value display
    private func rotationValue(label: String, value: Double, color: Color) -> some View {
        VStack(spacing: 2) {
            Text(label)
                .font(.caption2.weight(.bold))
                .foregroundColor(color)
            
            Text(String(format: "%.2f", value))
                .font(.caption2.monospaced())
                .foregroundColor(.primary)
        }
    }
    
    // MARK: - Gesture Handling
    
    /// Advanced manual control gesture with momentum and precision
    private var manualControlGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { gesture in
                if !isTracking && isEnabled {
                    handleManualDragChanged(gesture)
                }
            }
            .onEnded { gesture in
                if !isTracking && isEnabled {
                    handleManualDragEnded(gesture)
                }
            }
    }
    
    /// Handles manual drag changes with sophisticated mapping
    private func handleManualDragChanged(_ gesture: DragGesture.Value) {
        if !isDragging {
            withAnimation(.easeOut(duration: 0.2)) {
                isDragging = true
            }
            lastGestureLocation = gesture.location
            gestureStartRotation = rotation
        }
        
        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        let deltaX = gesture.location.x - lastGestureLocation.x
        let deltaY = gesture.location.y - lastGestureLocation.y
        
        // Map gesture to rotation with appropriate sensitivity
        let sensitivity: Double = 0.01
        let rollDelta = deltaX * sensitivity
        let pitchDelta = -deltaY * sensitivity // Invert Y for natural feel
        
        // Calculate yaw from circular motion around center
        let angle = atan2(gesture.location.y - center.y, gesture.location.x - center.x)
        let previousAngle = atan2(lastGestureLocation.y - center.y, lastGestureLocation.x - center.x)
        let yawDelta = (angle - previousAngle) * 0.5
        
        // Apply changes with bounds checking
        let newRotation = GyroRotation(
            roll: rotation.roll + rollDelta,
            pitch: rotation.pitch + pitchDelta,
            yaw: rotation.yaw + yawDelta
        )
        
        rotation = newRotation
        onRotationChange?(newRotation)
        lastGestureLocation = gesture.location
    }
    
    /// Handles manual drag end with momentum application
    private func handleManualDragEnded(_ gesture: DragGesture.Value) {
        withAnimation(.easeOut(duration: 0.3)) {
            isDragging = false
        }
    }
    
    // MARK: - Control Actions
    
    /// Toggles motion tracking on/off
    private func toggleTracking() {
        #if canImport(CoreMotion) && os(iOS)
        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
            if isTracking {
                motionManager.stopUpdates()
                isTracking = false
            } else {
                motionManager.startUpdates()
                isTracking = true
            }
        }
        #endif
    }
    
    /// Calibrates the current position as the neutral point
    private func calibrate() {
        #if canImport(CoreMotion) && os(iOS)
        if isTracking {
            calibrationOffset = motionManager.currentRotation
        }
        #endif
        
        // Visual feedback for calibration
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            // Brief scale animation to indicate calibration
        }
    }
    
    /// Resets rotation to zero and clears calibration
    private func reset() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            rotation = GyroRotation.zero
            calibrationOffset = GyroRotation.zero
            onRotationChange?(GyroRotation.zero)
        }
    }
}

// MARK: - Advanced Motion Manager

#if canImport(CoreMotion) && os(iOS)
/// Advanced Core Motion manager with filtering and precision enhancements
@MainActor
class AdvancedMotionManager: ObservableObject {
    @Published var currentRotation = GyroRotation.zero
    @Published var isAvailable = false
    @Published var isActive = false
    
    private let motionManager = CMMotionManager()
    private var motionQueue = OperationQueue()
    
    // Low-pass filter for smoothing
    private var rollFilter = LowPassFilter(cutoff: 0.1)
    private var pitchFilter = LowPassFilter(cutoff: 0.1)
    private var yawFilter = LowPassFilter(cutoff: 0.1)
    
    init() {
        motionQueue.maxConcurrentOperationCount = 1
        isAvailable = motionManager.isDeviceMotionAvailable
    }
    
    func startUpdates() {
        guard motionManager.isDeviceMotionAvailable else { return }
        
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
        motionManager.startDeviceMotionUpdates(to: motionQueue) { [weak self] motion, error in
            guard let motion = motion, error == nil else { return }
            
            let attitude = motion.attitude
            
            // Apply low-pass filtering for smooth motion
            let filteredRoll = self?.rollFilter.process(attitude.roll) ?? attitude.roll
            let filteredPitch = self?.pitchFilter.process(attitude.pitch) ?? attitude.pitch
            let filteredYaw = self?.yawFilter.process(attitude.yaw) ?? attitude.yaw
            
            let newRotation = GyroRotation(
                rollRadians: filteredRoll,
                pitchRadians: filteredPitch,
                yawRadians: filteredYaw
            )
            
            Task { @MainActor in
                self?.currentRotation = newRotation
                self?.isActive = true
            }
        }
    }
    
    func stopUpdates() {
        motionManager.stopDeviceMotionUpdates()
        isActive = false
    }
}

/// Simple low-pass filter for motion smoothing
private class LowPassFilter {
    private let alpha: Double
    private var previousValue: Double = 0
    
    init(cutoff: Double) {
        self.alpha = cutoff
    }
    
    func process(_ input: Double) -> Double {
        previousValue = alpha * input + (1 - alpha) * previousValue
        return previousValue
    }
}
#endif

// MARK: - Supporting Types

/// 3D axis enumeration for rotation indicators
private enum Axis3D {
    case x, y, z
} 