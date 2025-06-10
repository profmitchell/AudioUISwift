# XYPads

Two-dimensional control surfaces for spatial parameter manipulation and expressive audio control.

## Overview

AudioUI XY pads provide intuitive two-dimensional parameter control, perfect for filter sweeps, spatial positioning, granular synthesis, and any scenario requiring simultaneous control of multiple related parameters.

## Pad Types

### StandardXYPad
General-purpose XY control for any two-parameter combination:

```swift
import SwiftUI
import AudioUI

struct FilterXYControl: View {
    @State private var position: CGPoint = CGPoint(x: 0.5, y: 0.5)
    
    private var cutoffFrequency: Double {
        // Map X to logarithmic frequency (20Hz - 20kHz)
        20 * pow(1000, position.x)
    }
    
    private var resonance: Double {
        // Map Y to resonance (0 - 1)
        position.y
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("FILTER CONTROL")
                .font(.title2)
                .fontWeight(.bold)
            
            StandardXYPad(position: $position)
                .frame(width: 300, height: 300)
                .onChange(of: position) { newPosition in
                    updateFilter(
                        cutoff: cutoffFrequency,
                        resonance: resonance
                    )
                }
            
            HStack(spacing: 30) {
                VStack {
                    Text("CUTOFF")
                        .font(.caption)
                        .fontWeight(.medium)
                    Text("\(Int(cutoffFrequency)) Hz")
                        .font(.title3)
                        .fontWeight(.bold)
                }
                
                VStack {
                    Text("RESONANCE")
                        .font(.caption)
                        .fontWeight(.medium)
                    Text("\(Int(resonance * 100))%")
                        .font(.title3)
                        .fontWeight(.bold)
                }
            }
        }
        .theme(.audioUINeumorphic)
    }
    
    private func updateFilter(cutoff: Double, resonance: Double) {
        AudioEngine.shared.setFilterParameters(
            cutoff: cutoff,
            resonance: resonance
        )
    }
}
```

### FilterXYPad
Specialized pad optimized for filter parameter control:

```swift
struct AdvancedFilterInterface: View {
    @State private var filterPosition: CGPoint = CGPoint(x: 0.3, y: 0.2)
    @State private var driveAmount: Double = 0.0
    @State private var filterType: FilterType = .lowpass
    
    enum FilterType: String, CaseIterable {
        case lowpass = "LP"
        case highpass = "HP" 
        case bandpass = "BP"
        case notch = "NOTCH"
    }
    
    var body: some View {
        VStack(spacing: 25) {
            // Filter type selection
            HStack {
                ForEach(FilterType.allCases, id: \.self) { type in
                    Button(type.rawValue) {
                        filterType = type
                    }
                    .font(.caption)
                    .foregroundColor(filterType == type ? .white : .primary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(filterType == type ? Color.blue : Color(.systemGray5))
                    .cornerRadius(6)
                }
            }
            
            // Main XY control
            FilterXYPad(
                position: $filterPosition,
                filterType: filterType
            )
            .frame(width: 280, height: 280)
            .overlay(
                // Frequency grid lines
                VStack {
                    ForEach([100, 1000, 10000], id: \.self) { freq in
                        Rectangle()
                            .fill(Color.white.opacity(0.2))
                            .frame(height: 1)
                            .offset(x: xPositionForFrequency(freq) * 280)
                    }
                }
            )
            
            // Drive control
            VStack {
                Text("DRIVE")
                    .font(.caption)
                HorizontalSlider(value: $driveAmount)
                    .frame(width: 200, height: 25)
                Text("\(Int(driveAmount * 100))%")
                    .font(.caption2)
            }
        }
        .theme(.audioUIMinimal)
    }
    
    private func xPositionForFrequency(_ freq: Int) -> Double {
        log10(Double(freq) / 20) / log10(20000 / 20)
    }
}
```

### MotionXYPad
Multi-touch pad supporting complex gesture recognition:

