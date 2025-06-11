# MotionControls

Gesture-based and motion-sensitive controls for expressive audio interfaces.

## Overview

AudioUI motion controls leverage device sensors, gestures, and spatial input to create intuitive and expressive audio interfaces. Perfect for performance controllers, immersive experiences, and innovative interaction patterns.

## Control Types

### JoyStick
Virtual joystick for directional parameter control:

```swift
import SwiftUI
import AudioUI

struct VirtualJoystickInterface: View {
    @State private var joystickPosition: CGPoint = .zero
    @State private var isActive = false
    
    var body: some View {
        VStack(spacing: 30) {
            Text("VIRTUAL JOYSTICK CONTROL")
                .font(.title2)
                .fontWeight(.bold)
            
            JoyStick(
                position: $joystickPosition,
                isActive: $isActive
            )
            .frame(width: 200, height: 200)
            .onChange(of: joystickPosition) { position in
                updateAudioParameters(position)
            }
            
            HStack(spacing: 40) {
                VStack {
                    Text("X AXIS")
                        .font(.caption)
                    Text("\(joystickPosition.x, specifier: "%.2f")")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                VStack {
                    Text("Y AXIS")
                        .font(.caption)
                    Text("\(joystickPosition.y, specifier: "%.2f")")
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
        }
        .theme(.audioUINeumorphic)
    }
    
    private func updateAudioParameters(_ position: CGPoint) {
        AudioEngine.shared.setSpacialPosition(
            x: position.x,
            y: position.y
        )
    }
}
```

### MotionSensor
Device motion integration for tilt and orientation control:

```swift
struct MotionSensorInterface: View {
    @StateObject private var motionManager = MotionManager()
    @State private var sensitivity: Double = 1.0
    @State private var isMotionEnabled = false
    
    var body: some View {
        VStack(spacing: 25) {
            Text("MOTION CONTROL")
                .font(.title2)
                .fontWeight(.bold)
            
            // Motion visualization
            MotionSensor(
                motionData: motionManager.motionData,
                sensitivity: sensitivity,
                isEnabled: isMotionEnabled
            )
            .frame(width: 250, height: 200)
            
            // Motion values display
            HStack(spacing: 30) {
                motionValueDisplay("PITCH", value: motionManager.pitch)
                motionValueDisplay("ROLL", value: motionManager.roll)
                motionValueDisplay("YAW", value: motionManager.yaw)
            }
            
            // Controls
            VStack(spacing: 15) {
                HStack {
                    Text("SENSITIVITY")
                        .font(.caption)
                    Slider(value: $sensitivity, in: 0.1...2.0)
                        .frame(width: 150)
                    Text("\(sensitivity, specifier: "%.1f")")
                        .font(.caption)
                }
                
                Toggle("MOTION ENABLED", isOn: $isMotionEnabled)
                    .onChange(of: isMotionEnabled) { enabled in
                        if enabled {
                            motionManager.startMotionUpdates()
                        } else {
                            motionManager.stopMotionUpdates()
                        }
                    }
            }
        }
        .theme(.audioUIMinimal)
        .padding(30)
    }
    
    private func motionValueDisplay(_ label: String, value: Double) -> some View {
        VStack {
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
            Text("\(value, specifier: "%.2f")°")
                .font(.title3)
                .fontWeight(.bold)
        }
    }
}
```

### GestureController
Multi-gesture recognition for complex parameter control:

```swift
struct GestureControlInterface: View {
    @State private var currentGesture: AudioGestureType = .none
    @State private var gestureValue: Double = 0.0
    @State private var recordedGestures: [AudioGesture] = []
    
    var body: some View {
        VStack(spacing: 25) {
            Text("GESTURE CONTROL")
                .font(.title2)
                .fontWeight(.bold)
            
            // Gesture recognition area
            GestureController { gesture in
                handleGesture(gesture)
            }
            .frame(width: 300, height: 250)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
                    .overlay(
                        Text(currentGesture.description)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    )
            )
            
            // Gesture value display
            VStack {
                Text("GESTURE VALUE")
                    .font(.caption)
                Text("\(gestureValue, specifier: "%.3f")")
                    .font(.title)
                    .fontWeight(.bold)
            }
            
            // Recorded gestures
            ScrollView(.horizontal) {
                HStack {
                    ForEach(recordedGestures.suffix(5), id: \.id) { gesture in
                        VStack {
                            Text(gesture.type.description)
                                .font(.caption2)
                            Text("\(gesture.value, specifier: "%.2f")")
                                .font(.caption)
                        }
                        .padding(8)
                        .background(Color(.systemGray5))
                        .cornerRadius(6)
                    }
                }
                .padding(.horizontal)
            }
        }
        .theme(.audioUINeumorphic)
    }
    
    private func handleGesture(_ gesture: AudioGesture) {
        currentGesture = gesture.type
        gestureValue = gesture.value
        recordedGestures.append(gesture)
        
        // Apply gesture to audio parameters
        AudioEngine.shared.applyGesture(gesture)
    }
}

enum AudioGestureType {
    case none, swipeUp, swipeDown, swipeLeft, swipeRight
    case pinch, rotation, longPress, doubleTap
    
    var description: String {
        switch self {
        case .none: return "No Gesture"
        case .swipeUp: return "Swipe Up"
        case .swipeDown: return "Swipe Down"
        case .swipeLeft: return "Swipe Left"
        case .swipeRight: return "Swipe Right"
        case .pinch: return "Pinch"
        case .rotation: return "Rotation"
        case .longPress: return "Long Press"
        case .doubleTap: return "Double Tap"
        }
    }
}

struct AudioGesture: Identifiable {
    let id = UUID()
    let type: AudioGestureType
    let value: Double
    let timestamp: Date
}
```

## Advanced Motion Features

### 3D Spatial Audio Control
Use device orientation for immersive audio positioning:

```swift
struct SpatialAudioMotionControl: View {
    @StateObject private var motionController = SpatialMotionController()
    @State private var soundSources: [SpatialSource] = []
    
    var body: some View {
        VStack(spacing: 20) {
            Text("3D SPATIAL AUDIO")
                .font(.title2)
                .fontWeight(.bold)
            
            // 3D visualization
            ZStack {
                // Room representation
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 2)
                    .frame(width: 300, height: 300)
                
                // Sound sources
                ForEach(soundSources) { source in
                    Circle()
                        .fill(source.color)
                        .frame(width: 20, height: 20)
                        .position(
                            x: 150 + (source.position.x * 130),
                            y: 150 + (source.position.y * 130)
                        )
                        .scaleEffect(1.0 + source.distance * 0.5)
                }
                
                // Listener position (center)
                Circle()
                    .fill(Color.blue)
                    .frame(width: 30, height: 30)
                    .position(x: 150, y: 150)
                    .rotationEffect(.degrees(motionController.headingAngle))
            }
            
            // Motion data display
            HStack(spacing: 25) {
                VStack {
                    Text("HEADING")
                        .font(.caption)
                    Text("\(motionController.headingAngle, specifier: "%.0f")°")
                        .font(.title3)
                }
                
                VStack {
                    Text("ELEVATION")
                        .font(.caption)
                    Text("\(motionController.elevationAngle, specifier: "%.0f")°")
                        .font(.title3)
                }
                
                VStack {
                    Text("DISTANCE")
                        .font(.caption)
                    Text("\(motionController.estimatedDistance, specifier: "%.1f")m")
                        .font(.title3)
                }
            }
        }
        .theme(.audioUIMinimal)
        .onAppear {
            motionController.startTracking()
            setupSoundSources()
        }
    }
    
    private func setupSoundSources() {
        soundSources = [
            SpatialSource(position: CGPoint(x: -0.5, y: 0.3), color: .red),
            SpatialSource(position: CGPoint(x: 0.7, y: -0.4), color: .green),
            SpatialSource(position: CGPoint(x: 0.2, y: 0.8), color: .orange)
        ]
    }
}

struct SpatialSource: Identifiable {
    let id = UUID()
    let position: CGPoint
    let color: Color
    var distance: Double = 0.0
}
```

### Gesture Learning System
Learn and recognize custom gestures:

```swift
struct GestureLearningInterface: View {
    @StateObject private var gestureRecognizer = CustomGestureRecognizer()
    @State private var isLearningMode = false
    @State private var currentGestureName = ""
    @State private var learnedGestures: [String] = []
    
    var body: some View {
        VStack(spacing: 25) {
            Text("GESTURE LEARNING")
                .font(.title2)
                .fontWeight(.bold)
            
            // Learning area
            GestureRecognitionArea(
                recognizer: gestureRecognizer,
                isLearningMode: isLearningMode
            )
            .frame(width: 300, height: 200)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isLearningMode ? Color.red.opacity(0.1) : Color(.systemGray6))
                    .overlay(
                        Text(isLearningMode ? "LEARNING: \(currentGestureName)" : "RECOGNITION AREA")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    )
            )
            
            // Learning controls
            VStack(spacing: 15) {
                TextField("Gesture Name", text: $currentGestureName)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 200)
                
                HStack(spacing: 15) {
                    Button(isLearningMode ? "STOP LEARNING" : "START LEARNING") {
                        toggleLearningMode()
                    }
                    .foregroundColor(isLearningMode ? .red : .blue)
                    .disabled(currentGestureName.isEmpty)
                    
                    Button("CLEAR ALL") {
                        clearLearnedGestures()
                    }
                    .disabled(learnedGestures.isEmpty)
                }
                .buttonStyle(.bordered)
            }
            
            // Learned gestures list
            if !learnedGestures.isEmpty {
                VStack {
                    Text("LEARNED GESTURES")
                        .font(.caption)
                        .fontWeight(.bold)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 8) {
                        ForEach(learnedGestures, id: \.self) { gesture in
                            Text(gesture)
                                .font(.caption2)
                                .padding(4)
                                .background(Color(.systemGray5))
                                .cornerRadius(4)
                        }
                    }
                }
            }
        }
        .theme(.audioUINeumorphic)
        .padding(30)
    }
    
    private func toggleLearningMode() {
        if isLearningMode {
            // Save the learned gesture
            gestureRecognizer.saveGesture(named: currentGestureName)
            learnedGestures.append(currentGestureName)
            currentGestureName = ""
            isLearningMode = false
        } else {
            isLearningMode = true
            gestureRecognizer.startLearning()
        }
    }
    
    private func clearLearnedGestures() {
        gestureRecognizer.clearAllGestures()
        learnedGestures.removeAll()
    }
}
```

## Performance Integration

### Real-Time Audio Mapping
Map motion data to audio parameters in real-time:

```swift
class MotionToAudioMapper: ObservableObject {
    @Published var motionData: MotionData = MotionData()
    private let audioEngine = AudioEngine.shared
    
    func updateMotionMapping() {
        // Map device tilt to filter cutoff
        let cutoffFrequency = mapRange(
            value: motionData.pitch,
            inputRange: -90...90,
            outputRange: 20...20000,
            curve: .logarithmic
        )
        
        // Map device rotation to resonance
        let resonance = mapRange(
            value: motionData.roll,
            inputRange: -45...45,
            outputRange: 0...1,
            curve: .linear
        )
        
        // Map acceleration to distortion
        let distortion = mapRange(
            value: motionData.acceleration.magnitude,
            inputRange: 0...2,
            outputRange: 0...1,
            curve: .exponential
        )
        
        audioEngine.setFilterParameters(
            cutoff: cutoffFrequency,
            resonance: resonance
        )
        audioEngine.setDistortion(distortion)
    }
    
    private func mapRange(
        value: Double,
        inputRange: ClosedRange<Double>,
        outputRange: ClosedRange<Double>,
        curve: MappingCurve
    ) -> Double {
        let normalized = (value - inputRange.lowerBound) / (inputRange.upperBound - inputRange.lowerBound)
        let clamped = max(0, min(1, normalized))
        
        let curved = switch curve {
        case .linear: clamped
        case .logarithmic: log10((clamped * 9) + 1)
        case .exponential: pow(clamped, 2)
        }
        
        return outputRange.lowerBound + (curved * (outputRange.upperBound - outputRange.lowerBound))
    }
}

enum MappingCurve {
    case linear, logarithmic, exponential
}

struct MotionData {
    var pitch: Double = 0
    var roll: Double = 0
    var yaw: Double = 0
    var acceleration: SIMD3<Double> = SIMD3(0, 0, 0)
}

extension SIMD3<Double> {
    var magnitude: Double {
        sqrt(x*x + y*y + z*z)
    }
}
```

## See Also

- <doc:XYPads> - Two-dimensional control surfaces
- <doc:DrumPads> - Velocity-sensitive controls
- <doc:AudioUIComponents> - Complete component overview
- <doc:PerformanceOptimization> - Real-time motion processing
