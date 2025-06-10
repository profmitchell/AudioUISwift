# DrumPads

Velocity-sensitive percussion controls for drum machines, samplers, and rhythmic interfaces.

## Overview

AudioUI drum pads provide responsive, velocity-sensitive controls perfect for triggering samples, creating rhythms, and building drum machine interfaces. Each pad type offers authentic feel with pressure sensitivity, visual feedback, and professional behavior patterns.

## Pad Types

### SquareDrumPad
Classic square pads ideal for drum machines and step sequencers:

```swift
import SwiftUI
import AudioUI

struct DrumMachineInterface: View {
    @State private var padStates: [Bool] = Array(repeating: false, count: 16)
    @State private var padVelocities: [Double] = Array(repeating: 0.0, count: 16)
    
    let drumSounds = [
        "Kick", "Snare", "Hi-Hat", "Open Hat",
        "Clap", "Crash", "Ride", "Tom 1",
        "Tom 2", "Cowbell", "Rim", "Perc 1",
        "Perc 2", "FX 1", "FX 2", "Vocal"
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("DRUM MACHINE")
                .font(.title2)
                .fontWeight(.bold)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 12) {
                ForEach(0..<16) { index in
                    VStack(spacing: 6) {
                        SquareDrumPad(
                            isPressed: $padStates[index],
                            velocity: $padVelocities[index]
                        ) {
                            triggerDrumSound(index: index, velocity: padVelocities[index])
                        }
                        .frame(width: 70, height: 70)
                        .hapticFeedback(.impact(.medium))
                        
                        Text(drumSounds[index])
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            // Transport controls
            HStack(spacing: 20) {
                Button("PLAY") {
                    startSequence()
                }
                .buttonStyle(.bordered)
                
                Button("STOP") {
                    stopSequence()
                }
                .buttonStyle(.bordered)
                
                Button("CLEAR") {
                    clearAllPads()
                }
                .buttonStyle(.bordered)
            }
        }
        .theme(.audioUINeumorphic)
        .padding(30)
    }
    
    private func triggerDrumSound(index: Int, velocity: Double) {
        // Trigger audio engine with velocity
        DrumEngine.shared.triggerSound(drumSounds[index], velocity: velocity)
        
        // Visual feedback
        withAnimation(.easeOut(duration: 0.3)) {
            padStates[index] = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            padStates[index] = false
        }
    }
    
    private func startSequence() {
        // Start sequencer
    }
    
    private func stopSequence() {
        // Stop sequencer
    }
    
    private func clearAllPads() {
        padStates = Array(repeating: false, count: 16)
    }
}
```

### CircularDrumPad
Round pads perfect for finger drumming and expressive playing:

```swift
struct FingerDrummingInterface: View {
    @State private var activePads: Set<Int> = []
    @State private var padPressures: [Double] = Array(repeating: 0.0, count: 8)
    
    let padColors: [Color] = [
        .red, .orange, .yellow, .green,
        .blue, .purple, .pink, .cyan
    ]
    
    var body: some View {
        VStack(spacing: 25) {
            Text("FINGER DRUMMING")
                .font(.title2)
                .fontWeight(.bold)
            
            // Main pad area
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                ForEach(0..<8) { index in
                    CircularDrumPad(
                        isPressed: .constant(activePads.contains(index)),
                        velocity: $padPressures[index]
                    ) {
                        triggerPad(index)
                    }
                    .frame(width: 100, height: 100)
                    .accentColor(padColors[index])
                    .onPressGesture(
                        onPress: { 
                            activePads.insert(index)
                            HapticManager.shared.impact(.heavy)
                        },
                        onRelease: { 
                            activePads.remove(index)
                            padPressures[index] = 0.0
                        }
                    )
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                // Convert force to velocity if available
                                #if os(iOS)
                                if let force = value.force {
                                    padPressures[index] = min(force, 1.0)
                                } else {
                                    padPressures[index] = 0.8
                                }
                                #else
                                padPressures[index] = 0.8
                                #endif
                            }
                    )
                }
            }
            
            // Velocity display
            HStack {
                Text("VELOCITY:")
                    .font(.caption)
                ForEach(0..<8) { index in
                    VStack {
                        Rectangle()
                            .fill(padColors[index])
                            .frame(width: 8, height: max(4, padPressures[index] * 40))
                        Text("\(Int(padPressures[index] * 127))")
                            .font(.system(size: 8))
                    }
                }
            }
        }
        .theme(.audioUINeumorphic)
        .padding(30)
    }
    
    private func triggerPad(_ index: Int) {
        let velocity = padPressures[index]
        DrumEngine.shared.triggerPad(index, velocity: velocity)
    }
}
```

