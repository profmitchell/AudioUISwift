# AudioUICore Module

The foundation layer providing primitive audio interface controls with precise gesture handling and real-time performance.

## Overview

AudioUICore contains the essential building blocks for audio interfaces - fundamental controls that prioritize functionality over visual styling. These primitives form the foundation that all AudioUI components build upon.

Think of AudioUICore as the "raw materials" for building audio interfaces. While they're functional and precise, they focus on core behavior rather than visual design.

## Core Primitives

### Knob Primitive

The fundamental rotary control for continuous parameters:

```swift
import AudioUICore

struct BasicKnob: View {
    @State private var frequency: Double = 0.5
    
    var body: some View {
        Knob(value: $frequency) { newValue in
            // Direct audio parameter control
            audioEngine.setFrequency(newValue * 20000) // Scale to 0-20kHz
        }
        .frame(width: 60, height: 60)
    }
}
```

**Key Features:**
- Precise gesture recognition for fine control
- Configurable value ranges and step sizes
- Real-time value change callbacks
- Optimized for 60fps interaction

**Best For:**
- Frequency controls (oscillators, filters)
- Gain and volume controls
- Time-based parameters (delay, attack, release)
- Any continuous parameter without clear boundaries

### Fader Primitive

Linear control optimized for level-based parameters:

```swift
struct BasicFader: View {
    @State private var channelLevel: Double = 0.75
    
    var body: some View {
        Fader(
            value: $channelLevel,
            orientation: .vertical
        ) { newLevel in
            mixer.setChannelLevel(newLevel)
        }
        .frame(width: 40, height: 200)
    }
}
```

**Key Features:**
- Vertical and horizontal orientations
- Linear value mapping (perfect for decibel scales)
- Touch-optimized gesture handling
- Professional mixing console feel

**Best For:**
- Channel levels and mix controls
- Send and return amounts
- Crossfader controls
- Any parameter with clear minimum/maximum boundaries

### XYPad Primitive

Two-dimensional control surface for parameter pairs:

```swift
struct BasicXYPad: View {
    @State private var filterParams = CGPoint(x: 0.5, y: 0.3)
    
    var body: some View {
        XYPad(value: $filterParams) { newPosition in
            let cutoff = newPosition.x * 20000    // 0-20kHz
            let resonance = newPosition.y * 10     // 0-10 Q factor
            filter.setParameters(cutoff: cutoff, resonance: resonance)
        }
        .frame(width: 200, height: 200)
    }
}
```

**Key Features:**
- Simultaneous two-parameter control
- Configurable coordinate mapping
- Visual position indicators
- Precise touch tracking

**Best For:**
- Filter cutoff/resonance control
- Spatial audio positioning
- Delay time/feedback combinations
- Any two related parameters

### PadButton Primitive

Velocity-sensitive trigger for percussive controls:

```swift
struct BasicDrumPad: View {
    var body: some View {
        PadButton { velocity in
            drumMachine.trigger(.kick, velocity: velocity)
        }
        .frame(width: 80, height: 80)
    }
}
```

**Key Features:**
- Velocity-sensitive triggering
- Multiple trigger modes (momentary, toggle, latching)
- Configurable velocity curves
- Real-time tactile feedback

**Best For:**
- Drum machine interfaces
- Sample triggering
- Note-on/note-off controls
- Any momentary action triggers

### ToggleButton Primitive

State-based switching control:

```swift
struct BasicToggle: View {
    @State private var isMuted: Bool = false
    
    var body: some View {
        ToggleButton(isOn: $isMuted) { muted in
            audioChannel.setMuted(muted)
        }
    }
}
```

**Key Features:**
- Clear on/off visual states
- Immediate state feedback
- Configurable toggle behavior
- Accessibility-optimized

**Best For:**
- Mute/unmute controls
- Solo/unsolo switches
- Effect bypass toggles
- Any binary state controls

### LED Primitive

Status indicator with real-time updates:

```swift
struct BasicLED: View {
    @State private var isActive: Bool = false
    
    var body: some View {
        LED(
            isActive: $isActive,
            color: .green,
            intensity: 0.8
        )
        .onReceive(audioEngine.activityPublisher) { active in
            isActive = active
        }
    }
}
```

**Key Features:**
- Configurable colors and intensity
- Smooth on/off transitions
- Real-time status updates
- Low CPU overhead

**Best For:**
- Signal present indicators
- Clipping warnings
- Status monitoring
- Activity feedback

### LevelMeter Primitive

Real-time audio visualization:

```swift
struct BasicLevelMeter: View {
    @State private var level: Float = 0.0
    
    var body: some View {
        LevelMeter(
            level: $level,
            orientation: .vertical,
            peakHold: true
        )
        .frame(width: 20, height: 150)
        .onReceive(audioEngine.levelPublisher) { newLevel in
            level = newLevel
        }
    }
}
```

