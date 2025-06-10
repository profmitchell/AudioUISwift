//
//  GyroMinimal.swift
//  AudioUIComponentTesting
//
//  Created by Mitchell Cohen on 6/9/25.
//


import SwiftUI
import CoreMotion
import AudioUICore
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct GyroMinimal: View {
    @Binding public var rotation: GyroRotation
    @State private var isPressed = false
    
    @State private var pitch: Double = 0
    @State private var yaw: Double = 0
    @State private var roll: Double = 0
    @State private var isTracking = false
    @Environment(\.theme) private var theme
    
    @StateObject private var motionManager = MinimalMotionManager()
    
    // Enhanced theme-based colors - utilizing rich palette
    private var primaryColor: Color { theme.look.textPrimary }
    private var backgroundColor: Color { theme.look.surfacePrimary }
    private var accentColor: Color { theme.look.surfaceSecondary }
    
    // Additional rich color palette utilization
    private var brandPrimary: Color { theme.look.brandPrimary }
    private var brandSecondary: Color { theme.look.brandSecondary }
    private var accent: Color { theme.look.accent }
    private var interactiveActive: Color { theme.look.interactiveActive }
    private var glowPrimary: Color { theme.look.glowPrimary }
    private var textSecondary: Color { theme.look.textSecondary }
    private var surfaceElevated: Color { theme.look.surfaceElevated }
    private var neutralDivider: Color { theme.look.neutralDivider }
    
    public init(rotation: Binding<GyroRotation> = .constant(GyroRotation())) {
        self._rotation = rotation
    }
    
    public var body: some View {
        VStack(spacing: 50) {
            // Title
            Text("MOTION")
                .font(.system(size: 12, weight: .medium, design: .default))
                .tracking(4)
                .foregroundColor(primaryColor.opacity(0.6))
            
            // Main visualization
            ZStack {
                // Grid lines
                ForEach(0..<3) { i in
                    Rectangle()
                        .fill(primaryColor.opacity(0.05))
                        .frame(width: 300, height: 1)
                        .rotationEffect(.degrees(Double(i) * 60))
                }
                
                ForEach(0..<3) { i in
                    Circle()
                        .stroke(primaryColor.opacity(0.05), lineWidth: 1)
                        .frame(
                            width: CGFloat(100 + i * 50),
                            height: CGFloat(100 + i * 50)
                        )
                }
                
                // Pitch/Roll indicator
                Circle()
                    .fill(primaryColor)
                    .frame(width: 20, height: 20)
                    .offset(
                        x: roll * 100,
                        y: -pitch * 100
                    )
                    .shadow(color: primaryColor.opacity(0.2), radius: 10)
                
                // Yaw ring
                Circle()
                    .stroke(primaryColor.opacity(0.3), lineWidth: 2)
                    .frame(width: 180, height: 180)
                    .overlay(
                        // Yaw indicator
                        Rectangle()
                            .fill(primaryColor)
                            .frame(width: 3, height: 20)
                            .offset(y: -90)
                            .rotationEffect(.radians(yaw))
                    )
                
                // Center cross
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(primaryColor.opacity(0.2))
                        .frame(width: 1, height: 40)
                    Spacer().frame(height: 40)
                    Rectangle()
                        .fill(primaryColor.opacity(0.2))
                        .frame(width: 1, height: 40)
                }
                .frame(height: 120)
                
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(primaryColor.opacity(0.2))
                        .frame(width: 40, height: 1)
                    Spacer().frame(width: 40)
                    Rectangle()
                        .fill(primaryColor.opacity(0.2))
                        .frame(width: 40, height: 1)
                }
                .frame(width: 120)
            }
            .frame(width: 250, height: 250)
            .animation(.smooth(duration: 0.1), value: pitch)
            .animation(.smooth(duration: 0.1), value: roll)
            .animation(.smooth(duration: 0.1), value: yaw)
            
            // Value displays
            HStack(spacing: 40) {
                valueDisplay("P", pitch * 180 / .pi)
                valueDisplay("Y", yaw * 180 / .pi)
                valueDisplay("R", roll * 180 / .pi)
            }
            
            // Control buttons
            HStack(spacing: 20) {
                Button(action: toggleTracking) {
                    Text(isTracking ? "STOP" : "START")
                        .font(.system(size: 11, weight: .medium, design: .default))
                        .tracking(2)
                        .foregroundColor(isTracking ? backgroundColor : primaryColor)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 12)
                        .background(
                            Rectangle()
                                .fill(isTracking ? primaryColor : backgroundColor)
                                .overlay(
                                    Rectangle()
                                        .stroke(primaryColor, lineWidth: 1)
                                )
                        )
                }
                
                Button(action: recalibrate) {
                    Text("RECALIBRATE")
                        .font(.system(size: 11, weight: .medium, design: .default))
                        .tracking(2)
                        .foregroundColor(brandSecondary)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(
                            Rectangle()
                                .fill(backgroundColor)
                                .overlay(
                                    Rectangle()
                                        .stroke(brandSecondary, lineWidth: 1)
                                )
                        )
                }
            }
        }
        .padding(40)
        .frame(width: 350, height: 500)
        .background(backgroundColor)
        .onReceive(motionManager.$pitch) { pitch = $0 }
        .onReceive(motionManager.$yaw) { yaw = $0 }
        .onReceive(motionManager.$roll) { roll = $0 }
    }
    
    private func valueDisplay(_ label: String, _ value: Double) -> some View {
        VStack(spacing: 8) {
            Text(label)
                .font(.system(size: 10, weight: .medium, design: .default))
                .foregroundColor(primaryColor.opacity(0.5))
            
            Text(String(format: "%.1f°", value))
                .font(.system(size: 16, weight: .light, design: .monospaced))
                .foregroundColor(primaryColor)
            
            Rectangle()
                .fill(primaryColor.opacity(0.2))
                .frame(width: 40, height: 1)
        }
    }
    
    private func toggleTracking() {
        if isTracking {
            motionManager.stopUpdates()
        } else {
            motionManager.startUpdates()
        }
        isTracking.toggle()
    }
    
    private func recalibrate() {
        motionManager.recalibrate()
    }
}