### VelocityPad
Advanced pads with detailed velocity response and aftertouch:

```swift
struct ProfessionalDrumPads: View {
    @State private var pad1Velocity: Double = 0.0
    @State private var pad2Velocity: Double = 0.0
    @State private var pad3Velocity: Double = 0.0
    @State private var pad4Velocity: Double = 0.0
    
    @State private var pad1Aftertouch: Double = 0.0
    @State private var pad2Aftertouch: Double = 0.0
    @State private var pad3Aftertouch: Double = 0.0
    @State private var pad4Aftertouch: Double = 0.0
    
    var body: some View {
        VStack(spacing: 25) {
            Text("PROFESSIONAL DRUM PADS")
                .font(.title2)
                .fontWeight(.bold)
            
            HStack(spacing: 20) {
                professionalPad(
                    "KICK",
                    velocity: $pad1Velocity,
                    aftertouch: $pad1Aftertouch,
                    color: .red
                )
                
                professionalPad(
                    "SNARE",
                    velocity: $pad2Velocity,
                    aftertouch: $pad2Aftertouch,
                    color: .orange
                )
                
                professionalPad(
                    "HI-HAT",
                    velocity: $pad3Velocity,
                    aftertouch: $pad3Aftertouch,
                    color: .yellow
                )
                
                professionalPad(
                    "CRASH",
                    velocity: $pad4Velocity,
                    aftertouch: $pad4Aftertouch,
                    color: .blue
                )
            }
        }
        .theme(.audioUIMinimal)
        .padding(30)
    }
    
    private func professionalPad(
        _ label: String,
        velocity: Binding<Double>,
        aftertouch: Binding<Double>,
        color: Color
    ) -> some View {
        VStack(spacing: 12) {
            Text(label)
                .font(.caption)
                .fontWeight(.bold)
            
            VelocityPad(
                velocity: velocity,
                aftertouch: aftertouch
            ) {
                triggerSample(label, velocity: velocity.wrappedValue)
            }
            .frame(width: 80, height: 80)
            .accentColor(color)
            
            // Velocity meter
            VStack(spacing: 4) {
                Text("VEL")
                    .font(.system(size: 8))
                Rectangle()
                    .fill(color)
                    .frame(width: 15, height: max(2, velocity.wrappedValue * 30))
                Text("\(Int(velocity.wrappedValue * 127))")
                    .font(.system(size: 8))
            }
            
            // Aftertouch meter
            VStack(spacing: 4) {
                Text("AT")
                    .font(.system(size: 8))
                Rectangle()
                    .fill(color.opacity(0.6))
                    .frame(width: 15, height: max(2, aftertouch.wrappedValue * 30))
                Text("\(Int(aftertouch.wrappedValue * 127))")
                    .font(.system(size: 8))
            }
        }
    }
    
    private func triggerSample(_ name: String, velocity: Double) {
        SampleEngine.shared.trigger(name, velocity: velocity)
    }
}
```

## Pad Behavior

### Velocity Response
Drum pads provide multiple velocity response curves:

```swift
struct VelocityResponseExample: View {
    @State private var rawVelocity: Double = 0.0
    @State private var linearResponse: Double = 0.0
    @State private var logarithmicResponse: Double = 0.0
    @State private var exponentialResponse: Double = 0.0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("VELOCITY RESPONSE CURVES")
                .font(.caption)
                .fontWeight(.bold)
            
            HStack(spacing: 30) {
                // Linear response
                VStack {
                    Text("LINEAR")
                        .font(.caption2)
                    SquareDrumPad(
                        isPressed: .constant(false),
                        velocity: Binding(
                            get: { rawVelocity },
                            set: { 
                                rawVelocity = $0
                                linearResponse = $0
                            }
                        )
                    ) {
                        // Trigger with linear response
                    }
                    .frame(width: 60, height: 60)
                    Text("\(Int(linearResponse * 127))")
                        .font(.caption2)
                }
                
                // Logarithmic response (more sensitive to light touches)
                VStack {
                    Text("LOG")
                        .font(.caption2)
                    SquareDrumPad(
                        isPressed: .constant(false),
                        velocity: Binding(
                            get: { rawVelocity },
                            set: { 
                                rawVelocity = $0
                                logarithmicResponse = log10(($0 * 9) + 1)
                            }
                        )
                    ) {
                        // Trigger with logarithmic response
                    }
                    .frame(width: 60, height: 60)
                    Text("\(Int(logarithmicResponse * 127))")
                        .font(.caption2)
                }
                
                // Exponential response (more sensitive to hard hits)
                VStack {
                    Text("EXP")
                        .font(.caption2)
                    SquareDrumPad(
                        isPressed: .constant(false),
                        velocity: Binding(
                            get: { rawVelocity },
                            set: { 
                                rawVelocity = $0
                                exponentialResponse = pow($0, 2)
                            }
                        )
                    ) {
                        // Trigger with exponential response
                    }
                    .frame(width: 60, height: 60)
                    Text("\(Int(exponentialResponse * 127))")
                        .font(.caption2)
                }
            }
        }
    }
}
```

### Multi-Touch Support
Handle multiple simultaneous pad presses:

```swift
struct MultiTouchDrumPads: View {
    @State private var activeTouches: [CGPoint: Int] = [:]
    @State private var padStates: [Bool] = Array(repeating: false, count: 16)
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 8) {
            ForEach(0..<16) { index in
                SquareDrumPad(
                    isPressed: $padStates[index],
                    velocity: .constant(0.8)
                ) {
                    triggerPad(index)
                }
                .frame(width: 60, height: 60)
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            if !activeTouches.keys.contains(where: { 
                                abs($0.x - value.location.x) < 30 && abs($0.y - value.location.y) < 30 
                            }) {
                                activeTouches[value.location] = index
                                padStates[index] = true
                                triggerPad(index)
                            }
                        }
                        .onEnded { value in
                            activeTouches.removeValue(forKey: value.location)
                            padStates[index] = false
                        }
                )
            }
        }
    }
    
    private func triggerPad(_ index: Int) {
        DrumEngine.shared.triggerPad(index)
        HapticManager.shared.impact(.medium)
    }
}
```

## Advanced Features

### Step Sequencer Integration
Combine pads with sequencing for pattern creation:

```swift
struct StepSequencerDrumPads: View {
    @State private var currentStep: Int = 0
    @State private var isPlaying: Bool = false
    @State private var sequence: [[Bool]] = Array(repeating: Array(repeating: false, count: 16), count: 8)
    @State private var selectedTrack: Int = 0
    
    let trackNames = ["Kick", "Snare", "Hi-Hat", "Open Hat", "Clap", "Crash", "Tom", "Perc"]
    
    var body: some View {
        VStack(spacing: 20) {
            // Transport controls
            HStack {
                Button(isPlaying ? "STOP" : "PLAY") {
                    isPlaying.toggle()
                    if isPlaying {
                        startSequencer()
                    } else {
                        stopSequencer()
                    }
                }
                .buttonStyle(.bordered)
                
                Text("STEP: \(currentStep + 1)")
                    .font(.caption)
                    .frame(width: 80)
            }
            
            // Track selection
            HStack {
                ForEach(0..<8) { track in
                    Button(trackNames[track]) {
                        selectedTrack = track
                    }
                    .font(.caption2)
                    .foregroundColor(selectedTrack == track ? .white : .primary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(selectedTrack == track ? Color.blue : Color(.systemGray5))
                    .cornerRadius(4)
                }
            }
            
            // Step grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 16), spacing: 4) {
                ForEach(0..<16) { step in
                    SquareDrumPad(
                        isPressed: $sequence[selectedTrack][step],
                        velocity: .constant(0.8)
                    ) {
                        sequence[selectedTrack][step].toggle()
                    }
                    .frame(width: 25, height: 25)
                    .overlay(
                        Rectangle()
                            .stroke(currentStep == step ? Color.yellow : Color.clear, lineWidth: 2)
                    )
                }
            }
            
            // Sample trigger pads
            HStack {
                ForEach(0..<8) { track in
                    VStack {
                        CircularDrumPad(
                            isPressed: .constant(false),
                            velocity: .constant(0.8)
                        ) {
                            triggerSample(track)
                        }
                        .frame(width: 40, height: 40)
                        
                        Text(trackNames[track])
                            .font(.system(size: 8))
                    }
                }
            }
        }
        .theme(.audioUIMinimal)
        .padding()
    }
    
    private func startSequencer() {
        Timer.scheduledTimer(withTimeInterval: 0.125, repeats: true) { timer in
            if !isPlaying {
                timer.invalidate()
                return
            }
            
            // Trigger active steps
            for track in 0..<8 {
                if sequence[track][currentStep] {
                    triggerSample(track)
                }
            }
            
            currentStep = (currentStep + 1) % 16
        }
    }
    
    private func stopSequencer() {
        currentStep = 0
    }
    
    private func triggerSample(_ track: Int) {
        DrumEngine.shared.triggerTrack(track)
    }
}
```