```swift
struct SpatialAudioInterface: View {
    @State private var soundSources: [SoundSource] = [
        SoundSource(id: 0, position: CGPoint(x: 0.3, y: 0.7)),
        SoundSource(id: 1, position: CGPoint(x: 0.8, y: 0.4))
    ]
    @State private var listenerPosition: CGPoint = CGPoint(x: 0.5, y: 0.5)
    
    var body: some View {
        VStack(spacing: 20) {
            Text("SPATIAL AUDIO CONTROL")
                .font(.title2)
                .fontWeight(.bold)
            
            MotionXYPad(
                sources: $soundSources,
                listener: $listenerPosition
            )
            .frame(width: 350, height: 350)
            .background(
                // Room visualization
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 2)
                    .background(
                        RadialGradient(
                            colors: [Color.blue.opacity(0.1), Color.clear],
                            center: UnitPoint(x: listenerPosition.x, y: listenerPosition.y),
                            startRadius: 0,
                            endRadius: 100
                        )
                    )
            )
            
            // Source controls
            HStack(spacing: 20) {
                ForEach(soundSources.indices, id: \.self) { index in
                    VStack {
                        Text("SOURCE \(index + 1)")
                            .font(.caption)
                        Text("X: \(soundSources[index].position.x, specifier: "%.2f")")
                            .font(.caption2)
                        Text("Y: \(soundSources[index].position.y, specifier: "%.2f")")
                            .font(.caption2)
                    }
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
            }
        }
        .theme(.audioUINeumorphic)
    }
}

struct SoundSource: Identifiable {
    let id: Int
    var position: CGPoint
}
```

## Advanced Features

### Gesture Recording and Playback
Record XY movements for automation:

```swift
struct GestureRecordingXYPad: View {
    @State private var currentPosition: CGPoint = CGPoint(x: 0.5, y: 0.5)
    @State private var recordedGesture: [TimedPosition] = []
    @State private var isRecording = false
    @State private var isPlaying = false
    
    var body: some View {
        VStack(spacing: 20) {
            StandardXYPad(position: $currentPosition)
                .frame(width: 300, height: 300)
                .onChange(of: currentPosition) { position in
                    if isRecording {
                        recordPosition(position)
                    }
                }
                .overlay(
                    // Show recorded path
                    Path { path in
                        if let first = recordedGesture.first {
                            path.move(to: CGPoint(
                                x: first.position.x * 300,
                                y: first.position.y * 300
                            ))
                            
                            for gesture in recordedGesture.dropFirst() {
                                path.addLine(to: CGPoint(
                                    x: gesture.position.x * 300,
                                    y: gesture.position.y * 300
                                ))
                            }
                        }
                    }
                    .stroke(Color.red.opacity(0.5), lineWidth: 2)
                )
            
            HStack(spacing: 15) {
                Button(isRecording ? "STOP REC" : "RECORD") {
                    toggleRecording()
                }
                .foregroundColor(isRecording ? .red : .primary)
                
                Button(isPlaying ? "STOP PLAY" : "PLAY") {
                    togglePlayback()
                }
                .foregroundColor(isPlaying ? .green : .primary)
                .disabled(recordedGesture.isEmpty)
                
                Button("CLEAR") {
                    recordedGesture.removeAll()
                }
                .disabled(recordedGesture.isEmpty)
            }
            .buttonStyle(.bordered)
        }
    }
    
    private func recordPosition(_ position: CGPoint) {
        let timedPosition = TimedPosition(
            position: position,
            timestamp: Date().timeIntervalSince1970
        )
        recordedGesture.append(timedPosition)
    }
    
    private func toggleRecording() {
        if isRecording {
            isRecording = false
        } else {
            recordedGesture.removeAll()
            isRecording = true
        }
    }
    
    private func togglePlayback() {
        if isPlaying {
            isPlaying = false
        } else {
            playbackGesture()
        }
    }
    
    private func playbackGesture() {
        guard !recordedGesture.isEmpty else { return }
        
        isPlaying = true
        let startTime = Date().timeIntervalSince1970
        let gestureStartTime = recordedGesture.first!.timestamp
        
        Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { timer in
            let currentTime = Date().timeIntervalSince1970
            let elapsedTime = currentTime - startTime
            let targetTime = gestureStartTime + elapsedTime
            
            if let closestGesture = recordedGesture.min(by: { 
                abs($0.timestamp - targetTime) < abs($1.timestamp - targetTime)
            }) {
                currentPosition = closestGesture.position
            }
            
            if elapsedTime > (recordedGesture.last!.timestamp - gestureStartTime) {
                isPlaying = false
                timer.invalidate()
            }
        }
    }
}

struct TimedPosition {
    let position: CGPoint
    let timestamp: TimeInterval
}
```

