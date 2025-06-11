# Building Your First Audio Interface

Learn to create professional audio interfaces by building a complete synthesizer control panel from scratch.

## Overview

This tutorial walks you through creating your first audio interface with AudioUI. You'll learn the fundamentals of audio control design, theming, and real-time parameter management while building a functional synthesizer interface.

By the end of this tutorial, you'll understand:
- How to choose the right controls for different audio parameters
- The difference between minimal and neumorphic design philosophies
- How to connect interface controls to audio parameters
- Best practices for audio interface layout and organization

## What You'll Build

A complete synthesizer interface featuring:
- Frequency control with a precision knob
- Volume control with a vertical fader
- Filter controls using XY pad interaction
- Play/stop functionality with toggle buttons
- Professional theming and visual feedback

## Prerequisites

- Basic SwiftUI knowledge
- Understanding of audio parameters (frequency, amplitude, filtering)
- Xcode 15.0+ with iOS 17.0+ or macOS 14.0+ target

## Step 1: Set Up Your Audio Parameters

Start by defining the audio parameters your interface will control:

```swift
import SwiftUI
import AudioUI

struct MySynthInterface: View {
    // Core audio parameters
    @State private var frequency: Double = 440.0      // A4 note (440Hz)
    @State private var amplitude: Double = 0.5        // 50% volume
    @State private var filterCutoff: Double = 0.7     // 70% cutoff frequency
    @State private var filterResonance: Double = 0.3  // 30% resonance
    @State private var isPlaying: Bool = false        // Playback state
    
    var body: some View {
        // Interface coming next...
    }
}
```

> **Learning Point**: Notice how audio parameters use normalized values (0.0-1.0) in the interface, then get scaled to appropriate ranges (like 20Hz-20kHz for frequency) when connecting to audio engines.

## Step 2: Add Frequency Control

Use a knob for frequency control - perfect for continuous parameters without clear min/max boundaries:

```swift
var body: some View {
    VStack(spacing: 40) {
        Text("My First Synthesizer")
            .font(.largeTitle)
            .fontWeight(.bold)
        
        // Frequency control section
        VStack(spacing: 12) {
            Text("Frequency")
                .font(.headline)
            
            Text("\(Int(frequency))Hz")
                .font(.title2)
                .foregroundColor(.blue)
            
            // Use a minimal knob for precise frequency control
            KnobMinimal1(value: Binding(
                get: { frequency / 2000 }, // Normalize to 0-1 for UI
                set: { frequency = $0 * 2000 } // Scale to 0-2000Hz range
            ))
            .frame(width: 100, height: 100)
        }
    }
    .padding()
}
```

> **Learning Point**: Audio interfaces often need to transform between UI ranges (0-1) and audio ranges (20Hz-20kHz). This separation keeps the UI controls consistent while allowing flexible audio parameter scaling.

## Step 3: Add Volume Control

Use a vertical fader for volume - this follows mixing console conventions:

```swift
// Add this after the frequency control
VStack(spacing: 12) {
    Text("Volume")
        .font(.headline)
    
    Text("\(Int(amplitude * 100))%")
        .font(.title2)
        .foregroundColor(.green)
    
    // Vertical fader mimics mixing console faders
    VerticalInsetSlider(value: $amplitude)
        .frame(width: 60, height: 150)
}
```

> **Learning Point**: Volume controls almost always use vertical faders because this matches the mental model from physical mixing consoles. The vertical motion feels natural for "turning up" or "turning down" volume.

## Step 4: Add Filter Controls

Use an XY pad for two-dimensional filter control:

```swift
// Add this after the volume control
VStack(spacing: 12) {
    Text("Filter")
        .font(.headline)
    
    HStack {
        Text("Cutoff: \(Int(filterCutoff * 100))%")
        Spacer()
        Text("Resonance: \(Int(filterResonance * 100))%")
    }
    .font(.caption)
    
    // XY pad for two-dimensional filter control
    NeumorphicXYPad(value: Binding(
        get: { CGPoint(x: filterCutoff, y: filterResonance) },
        set: { 
            filterCutoff = $0.x
            filterResonance = $0.y
        }
    ))
    .frame(width: 180, height: 180)
}
```

> **Learning Point**: XY pads excel at controlling two related parameters simultaneously. Filter cutoff and resonance work well together - users can "sweep" the filter while adjusting resonance for different timbral effects.

## Step 5: Add Play/Stop Control

Use a toggle button for play state management:

```swift
// Add this at the bottom of your VStack
InsetToggleButton(
    label: isPlaying ? "STOP" : "PLAY", 
    isOn: $isPlaying
)
.onChange(of: isPlaying) { playing in
    if playing {
        startSynthesis()
    } else {
        stopSynthesis()
    }
}
```

## Step 6: Connect to Audio Engine

Add the audio connection functions:

```swift
// Add these functions to your view
private func startSynthesis() {
    // Connect to your audio engine here
    print("🎵 Starting synthesis:")
    print("  Frequency: \(frequency)Hz")
    print("  Amplitude: \(amplitude)")
    print("  Filter: cutoff=\(filterCutoff), resonance=\(filterResonance)")
    
    // In a real app, you'd configure your audio engine:
    // audioEngine.oscillator.frequency = frequency
    // audioEngine.oscillator.amplitude = amplitude
    // audioEngine.filter.cutoff = filterCutoff * 20000 // Scale to 0-20kHz
    // audioEngine.filter.resonance = filterResonance * 10 // Scale to 0-10
    // audioEngine.start()
}

private func stopSynthesis() {
    print("🛑 Stopping synthesis")
    
    // In a real app:
    // audioEngine.stop()
}
```

## Step 7: Apply Professional Theming

Transform your interface with AudioUI's theming system:

```swift
var body: some View {
    VStack(spacing: 40) {
        // ... your interface controls ...
    }
    .padding()
    .theme(.audioUINeumorphic) // Apply neumorphic theme
    .preferredColorScheme(.dark) // Professional dark appearance
}
```

## Complete Interface

Here's your complete first audio interface:

```swift
import SwiftUI
import AudioUI

struct MySynthInterface: View {
    @State private var frequency: Double = 440.0
    @State private var amplitude: Double = 0.5
    @State private var filterCutoff: Double = 0.7
    @State private var filterResonance: Double = 0.3
    @State private var isPlaying: Bool = false
    
    var body: some View {
        VStack(spacing: 40) {
            Text("My First Synthesizer")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            HStack(spacing: 40) {
                // Frequency Control
                VStack(spacing: 12) {
                    Text("Frequency")
                        .font(.headline)
                    Text("\(Int(frequency))Hz")
                        .font(.title2)
                        .foregroundColor(.blue)
                    KnobMinimal1(value: Binding(
                        get: { frequency / 2000 },
                        set: { frequency = $0 * 2000 }
                    ))
                    .frame(width: 100, height: 100)
                }
                
                // Volume Control
                VStack(spacing: 12) {
                    Text("Volume")
                        .font(.headline)
                    Text("\(Int(amplitude * 100))%")
                        .font(.title2)
                        .foregroundColor(.green)
                    VerticalInsetSlider(value: $amplitude)
                        .frame(width: 60, height: 150)
                }
                
                // Filter Control
                VStack(spacing: 12) {
                    Text("Filter")
                        .font(.headline)
                    HStack {
                        Text("C: \(Int(filterCutoff * 100))%")
                        Spacer()
                        Text("R: \(Int(filterResonance * 100))%")
                    }
                    .font(.caption)
                    NeumorphicXYPad(value: Binding(
                        get: { CGPoint(x: filterCutoff, y: filterResonance) },
                        set: { 
                            filterCutoff = $0.x
                            filterResonance = $0.y
                        }
                    ))
                    .frame(width: 150, height: 150)
                }
            }
            
            // Play/Stop Control
            InsetToggleButton(
                label: isPlaying ? "STOP" : "PLAY", 
                isOn: $isPlaying
            )
            .onChange(of: isPlaying) { playing in
                if playing {
                    startSynthesis()
                } else {
                    stopSynthesis()
                }
            }
        }
        .padding()
        .theme(.audioUINeumorphic)
        .preferredColorScheme(.dark)
    }
    
    private func startSynthesis() {
        print("🎵 Starting synthesis at \(frequency)Hz, volume \(amplitude)")
    }
    
    private func stopSynthesis() {
        print("🛑 Stopping synthesis")
    }
}
```

## What You've Learned

Congratulations! You've built a complete audio interface and learned:

### Audio UI Fundamentals
- **Knobs for continuous parameters**: Frequency, gain, and other endless controls
- **Faders for level controls**: Volume, channel levels, and mixing parameters  
- **XY pads for dual parameters**: Filter controls, spatial effects, and complex parameter pairs
- **Toggle buttons for state**: Play/stop, mute/unmute, and bypass controls

### Design Principles
- **Hardware metaphors**: Vertical faders match physical mixing consoles
- **Parameter mapping**: Transform between UI ranges (0-1) and audio ranges (20Hz-20kHz)
- **Visual feedback**: Real-time parameter display enhances user understanding
- **Professional theming**: Dark themes reduce eye strain in studio environments

### AudioUI Architecture
- **Separation of concerns**: UI controls handle interaction, audio engines handle sound
- **Flexible theming**: Switch between minimal and neumorphic styles
- **Cross-platform design**: Same code works on iOS, macOS, and other Apple platforms

## Next Steps

Now that you understand the basics:

1. **Explore More Components**: Try drum pads, gyroscope controls, and level meters
2. **Learn About Theming**: <doc:ThemingGuide> - Create custom themes
3. **Build a Drum Machine**: <doc:DrumMachineTutorial> - Learn about rhythm interfaces
4. **Optimize Performance**: <doc:PerformanceOptimization> - Best practices for real-time audio

## Key Takeaways

- **AudioUI provides professional-grade components** out of the box
- **Theming separates visual style from functionality** - switch themes without changing code
- **Components are designed for audio precision** with appropriate ranges and gestures
- **Multiple visual approaches** let you match your app's personality (minimal vs neumorphic)

You've built a complete synthesizer interface in just a few steps. AudioUI's thoughtful design makes complex audio interfaces approachable while maintaining the precision and performance that audio applications demand.
