//
//  GyroMinimal1.swift
//  AudioUI
//
//  Created by Mitchell Cohen on 6/3/25.
//


//
//  GyroMinimal1.swift
//  AudioUI
//
//  Created by Mitchell Cohen on 6/3/25.
//

import SwiftUI
#if canImport(CoreMotion)
import CoreMotion
#endif
import AudioUICore
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct GyroMinimal1: View {
    @Binding public var rotation: GyroRotation
    @State private var isPressed = false
    @State private var isTracking = false
    
    @State private var pitch: Double = 0
    @State private var yaw: Double = 0
    @State private var roll: Double = 0
    @Environment(\.theme) private var theme
    
#if os(iOS)
    private let motionManager = CMMotionManager()
#endif
    
    // Enhanced theme-based colors - utilizing rich palette
    private var primaryColor: Color { theme.look.textPrimary }
    private var backgroundColor: Color { theme.look.surfacePrimary }
    private var accentColor: Color { theme.look.textSecondary }
    
    // Additional rich color palette utilization
    private var brandPrimary: Color { theme.look.brandPrimary }
    private var brandSecondary: Color { theme.look.brandSecondary }
    private var brandTertiary: Color { theme.look.brandTertiary }
    private var stateSuccess: Color { theme.look.stateSuccess }
    private var stateInfo: Color { theme.look.stateInfo }
    private var stateWarning: Color { theme.look.stateWarning }
    private var glowColor: Color { theme.look.glowPrimary }
    private var highlightColor: Color { theme.look.neutralHighlight }
    private var surfaceElevated: Color { theme.look.surfaceElevated }
    private var panelBackground: Color { theme.look.panelBackground }
    private var controlBackground: Color { theme.look.controlBackground }
    private var textAccent: Color { theme.look.textAccent }
    
    public init(rotation: Binding<GyroRotation> = .constant(GyroRotation())) {
        self._rotation = rotation
    }
    
    public var body: some View {
        ZStack {
            // Clean background
            backgroundColor
                .frame(width: 380, height: 380)
                .cornerRadius(40)
            
            // Main visualization
            ZStack {
                // Crosshair
                Path { path in
                    path.move(to: CGPoint(x: 0, y: -150))
                    path.addLine(to: CGPoint(x: 0, y: 150))
                    path.move(to: CGPoint(x: -150, y: 0))
                    path.addLine(to: CGPoint(x: 150, y: 0))
                }
                .stroke(primaryColor.opacity(0.1), lineWidth: 1)
                
                // Reference circle
                Circle()
                    .stroke(primaryColor.opacity(0.1), lineWidth: 1)
                    .frame(width: 200, height: 200)
                
                // Motion indicator
                Circle()
                    .fill(primaryColor)
                    .frame(width: 12, height: 12)
                    .offset(
                        x: roll * 100,
                        y: pitch * 100
                    )
                    .animation(.smooth(duration: 0.1), value: roll)
                    .animation(.smooth(duration: 0.1), value: pitch)
                
                // Yaw arc
                Circle()
                    .trim(from: 0, to: 0.25)
                    .stroke(
                        primaryColor.opacity(0.6),
                        style: StrokeStyle(lineWidth: 2, lineCap: .round)
                    )
                    .frame(width: 240, height: 240)
                    .rotationEffect(.degrees(yaw * 180 - 45))
                    .animation(.smooth(duration: 0.1), value: yaw)
            }
            
            // Minimal data display and controls
            VStack(spacing: 20) {
                Spacer()
                HStack(spacing: 40) {
                    dataPoint("R", roll * 180)
                    dataPoint("P", pitch * 180)
                    dataPoint("Y", yaw * 180)
                }
                
                // Control buttons
                HStack(spacing: 20) {
                    Button(action: toggleTracking) {
                        Text(isTracking ? "STOP" : "START")
                            .font(.system(size: 11, weight: .medium, design: .default))
                            .tracking(2)
                            .foregroundColor(isTracking ? backgroundColor : primaryColor)
                            .padding(.horizontal, 25)
                            .padding(.vertical, 10)
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
                            .padding(.horizontal, 15)
                            .padding(.vertical, 10)
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
                .padding(.bottom, 40)
            }
        }
        .frame(width: 400, height: 400)
        .onAppear { 
            startTracking()
        }
        .onDisappear { 
            stopTracking()
        }
    }
    
    private func startTracking() {
#if os(iOS)
        guard motionManager.isDeviceMotionAvailable else { return }
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
        motionManager.startDeviceMotionUpdates(to: .main) { data, _ in
            guard let attitude = data?.attitude else { return }
            self.roll = attitude.roll / .pi
            self.pitch = attitude.pitch / .pi
            self.yaw = attitude.yaw / .pi
        }
        isTracking = true
#endif
    }
    
    private func stopTracking() {
#if os(iOS)
        motionManager.stopDeviceMotionUpdates()
        isTracking = false
#endif
    }
    
    private func toggleTracking() {
        if isTracking {
            stopTracking()
        } else {
            startTracking()
        }
    }
    
    private func recalibrate() {
        pitch = 0
        yaw = 0
        roll = 0
        
        if isTracking {
            stopTracking()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                startTracking()
            }
        }
    }
    
    private func dataPoint(_ label: String, _ value: Double) -> some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.system(size: 11, weight: .regular, design: .default))
                .foregroundColor(accentColor.opacity(0.6))
            
            Text(String(format: "%.1f°", value))
                .font(.system(size: 16, weight: .light, design: .default))
                .foregroundColor(primaryColor)
        }
    }
}
@available(iOS 18.0, macOS 15.0, *)
public struct GyroMinimal1_Previews: PreviewProvider {
    public static var previews: some View {
        GyroMinimal1()
            .theme(.audioUI)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