// Minimal Motion Manager
class MinimalMotionManager: ObservableObject {
    @Published var pitch: Double = 0
    @Published var yaw: Double = 0
    @Published var roll: Double = 0
    
    #if os(iOS)
    private let motionManager = CMMotionManager()
    #endif
    
    func startUpdates() {
        #if os(iOS)
        guard motionManager.isDeviceMotionAvailable else { return }
        
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, _ in
            guard let motion = motion else { return }
            self?.pitch = motion.attitude.pitch
            self?.yaw = motion.attitude.yaw
            self?.roll = motion.attitude.roll
        }
        #else
        // Simulation for preview
        Timer.scheduledTimer(withTimeInterval: 1/60.0, repeats: true) { _ in
            let time = Date().timeIntervalSince1970
            self.pitch = sin(time * 0.3) * 0.5
            self.yaw = sin(time * 0.2) * 1.0
            self.roll = cos(time * 0.4) * 0.6
        }
        #endif
    }
    
    func stopUpdates() {
        #if os(iOS)
        motionManager.stopDeviceMotionUpdates()
        #endif
    }
    
    func recalibrate() {
        // Reset values to zero
        pitch = 0
        yaw = 0
        roll = 0
        
        // If currently running, restart to recalibrate
        #if os(iOS)
        if motionManager.isDeviceMotionActive {
            stopUpdates()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.startUpdates()
            }
        }
        #endif
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct GyroMinimal_Previews: PreviewProvider {
    public static var previews: some View {
        GyroMinimal()
            .theme(.audioUI)
            .previewLayout(.sizeThatFits)
    }
}
