# Getting Started with AudioUI

Build your first professional audio interface in 15 minutes.

## Overview

This comprehensive guide walks you through creating a complete synthesizer interface using AudioUI. You'll learn core concepts, component usage, and theming while building a functional audio control surface.

By the end of this tutorial, you'll have:
- A complete synthesizer interface with frequency, volume, filter, and XY controls
- Deep understanding of AudioUI's architecture and design philosophies
- Knowledge of theming, customization, and performance best practices
- A solid foundation for building any type of audio interface

## What You'll Build

A professional synthesizer interface featuring:
- **Frequency knob** with hardware-inspired neumorphic design
- **Volume fader** with smooth gesture interaction
- **Filter controls** using minimal design philosophy
- **XY pad** for expressive parameter control
- **Transport controls** with play/stop functionality
- **Visual feedback** and real-time parameter display

## Prerequisites

- **Xcode 15.0+** with iOS 15.0+ deployment target (iOS 18.0+ recommended)
- **Basic SwiftUI knowledge** - Views, state management, bindings
- **AudioUI framework** added to your project

## Installation

Add AudioUI to your project using Swift Package Manager:

```swift
// In Package.swift
dependencies: [
    .package(url: "https://github.com/your-org/AudioUI", from: "1.0.0")
]
```

Or through Xcode: File → Add Package Dependencies → Enter AudioUI URL

## Step 1: Project Setup & Imports

Create a new SwiftUI view and import the AudioUI modules:

```swift
import SwiftUI
import AudioUI
import AudioUICore
import AudioUITheme
import AudioUIComponents

struct MySynthInterface: View {
    var body: some View {
        Text("Hello, AudioUI!")
            .theme(.audioUINeumorphic) // Apply default theme
    }
}
```

> **Important**: Always apply a theme to your root view. AudioUI components rely on theme data for colors, spacing, and visual effects.

## Step 2: Audio State Management

Define state variables for your synthesizer parameters:

```swift
struct MySynthInterface: View {
    // Core audio parameters (normalized 0.0 - 1.0)
    @State private var frequency: Double = 0.5      // 50% of frequency range
    @State private var amplitude: Double = 0.7      // 70% volume
    @State private var filterCutoff: Double = 0.8   // 80% filter cutoff
    @State private var resonance: Double = 0.3      // 30% resonance
    
    // XY pad for complex control
    @State private var xyPosition = CGPoint(x: 0.5, y: 0.5)
    
    // Transport and UI state
    @State private var isPlaying: Bool = false
    @State private var selectedPreset: Int = 0
    
    var body: some View {
        // We'll build this step by step
    }
}
```

> **Best Practice**: Store audio parameters as normalized values (0.0-1.0) and scale them to actual ranges when needed. This makes parameter mapping and automation much easier.

## Step 3: Your First Component - Frequency Knob

Add a professional neumorphic knob for frequency control:

```swift
var body: some View {
    VStack(spacing: 40) {
        // Header
        Text("AudioUI Synthesizer")
            .font(.largeTitle)
            .fontWeight(.bold)
            .audioUIAccent()
        
        // Frequency control with real-time display
        VStack(spacing: 20) {
            Text("FREQUENCY")
                .audioUILabel(.section)
            
            InsetNeumorphicKnob(
                value: $frequency,
                onValueChange: { newValue in
                    // Real-time parameter updates
                    let hz = 80 + (newValue * 1920) // 80Hz to 2000Hz range
                    print("Frequency: \(Int(hz))Hz")
                }
            )
            .frame(width: 120, height: 120)
            
            // Real-time value display
            Text("\(Int(80 + frequency * 1920))Hz")
                .audioUILabel(.value)
                .fontDesign(.monospaced)
        }
    }
    .padding(40)
    .theme(.audioUINeumorphic)
}
```

> **Component Tip**: The `InsetNeumorphicKnob` provides hardware-inspired tactile feedback with smooth rotation, velocity sensitivity, and realistic depth effects.

## Step 4: Add Volume Control with a Fader

Add a vertical fader for volume control:

```swift
var body: some View {
    VStack(spacing: 40) {
        Text("My First Synthesizer")
            .font(.largeTitle)
            .fontWeight(.bold)
        
        HStack(spacing: 60) {
            // Frequency control
            VStack {
                Text("Frequency: \(Int(frequency))Hz")
                    .font(.headline)
                
                InsetRotaryKnob(value: Binding(
                    get: { frequency / 2000 },
                    set: { frequency = $0 * 2000 }
                ))
                .frame(width: 120, height: 120)
            }
            
            // Volume control
            VStack {
                Text("Volume: \(Int(amplitude * 100))%")
                    .font(.headline)
                
                VerticalInsetSlider(value: $amplitude)
                    .frame(width: 60, height: 200)
            }
        }
    }
    .padding()
}
```

> Note: Faders are ideal for parameters like volume where the visual metaphor of "level" is important.

## Step 5: Add Two-Dimensional Control with an XY Pad

XY pads are perfect for controlling two related parameters simultaneously:

```swift
var body: some View {
    VStack(spacing: 40) {
        Text("My First Synthesizer")
            .font(.largeTitle)
            .fontWeight(.bold)
        
        HStack(spacing: 60) {
            // Frequency control
            VStack {
                Text("Frequency: \(Int(frequency))Hz")
                    .font(.headline)
                
                InsetRotaryKnob(value: Binding(
                    get: { frequency / 2000 },
                    set: { frequency = $0 * 2000 }
                ))
                .frame(width: 120, height: 120)
            }
            
            // Volume control
            VStack {
                Text("Volume: \(Int(amplitude * 100))%")
                    .font(.headline)
                
                VerticalInsetSlider(value: $amplitude)
                    .frame(width: 60, height: 200)
            }
            
            // Filter control using XY pad
            VStack {
                Text("Filter")
                    .font(.headline)
                
                NeumorphicXYPad(value: Binding(
                    get: { CGPoint(x: filterCutoff, y: 0.5) },
                    set: { filterCutoff = $0.x }
                ))
                .frame(width: 150, height: 150)
            }
        }
    }
    .padding()
}
```

> Advanced: XY pads are commonly used for filter cutoff/resonance, delay feedback/time, or reverb size/damping.

## Step 6: Add Transport Control

Add a play/stop button to complete the interface:

```swift
var body: some View {
    VStack(spacing: 40) {
        Text("My First Synthesizer")
            .font(.largeTitle)
            .fontWeight(.bold)
        
        HStack(spacing: 60) {
            // ... existing controls ...
        }
        
        // Transport control
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
}

// Audio engine integration (conceptual)
func startSynthesis() {
    print("Starting synthesis at \(frequency)Hz, volume \(amplitude)")
    // Connect to your audio engine here
}

func stopSynthesis() {
    print("Stopping synthesis")
    // Stop your audio engine here
}
```

## Step 7: Apply Professional Theming

Transform your interface with AudioUI's theming system:

```swift
var body: some View {
    VStack(spacing: 40) {
        // ... your interface ...
    }
    .padding()
    .theme(.audioUINeumorphic) // Apply neumorphic theme
    .preferredColorScheme(.dark) // Professional dark appearance
}
```

### Try Different Themes

Experiment with different visual styles:

```swift
.theme(.audioUIMinimal)     // Clean, professional
.theme(.darkPro)           // Studio standard
.theme(.sunset)            // Creative warmth
.theme(.ocean)             // Calm focus
```

## Step 8: Understanding Component Selection

AudioUI provides multiple components for each control type. Here's when to use each:

### Knob Choices
- `InsetRotaryKnob`: Hardware-inspired with grip ridges (frequency, gain)
- `KnobMinimal1`: Clean fill style (volume, levels)
- `KnobMinimal2`: Stepped style (discrete parameters)
- `InsetNeumorphicKnob`: Premium tactile feel (creative apps)

### Fader Choices
- `VerticalInsetSlider`: Professional mixing console style
- `InsetHorizontalFader`: Compact horizontal layout
- `SliderMinimal1`: Ultra-clean minimal style
- `VerticalNeumorphicFader`: Soft, tactile feel

### Button Choices
- `InsetToggleButton`: Professional transport controls
- `InsetCircularButton`: Icon-based actions
- `MinimalButton1`: Clean, functional style
- `NeumorphicButton1`: Tactile, premium feel

## Complete Example

Here's your finished synthesizer interface:

```swift
import SwiftUI
import AudioUI

struct MySynthInterface: View {
    @State private var frequency: Double = 440.0
    @State private var amplitude: Double = 0.5
    @State private var filterCutoff: Double = 0.7
    @State private var isPlaying: Bool = false
    
    var body: some View {
        VStack(spacing: 40) {
            Text("My First Synthesizer")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            HStack(spacing: 60) {
                // Frequency control
                VStack {
                    Text("Frequency: \(Int(frequency))Hz")
                        .font(.headline)
                    
                    InsetRotaryKnob(value: Binding(
                        get: { frequency / 2000 },
                        set: { frequency = $0 * 2000 }
                    ))
                    .frame(width: 120, height: 120)
                }
                
                // Volume control
                VStack {
                    Text("Volume: \(Int(amplitude * 100))%")
                        .font(.headline)
                    
                    VerticalInsetSlider(value: $amplitude)
                        .frame(width: 60, height: 200)
                }
                
                // Filter control
                VStack {
                    Text("Filter")
                        .font(.headline)
                    
                    NeumorphicXYPad(value: Binding(
                        get: { CGPoint(x: filterCutoff, y: 0.5) },
                        set: { filterCutoff = $0.x }
                    ))
                    .frame(width: 150, height: 150)
                }
            }
            
            // Transport control
            InsetToggleButton(
                label: isPlaying ? "STOP" : "PLAY", 
                isOn: $isPlaying
            )
        }
        .padding()
        .theme(.audioUINeumorphic)
        .preferredColorScheme(.dark)
    }
}
```

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