**Key Features:**
- Real-time level display
- Peak hold functionality
- Configurable scale markings
- Optimized for 60fps updates

**Best For:**
- Input/output metering
- Gain reduction visualization
- Real-time audio monitoring
- Signal level feedback

### GyroscopePrimitive

Motion-based control using device orientation:

```swift
struct BasicMotionControl: View {
    @State private var motionValue: CGPoint = .zero
    
    var body: some View {
        GyroscopePrimitive(value: $motionValue) { motion in
            spatialProcessor.setPosition(
                x: motion.x,
                y: motion.y
            )
        }
        .frame(width: 150, height: 150)
    }
}
```

**Key Features:**
- Real-time motion tracking
- Configurable sensitivity
- Platform-optimized implementation
- Battery-efficient operation

**Best For:**
- Spatial audio effects
- Performance controllers
- Gesture-based interaction
- Motion-responsive parameters

## Why Use Primitives?

### Learning Audio Interface Development

Primitives help you understand:
- **Core Interaction Patterns**: How audio controls should behave
- **Gesture Recognition**: Touch and mouse handling for precision
- **Real-time Performance**: Optimizations needed for audio applications
- **Parameter Mapping**: Converting UI gestures to audio parameters

### Building Custom Components

Use primitives when:
- Built-in components don't match your exact needs
- You want complete control over visual styling
- You're prototyping new interaction paradigms
- You need maximum performance optimization

### Incremental Adoption

Start with primitives to:
- Learn AudioUI concepts without visual complexity
- Build understanding of audio parameter types
- Create proof-of-concept interfaces
- Gradually add visual sophistication

## Performance Characteristics

AudioUICore primitives are optimized for:

### Real-time Audio Applications
- 60fps interaction with minimal CPU overhead
- Direct parameter updates without intermediate layers
- Efficient gesture recognition algorithms
- Memory-conscious implementation

### Cross-platform Consistency
- Identical behavior across iOS, macOS, watchOS, and tvOS
- Platform-specific optimizations (touch vs mouse)
- Consistent timing and responsiveness
- Unified API across all platforms

## Integration with Audio Engines

### AVAudioEngine Integration

```swift
import AVFoundation
import AudioUICore

class AudioEngineController: ObservableObject {
    private let engine = AVAudioEngine()
    private let player = AVAudioPlayerNode()
    
    func connectKnob() -> some View {
        Knob(value: .constant(0.5)) { value in
            // Direct AVAudioEngine parameter control
            player.volume = Float(value)
        }
    }
}
```

### AudioKit Integration

```swift
import AudioKit
import AudioUICore

class AudioKitController: ObservableObject {
    private let oscillator = Oscillator()
    
    func connectFrequencyKnob() -> some View {
        Knob(value: .constant(0.5)) { normalizedValue in
            // Map to AudioKit parameter range
            oscillator.frequency = normalizedValue * 2000 // 0-2000Hz
        }
    }
}
```

## Building Your First Primitive Interface

Here's a complete example using only AudioUICore primitives:

```swift
import SwiftUI
import AudioUICore

struct PrimitiveAudioInterface: View {
    @State private var volume: Double = 0.5
    @State private var frequency: Double = 0.5
    @State private var isPlaying: Bool = false
    @State private var level: Float = 0.0
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Primitive Audio Interface")
                .font(.title)
            
            HStack(spacing: 40) {
                // Volume control
                VStack {
                    Text("Volume")
                    Fader(value: $volume) { newValue in
                        audioEngine.setVolume(newValue)
                    }
                    .frame(width: 40, height: 150)
                }
                
                // Frequency control
                VStack {
                    Text("Frequency")
                    Knob(value: $frequency) { newValue in
                        audioEngine.setFrequency(newValue * 2000)
                    }
                    .frame(width: 80, height: 80)
                }
                
                // Level meter
                VStack {
                    Text("Level")
                    LevelMeter(level: $level)
                        .frame(width: 20, height: 150)
                }
            }
            
            // Play/Stop control
            ToggleButton(isOn: $isPlaying) { playing in
                if playing {
                    audioEngine.start()
                } else {
                    audioEngine.stop()
                }
            }
        }
        .padding()
    }
}
```

## When to Graduate to Components

Move from primitives to styled components when:
- You need consistent visual design across your app
- You want to apply professional theming
- You're building production interfaces
- You need pre-built accessibility features

## Next Steps

After mastering AudioUICore primitives:

1. **Explore AudioUITheme**: Learn how theming transforms primitives into beautiful components
2. **Study AudioUIComponents**: See how primitives become production-ready controls
3. **Build Custom Components**: Create your own styled components using primitives as foundation
4. **Optimize Performance**: Learn advanced techniques for real-time audio interfaces

AudioUICore provides the solid foundation that makes everything else in AudioUI possible. Understanding these primitives will make you a better audio interface developer and help you build more efficient, responsive, and professional audio applications.