### MPC-Style Pad Bank
Multi-bank pad layout inspired by classic drum machines:

```swift
struct MPCStyleInterface: View {
    @State private var currentBank: Int = 0
    @State private var padStates: [[Bool]] = Array(repeating: Array(repeating: false, count: 16), count: 4)
    @State private var padVelocities: [Double] = Array(repeating: 0.0, count: 16)
    
    var body: some View {
        VStack(spacing: 20) {
            // Bank selection
            HStack {
                Text("BANK:")
                    .font(.caption)
                
                ForEach(0..<4) { bank in
                    Button("\(bank + 1)") {
                        currentBank = bank
                    }
                    .font(.caption)
                    .frame(width: 30, height: 25)
                    .foregroundColor(currentBank == bank ? .white : .primary)
                    .background(currentBank == bank ? Color.blue : Color(.systemGray5))
                    .cornerRadius(4)
                }
            }
            
            // Main pad grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 12) {
                ForEach(0..<16) { index in
                    VStack {
                        SquareDrumPad(
                            isPressed: $padStates[currentBank][index],
                            velocity: $padVelocities[index]
                        ) {
                            triggerPadInBank(bank: currentBank, pad: index)
                        }
                        .frame(width: 80, height: 80)
                        
                        Text("\(index + 1)")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            // Velocity and timing controls
            HStack(spacing: 30) {
                VStack {
                    Text("VELOCITY")
                        .font(.caption)
                    HStack {
                        ForEach(0..<16) { index in
                            Rectangle()
                                .fill(Color.green)
                                .frame(width: 4, height: max(2, padVelocities[index] * 40))
                        }
                    }
                }
                
                VStack {
                    Text("SWING")
                        .font(.caption)
                    Slider(value: .constant(50), in: 0...100)
                        .frame(width: 100)
                }
            }
        }
        .theme(.audioUINeumorphic)
        .padding(30)
    }
    
    private func triggerPadInBank(bank: Int, pad: Int) {
        let sampleIndex = (bank * 16) + pad
        DrumEngine.shared.triggerSample(sampleIndex, velocity: padVelocities[pad])
        
        // Visual feedback
        withAnimation(.easeOut(duration: 0.2)) {
            padStates[bank][pad] = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            padStates[bank][pad] = false
        }
    }
}
```

## Performance Considerations

### Efficient Touch Handling
```swift
// ✅ Good: Batch touch updates
private func handleTouchUpdates(_ touches: Set<UITouch>) {
    let updates = touches.compactMap { touch in
        // Process touch and return update
    }
    
    DispatchQueue.main.async {
        applyUpdates(updates)
    }
}

// ❌ Avoid: Individual touch processing
// Don't process each touch separately in real-time
```

### Audio Integration
```swift
// ✅ Optimized audio triggering
class DrumEngine: ObservableObject {
    private let audioEngine = AudioEngine()
    private let sampleCache = SampleCache()
    
    func triggerPad(_ index: Int, velocity: Double) {
        // Use pre-loaded samples for zero-latency triggering
        let sample = sampleCache.getSample(for: index)
        audioEngine.playSample(sample, velocity: velocity)
    }
}
```

## See Also

- <doc:XYPads> - Two-dimensional control surfaces
- <doc:MotionControls> - Gesture-based interfaces
- <doc:AudioUIComponents> - Complete component overview
- <doc:DrumMachineTutorial> - Building a complete drum machine