### Granular Synthesis Control
XY pad controlling granular parameters:

```swift
struct GranularSynthXYPad: View {
    @State private var grainPosition: CGPoint = CGPoint(x: 0.5, y: 0.5)
    @State private var sampleBuffer: AudioBuffer?
    
    private var grainSize: Double {
        // X axis controls grain size (1ms - 1000ms)
        1 + (grainPosition.x * 999)
    }
    
    private var grainDensity: Double {
        // Y axis controls grain density (1 - 100 grains/sec)
        1 + (grainPosition.y * 99)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("GRANULAR SYNTHESIS")
                .font(.title2)
                .fontWeight(.bold)
            
            StandardXYPad(position: $grainPosition)
                .frame(width: 300, height: 300)
                .background(
                    // Waveform visualization
                    WaveformView(buffer: sampleBuffer)
                        .opacity(0.3)
                )
                .overlay(
                    // Grain visualization
                    GrainVisualizationView(
                        grainSize: grainSize,
                        density: grainDensity,
                        position: grainPosition
                    )
                )
                .onChange(of: grainPosition) { position in
                    updateGranularParameters()
                }
            
            HStack(spacing: 40) {
                VStack {
                    Text("GRAIN SIZE")
                        .font(.caption)
                        .fontWeight(.medium)
                    Text("\(grainSize, specifier: "%.0f") ms")
                        .font(.title3)
                        .fontWeight(.bold)
                }
                
                VStack {
                    Text("DENSITY")
                        .font(.caption)
                        .fontWeight(.medium)
                    Text("\(grainDensity, specifier: "%.0f") grains/sec")
                        .font(.title3)
                        .fontWeight(.bold)
                }
            }
            
            // Additional granular controls
            HStack(spacing: 20) {
                Button("LOAD SAMPLE") {
                    loadAudioSample()
                }
                
                Button("FREEZE") {
                    freezeGrains()
                }
                
                Button("REVERSE") {
                    reverseGrains()
                }
            }
            .buttonStyle(.bordered)
        }
        .theme(.audioUINeumorphic)
    }
    
    private func updateGranularParameters() {
        GranularEngine.shared.setParameters(
            grainSize: grainSize,
            density: grainDensity,
            position: grainPosition
        )
    }
    
    private func loadAudioSample() {
        // Load audio file for granular processing
    }
    
    private func freezeGrains() {
        // Freeze current grain position
    }
    
    private func reverseGrains() {
        // Reverse grain playback direction
    }
}
```

## Performance Optimization

### Efficient Touch Tracking
```swift
class XYPadTouchTracker: ObservableObject {
    @Published var position: CGPoint = CGPoint(x: 0.5, y: 0.5)
    private var lastUpdateTime: CFTimeInterval = 0
    private let updateInterval: CFTimeInterval = 1.0 / 60.0 // 60fps
    
    func updatePosition(_ newPosition: CGPoint) {
        let currentTime = CACurrentMediaTime()
        
        if currentTime - lastUpdateTime >= updateInterval {
            position = newPosition
            lastUpdateTime = currentTime
        }
    }
}
```

### Audio Parameter Smoothing
```swift
class ParameterSmoother {
    private var targetValue: Double = 0
    private var currentValue: Double = 0
    private let smoothingFactor: Double = 0.95
    
    func setTarget(_ value: Double) {
        targetValue = value
    }
    
    func getSmoothedValue() -> Double {
        currentValue = (currentValue * smoothingFactor) + (targetValue * (1 - smoothingFactor))
        return currentValue
    }
}
```

## See Also

- <doc:DrumPads> - Percussive control interfaces
- <doc:MotionControls> - Gesture-based parameter control
- <doc:AudioUIComponents> - Complete component overview
- <doc:PerformanceOptimization> - Real-time optimization techniques
