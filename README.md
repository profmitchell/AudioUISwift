# AudioUI

A comprehensive, unified SwiftUI framework for building sophisticated audio user interfaces. AudioUI combines powerful primitives, advanced theming, production-ready components, and Metal-powered effects into a single, cohesive package.

## Overview

AudioUI provides everything you need to build professional audio applications with hardware-inspired controls and modern interaction patterns. The framework is designed with performance, customization, and ease of use in mind - perfect for learning audio interface development or building production apps.

### What Makes AudioUI Special?

AudioUI isn't just another UI library - it's specifically crafted for audio applications where precision, tactile feedback, and real-time interaction are critical. Whether you're building a DAW, synthesizer, mixer, or effects processor, AudioUI provides the building blocks you need.

### Key Features

- **🎛️ Professional Audio Controls**: Hardware-inspired knobs, faders, XY pads, and drum pads that feel authentic
- **🎨 Advanced Theming System**: Flexible Looks & Feels architecture with pre-built themes - learn how professional theming works
- **⚡ High Performance**: 60fps interactions with Metal-powered GPU acceleration for complex UIs
- **🧩 Modular Architecture**: Use individual modules or the complete framework - great for understanding component design
- **📱 Multi-Platform**: iOS, macOS, watchOS, and tvOS support with optimized interactions for each platform
- **🎵 Production-Ready Components**: 50+ carefully crafted components across 8 categories, embodying two distinct design philosophies
- **📚 Learning-Friendly**: Comprehensive documentation, examples, and clear architectural patterns to help you understand audio UI development

## Learning Path & Getting Started

### If You're New to Audio UI Development

AudioUI is designed to be educational. Here's how to approach learning:

1. **Start with Core Concepts**: Understand the difference between primitives (basic building blocks) and components (styled, production-ready controls)
2. **Explore the Theming System**: Learn how Looks (visual styling) separate from Feels (interaction behavior)
3. **Build Simple Examples**: Start with basic knobs and sliders before moving to complex components
4. **Understand Design Philosophies**: Compare Minimal vs Neumorphic designs to understand different UI approaches

### Quick Start Examples

#### Your First AudioUI Control

```swift
import SwiftUI
import AudioUI

struct MyFirstAudioControl: View {
    @State private var volume: Double = 0.5
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Volume: \(Int(volume * 100))%")
            
            // A beautiful, hardware-inspired knob
            InsetNeumorphicKnob(value: $volume)
                .frame(width: 120, height: 120)
        }
        .padding()
    }
}
```

#### Building a Simple Mixer Channel

```swift
struct SimpleMixerChannel: View {
    @State private var gain: Double = 0.5
    @State private var high: Double = 0.5
    @State private var mid: Double = 0.5
    @State private var low: Double = 0.5
    @State private var level: Double = 0.8
    @State private var isMuted: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            // EQ Section - Learn how to group related controls
            VStack(spacing: 15) {
                Text("3-Band EQ")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                KnobMinimal2(value: $high)   // High frequency
                KnobMinimal2(value: $mid)    // Mid frequency  
                KnobMinimal2(value: $low)    // Low frequency
            }
            
            // Gain control
            InsetRotaryKnob(value: $gain)
            
            // Main level fader
            VerticalInsetSlider(value: $level)
                .frame(height: 200)
            
            // Mute button
            InsetToggleButton(label: "MUTE", isOn: $isMuted)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
    }
}
```

### Understanding Component Recommendations

AudioUI provides intelligent component recommendations based on your application type:

```swift
import AudioUI

// Get recommended components for your audio application type
let mixerComponents = AudioUIQuickAccess.recommendedComponents(for: .mixer)
// Returns: ["VerticalInsetSlider", "InsetHorizontalFader", "InsetToggleButton"]

let synthComponents = AudioUIQuickAccess.recommendedComponents(for: .synthesizer)  
// Returns: ["InsetRotaryKnob", "KnobMinimal2", "InsetNeumorphicKnob"]

let drumMachineComponents = AudioUIQuickAccess.recommendedComponents(for: .drumMachine)
// Returns: ["DrumPadNeumorphic1", "DrumPadMinimal2", "DrumPadNeumorphic3"]
```

This helps you choose the right components for your specific audio application!

## Installation & Setup

### Swift Package Manager (Recommended)

Add AudioUI to your project using Xcode or by adding it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/YOUR_ORG/AudioUI", from: "2.0.0")
]
```

### Xcode Integration Steps

1. **Open your project** in Xcode
2. **File → Add Package Dependencies**
3. **Enter the AudioUI repository URL**
4. **Choose your version requirements** (recommend "Up to Next Major Version")
5. **Select the modules you need** (or just select "AudioUI" for everything)

### Understanding Import Options

AudioUI is modular - you can import everything or just what you need:

```swift
// Option 1: Import everything (recommended for learning)
import AudioUI

// Option 2: Import specific modules (for production optimization)
import AudioUICore        // Foundation primitives only
import AudioUITheme       // Theming system only  
import AudioUIComponents  // Enhanced components only
import AudioUIMetalFX     // Metal effects only
```

**Pro Tip**: Start with `import AudioUI` to get access to everything, then optimize later by importing only specific modules as needed.

## Framework Architecture - Understanding AudioUI's Design

AudioUI is thoughtfully organized into four specialized modules. Understanding this architecture will help you become a better audio UI developer:

### 🏗️ AudioUICore - Foundation Primitives

*Think of these as the "raw materials" for building audio interfaces*

AudioUICore contains the essential building blocks - the fundamental controls that every audio interface needs. These primitives focus on functionality over visual styling.

#### Why Primitives Matter

In audio software, you need controls that are:
- **Precise**: Audio parameters often require fine-grained control
- **Responsive**: Real-time audio can't wait for sluggish UI
- **Predictable**: Musicians need consistent, reliable interaction

#### Available Primitives

| Component | Purpose | When to Use |
|-----------|---------|-------------|
| `Knob` | Rotary control with precise gesture handling | Volume, frequency, gain controls |
| `Fader` | Linear slider with professional feel | Channel levels, send amounts |
| `XYPad` | Two-dimensional touch surface | Effect parameters, spatial audio |
| `PadButton` | Velocity-sensitive trigger | Drum machines, samplers |
| `ToggleButton` | State-based switch | Mute, solo, bypass switches |
| `LED` | Status indicator with theming | Signal presence, clipping warnings |
| `LevelMeter` | Real-time audio visualization | Input/output metering |
| `GyroscopePrimitive` | Motion-based control | Spatial effects, performance |

#### Example: Building with Primitives

```swift
import AudioUICore

struct BasicMixer: View {
    @State private var volume: Double = 0.5
    @State private var isMuted: Bool = false
    
    var body: some View {
        VStack {
            // Raw primitive - functional but unstyled
            Knob(value: $volume) { newValue in
                audioEngine.setVolume(newValue)
            }
            
            ToggleButton(isOn: $isMuted) { muted in
                audioEngine.setMuted(muted)
            }
        }
    }
}
```

### 🎨 AudioUITheme - The Styling Brain

*This is where the magic happens - turning functional controls into beautiful interfaces*

The theming system is AudioUI's secret weapon. It separates **how things look** (Looks) from **how they behave** (Feels), giving you incredible flexibility.

#### Understanding Looks vs Feels

**Looks** define visual appearance:
- Colors and gradients
- Shadows and lighting
- Typography and spacing
- Visual effects

**Feels** define interaction behavior:
- Animation timing and easing
- Touch responsiveness
- Haptic feedback patterns
- Gesture sensitivity

#### Built-in Themes & When to Use Them

| Theme | Visual Style | Best For | Learning Value |
|-------|-------------|----------|----------------|
| `audioUIMinimal` | Clean, geometric | Modern DAWs, professional tools | Learn restraint in design |
| `audioUINeumorphic` | Soft, tactile depth | Creative apps, instruments | Understand depth and realism |
| `darkPro` | Professional dark | Studio environments | Studio-standard color schemes |
| `sunset` | Warm gradients | Creative workflows | Color psychology in audio |
| `ocean` | Cool blue tones | Calm, focused work | Calming interface design |
| `ultraClean` | Ultra-minimal | Accessibility focus | Designing for clarity |

#### Theme Usage Examples

```swift
import AudioUITheme

struct ThemedInterface: View {
    var body: some View {
        VStack {
            // Your audio controls here
            InsetNeumorphicKnob(value: $volume)
            InsetToggleButton(label: "MUTE", isOn: $isMuted)
        }
        .theme(.darkPro)  // Apply professional dark theme
    }
}

// Creating a custom theme for learning
struct MyCustomInterface: View {
    var body: some View {
        VStack {
            KnobMinimal1(value: $frequency)
        }
        .theme(
            Theme(
                look: CustomLook(
                    primaryColor: .purple,
                    accentColor: .pink,
                    backgroundColor: .black
                ),
                feel: NeumorphicFeel() // Soft, tactile interactions
            )
        )
    }
}
```

### 🎛️ AudioUIComponents - Production-Ready Controls

*This is where primitives become beautiful, professional-grade components*

AudioUIComponents takes the raw functionality from AudioUICore and the styling power from AudioUITheme to create **50+ production-ready components** across 8 categories. These components embody two distinct design philosophies and are ready to use in real applications.

#### Understanding Design Philosophies

AudioUI components follow two distinct design philosophies - understanding these will make you a better interface designer:

##### 🔲 Minimal Design Philosophy
- **Visual Style**: Clean, geometric shapes with high contrast
- **When to Use**: Professional DAWs, broadcast tools, clinical applications
- **Learning Focus**: Restraint, clarity, function over form
- **Examples**: Logic Pro X, Pro Tools, professional audio analyzers

**Characteristics:**
- Subtle animations that don't distract
- High contrast for visibility in any lighting
- Accessibility-focused design
- Geometric precision

##### 🌊 Neumorphic Design Philosophy  
- **Visual Style**: Soft, tactile surfaces with realistic depth
- **When to Use**: Creative apps, virtual instruments, immersive experiences
- **Learning Focus**: Depth, realism, emotional connection
- **Examples**: Hardware synthesizers, boutique audio gear, creative software

**Characteristics:**
- Realistic shadows and depth
- Soft, touchable surfaces
- Premium visual feedback
- Hardware-inspired aesthetics

#### Complete Component Catalog

##### 🔘 Button Components (7 styles)

Buttons are fundamental to any interface - learn different approaches:

**Core Button Types:**
- **InsetCircularButton**: Circular neumorphic button with icon support
- **InsetMomentaryButton**: Momentary press button with tactile feedback  
- **InsetToggleButton**: Toggle state button with visual feedback

**Philosophy Variants:**
- **MinimalButton1**: Clean, minimal design focusing on clarity
- **NeumorphicButton1**: Distinct neumorphic aesthetic with depth
- **NeumorphicButton2**: Alternative neumorphic variant
- **EnhancedThemedButton**: Dynamically adapts to selected theme

```swift
// Example: Learning different button styles
VStack(spacing: 20) {
    // Minimal approach - focuses on function
    MinimalButton1(isActive: $isPlaying, label: "PLAY")
    
    // Neumorphic approach - focuses on tactile feel
    NeumorphicButton1(isActive: $isRecording, label: "REC")
    
    // Icon-based approach for common actions
    InsetCircularButton(icon: "stop.fill") {
        stopPlayback()
    }
}
```

##### 🥁 Drum Pad Components (9 styles)

Drum pads teach you about velocity-sensitive controls and rhythm interfaces:

**Minimal Style Drum Pads:**
- **DrumPadMinimal1**: Ultra-clean pad with tap animation
- **DrumPadMinimal2**: Dot matrix pad with expanding animation  
- **DrumPadMinimal3**: Geometric pad with ring animation

**Neumorphic Style Drum Pads:**
- **DrumPadNeumorphic1**: Rubber pad with realistic depth
- **DrumPadNeumorphic2**: Circular pad with color accents
- **DrumPadNeumorphic3**: Square pad with corner details

**Additional Variants:**
- **NeumorphicDrumPad1**: Enhanced neumorphic design
- **MinimalDrumPad1**: Clean minimal approach
- **MinimalDrumPad2**: Alternative minimal style

```swift
// Example: Building a drum machine interface
LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 15) {
    // Learn about velocity-sensitive triggers
    DrumPadNeumorphic1(label: "KICK") {
        drumMachine.trigger(.kick, velocity: 127)
    }
    
    DrumPadMinimal2() {
        drumMachine.trigger(.snare, velocity: 100) 
    }
    
    // Notice how different styles convey different "feels"
    DrumPadNeumorphic2(label: "HAT", color: .yellow) {
        drumMachine.trigger(.hihat, velocity: 80)
    }
}
```

##### 🎛️ Knob Components (11 styles)

Knobs are the heart of audio interfaces - master these and you'll understand precision control:

**Minimal Style Knobs:**
- **KnobMinimal1**: Vertical fill knob with clean design
- **KnobMinimal2**: Segmented knob with discrete steps
- **KnobMinimal3**: Dot pattern knob with concentric rings  
- **KnobMinimal4**: Orbital knob with smooth tracking
- **MinimalKnob1**: Core minimal design
- **MinimalKnob2**: Alternative minimal approach

**Neumorphic Style Knobs:**
- **InsetNeumorphicKnob**: Inset style with value indicators
- **InsetRotaryKnob**: Rotary style with grip ridges
- **UltraMinimalNeumorphicKnob**: Ultra-clean neumorphic design
- **NeumorphicKnob1**: Distinct neumorphic style
- **EnhancedThemedKnob**: Dynamically adapts to current theme

```swift
// Example: Learning knob precision and feedback
VStack(spacing: 30) {
    // Different knobs for different parameter types
    
    // Frequency control - needs precision
    InsetRotaryKnob(value: $cutoffFrequency)
        .onChange(of: cutoffFrequency) { newValue in
            let frequency = newValue * 20000 // 0-20kHz range
            filter.setCutoff(frequency)
        }
    
    // Volume control - familiar vertical fill
    KnobMinimal1(value: $volume)
    
    // Discrete parameter - stepped feedback  
    KnobMinimal2(value: $waveShape)
}
```

##### 🎚️ Slider/Fader Components (10 styles)

Faders teach you about linear control and mixing console paradigms:

**Minimal Style Sliders:**
- **SliderMinimal1**: Circular slider with clean design
- **SliderMinimal2**: Stepped blocks slider with discrete values
- **SliderMinimal3**: Vertical slider with notches
- **SliderMinimal4**: Dot matrix slider with density visualization
- **SliderMinimal5**: Floating handle slider with layers
- **MinimalFader1**: Clean fader design

**Neumorphic Style Sliders:**
- **InsetHorizontalFader**: Horizontal fader with inset design
- **SliderNeumorphic2**: Enhanced neumorphic slider with tooltip
- **VerticalInsetSlider**: Vertical slider with fill meter
- **VerticalNeumorphicFader**: Classic vertical fader design

```swift
// Example: Building a mixing console
HStack(spacing: 20) {
    ForEach(0..<8) { channel in
        VStack {
            Text("CH \(channel + 1)")
            
            // Learn about fader styles for different uses
            VerticalInsetSlider(value: $channelLevels[channel])
                .frame(height: 200)
                .onChange(of: channelLevels[channel]) { newLevel in
                    mixer.setChannelLevel(channel, level: newLevel)
                }
        }
    }
}
```

##### 🧭 Gyroscope Components (6 styles)

Motion controls teach you about spatial interfaces and device integration:

**Minimal Style Gyroscopes:**
- **GyroMinimal**: Clean motion display with orbit indicators
- **GyroMinimal1**: Crosshair style with simple visualization  
- **GyroMinimal2**: Ring-based orientation display
- **MinimalGyro1**: Core minimal gyroscope

**Advanced Gyroscopes:**
- **GyroNeumorphic4**: 3D sphere visualization with data cards
- **NeumorphicGyro1**: Neumorphic design approach

```swift
// Example: Motion-controlled effects
VStack(spacing: 30) {
    Text("Tilt your device to control spatial effects")
    
    // Learn about motion as an input method
    GyroNeumorphic4() // Auto-tracks device motion
        .onMotionChange { rotation in
            spatialProcessor.setPosition(
                x: rotation.pitch,
                y: rotation.roll, 
                z: rotation.yaw
            )
        }
}
```

##### 📐 XY Pad Components (4 styles)

XY Pads teach you about two-dimensional parameter control:

- **XYPadMinimal1**: Clean crosshair design with position indicator
- **XYPadMinimal3**: Enhanced minimal design  
- **NeumorphicXYPad**: Advanced pad with ripple effects
- **MinimalXYPad1**: Core minimal XY pad

```swift
// Example: Filter frequency and resonance control
@State private var filterParams = CGPoint(x: 0.5, y: 0.3)

NeumorphicXYPad(value: $filterParams)
    .frame(width: 200, height: 200)
    .onChange(of: filterParams) { newPosition in
        let frequency = newPosition.x * 20000 // 0-20kHz
        let resonance = newPosition.y * 10    // 0-10 Q
        filter.setParameters(frequency: frequency, resonance: resonance)
    }
```

##### 📊 Display Components (2 styles)

Learn about information display and visual feedback:

- **StatusBar**: Displaying status messages and system information
- **ThemedLevelMeter**: Audio level visualization that adapts to themes

##### 🎛️ Group Components (3 styles)

Understanding how to organize and group related controls:

- **ControlGroup**: Custom container for organizing related controls
- **FaderBank**: Managing multiple faders as a cohesive unit
- **KnobGroup**: Organizing knobs for EQ bands or parameter sets

### ⚡ AudioUIMetalFX - GPU-Accelerated Effects

*Learn about high-performance visual effects and audio visualization*

AudioUIMetalFX provides Metal-powered visual effects and real-time audio visualization components. This module teaches you about GPU acceleration in audio interfaces.

#### What You'll Learn
- GPU vs CPU rendering for audio interfaces
- Real-time audio visualization techniques  
- Performance optimization for complex UIs
- Metal shader integration in SwiftUI

#### Available Effects
- **Real-time Audio Visualizers**: Spectrum analyzers, waveform displays
- **GPU-Accelerated Animations**: Smooth 60fps interactions even with complex visuals
- **Advanced Visual Effects**: Glow effects, particle systems, distortion effects
- **Level Meters**: Professional-grade metering with sub-frame accuracy

## Component Statistics & What They Mean

Understanding these numbers helps you appreciate the scope and thoughtfulness of AudioUI:

- **Total Components**: 50+ (production-ready, not just demos)
- **Button Styles**: 7 (covering different interaction patterns)
- **Drum Pad Styles**: 9 (various approaches to rhythm interfaces)
- **Knob Styles**: 11 (the most variety - knobs are central to audio)
- **Slider Styles**: 10 (linear control in multiple forms)
- **Gyroscope Styles**: 6 (emerging spatial interface patterns)
- **XY Pad Styles**: 4 (two-dimensional parameter control)
- **Display Components**: 2 (information visualization)
- **Group Components**: 3 (component organization patterns)
- **Design Philosophies**: 2 (Minimal vs Neumorphic - fundamental approaches)
- **Platform Support**: 4 (iOS, macOS, watchOS, tvOS)

### Why These Numbers Matter

**Variety Within Categories**: Each component type has multiple styles because different audio applications need different approaches. A DJ app needs different faders than a recording studio.

**Design Philosophy Coverage**: Every major component type is available in both Minimal and Neumorphic styles, teaching you how the same functionality can have completely different visual approaches.

**Platform Optimization**: Components work across all Apple platforms but are optimized for each - teaching you about adaptive design.

## Learning-Focused Examples & Tutorials

### Tutorial 1: Your First Audio Interface

Let's build a simple synthesizer interface step by step:

```swift
import SwiftUI
import AudioUI

struct MySynthInterface: View {
    // Step 1: Define your audio parameters
    @State private var frequency: Double = 440.0    // A4 note
    @State private var amplitude: Double = 0.5      // 50% volume
    @State private var filterCutoff: Double = 0.7   // 70% cutoff
    @State private var isPlaying: Bool = false      // Playback state
    
    var body: some View {
        VStack(spacing: 40) {
            // Step 2: Add a title and learn about typography
            Text("My First Synthesizer")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Step 3: Frequency control - learn about knob precision
            VStack {
                Text("Frequency: \(Int(frequency))Hz")
                KnobMinimal1(value: Binding(
                    get: { frequency / 2000 }, // Normalize to 0-1
                    set: { frequency = $0 * 2000 } // Scale to 0-2000Hz
                ))
                .frame(width: 100, height: 100)
            }
            
            // Step 4: Amplitude control - learn about volume handling
            VStack {
                Text("Volume: \(Int(amplitude * 100))%")
                VerticalInsetSlider(value: $amplitude)
                    .frame(width: 60, height: 150)
            }
            
            // Step 5: Filter control - learn about XY parameter mapping
            VStack {
                Text("Filter")
                NeumorphicXYPad(value: Binding(
                    get: { CGPoint(x: filterCutoff, y: 0.5) },
                    set: { filterCutoff = $0.x }
                ))
                .frame(width: 150, height: 150)
            }
            
            // Step 6: Play/Stop control - learn about state management
            InsetToggleButton(label: isPlaying ? "STOP" : "PLAY", isOn: $isPlaying)
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
    
    // Step 7: Connect to actual audio (conceptual)
    func startSynthesis() {
        // This is where you'd connect to your audio engine
        print("Starting synthesis at \(frequency)Hz, volume \(amplitude)")
    }
    
    func stopSynthesis() {
        print("Stopping synthesis")
    }
}
```

### Tutorial 2: Understanding Theming

```swift
import SwiftUI
import AudioUI

struct ThemeComparisonView: View {
    @State private var useNeumorphic = false
    @State private var value: Double = 0.5
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Theme Comparison")
                .font(.title)
            
            // Theme selector
            Toggle("Use Neumorphic Theme", isOn: $useNeumorphic)
                .padding()
            
            // Same control, different themes
            if useNeumorphic {
                InsetNeumorphicKnob(value: $value)
                    .theme(.audioUINeumorphic) // Soft, tactile
            } else {
                KnobMinimal1(value: $value)
                    .theme(.audioUIMinimal) // Clean, geometric
            }
            
            Text("Notice how the same functionality feels completely different!")
                .font(.caption)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}
```

### Tutorial 3: Building a Drum Machine

```swift
struct DrumMachineInterface: View {
    @State private var isPlaying = false
    @State private var tempo: Double = 120.0
    @State private var volume: Double = 0.8
    
    // Drum pad states
    @State private var kickActive = false
    @State private var snareActive = false
    @State private var hihatActive = false
    
    var body: some View {
        VStack(spacing: 30) {
            // Transport controls
            HStack(spacing: 20) {
                InsetToggleButton(label: isPlaying ? "STOP" : "PLAY", isOn: $isPlaying)
                
                VStack {
                    Text("Tempo: \(Int(tempo)) BPM")
                    KnobMinimal2(value: Binding(
                        get: { (tempo - 60) / (200 - 60) }, // 60-200 BPM range
                        set: { tempo = 60 + $0 * (200 - 60) }
                    ))
                }
            }
            
            // Drum pads - learn about grid layouts
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                DrumPadNeumorphic1(label: "KICK") {
                    triggerDrum(.kick)
                }
                
                DrumPadNeumorphic2(label: "SNARE") {
                    triggerDrum(.snare)
                }
                
                DrumPadMinimal1() {
                    triggerDrum(.hihat)
                }
            }
            
            // Master volume
            VStack {
                Text("Master Volume")
                VerticalNeumorphicFader(value: $volume)
                    .frame(height: 120)
            }
        }
        .padding()
    }
    
    func triggerDrum(_ drum: DrumType) {
        // Connect to your drum sampler
        print("Triggering \(drum)")
    }
}

enum DrumType {
    case kick, snare, hihat
}
```

### Advanced Example: Complete Mixer Channel

Learn about professional mixing interfaces by building a full channel strip:

```swift
import SwiftUI
import AudioUI

struct MixerChannelStrip: View {
    @State private var gain: Double = 0.5
    @State private var high: Double = 0.5
    @State private var mid: Double = 0.5
    @State private var low: Double = 0.5
    @State private var level: Double = 0.8
    @State private var isMuted: Bool = false
    @State private var isSolo: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            // EQ Section - Learn about frequency control
            VStack(spacing: 15) {
                Text("3-Band EQ")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                // High frequencies (8kHz+)
                KnobMinimal2(value: $high)
                    .overlay(Text("HI").font(.caption2), alignment: .bottom)
                
                // Mid frequencies (200Hz-8kHz) 
                KnobMinimal2(value: $mid)
                    .overlay(Text("MID").font(.caption2), alignment: .bottom)
                
                // Low frequencies (20Hz-200Hz)
                KnobMinimal2(value: $low)
                    .overlay(Text("LO").font(.caption2), alignment: .bottom)
            }
            
            // Input gain - Learn about signal levels
            InsetRotaryKnob(value: $gain)
                .overlay(Text("GAIN").font(.caption2), alignment: .bottom)
            
            // Main fader - Learn about mixing levels
            VerticalInsetSlider(value: $level)
                .frame(height: 120)
            
            // Channel controls - Learn about signal routing
            HStack(spacing: 10) {
                InsetToggleButton(label: "MUTE", isOn: $isMuted)
                InsetToggleButton(label: "SOLO", isOn: $isSolo)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
        .onChange(of: [gain, high, mid, low, level]) { _ in
            updateAudioParameters()
        }
    }
    
    func updateAudioParameters() {
        // Connect to your audio engine here
        print("Updated: Gain=\(gain), EQ=[\(high),\(mid),\(low)], Level=\(level)")
    }
}
```

### Advanced Example: 8-Pad Drum Machine

Build a complete rhythm interface that teaches grid layouts and sound design:

```swift
struct DrumMachine: View {
    @State private var padVelocities: [Double] = Array(repeating: 0.0, count: 8)
    @State private var masterVolume: Double = 0.8
    @State private var isPlaying: Bool = false
    
    var body: some View {
        VStack(spacing: 30) {
            // Transport section
            HStack(spacing: 20) {
                InsetToggleButton(label: isPlaying ? "STOP" : "PLAY", isOn: $isPlaying)
                
                VStack {
                    Text("Master")
                    KnobMinimal1(value: $masterVolume)
                        .frame(width: 60, height: 60)
                }
            }
            
            // Learn about 2x4 grid layout for drums
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 20) {
                // Row 1: Main drums
                DrumPadNeumorphic1(label: "KICK") { 
                    triggerDrum(.kick, velocity: calculateVelocity(for: 0))
                }
                DrumPadNeumorphic1(label: "SNARE") { 
                    triggerDrum(.snare, velocity: calculateVelocity(for: 1))
                }
                DrumPadNeumorphic2(label: "HAT", color: .yellow) { 
                    triggerDrum(.hihat, velocity: calculateVelocity(for: 2))
                }
                DrumPadNeumorphic3(label: "CLAP") { 
                    triggerDrum(.clap, velocity: calculateVelocity(for: 3))
                }
                
                // Row 2: Percussion and effects
                DrumPadMinimal1() { 
                    triggerDrum(.openHat, velocity: calculateVelocity(for: 4))
                }
                DrumPadMinimal2() { 
                    triggerDrum(.crash, velocity: calculateVelocity(for: 5))
                }
                DrumPadMinimal3() { 
                    triggerDrum(.ride, velocity: calculateVelocity(for: 6))
                }
                DrumPadNeumorphic2(label: "PERC", color: .purple) { 
                    triggerDrum(.perc, velocity: calculateVelocity(for: 7))
                }
            }
        }
        .padding()
        .theme(.audioUINeumorphic) // Apply neumorphic theme for tactile feel
    }
    
    // Learn about velocity-sensitive triggering
    func calculateVelocity(for pad: Int) -> Double {
        return max(0.3, min(1.0, padVelocities[pad] + 0.7)) * masterVolume
    }
    
    func triggerDrum(_ type: DrumType, velocity: Double) {
        // Connect to your drum sampler here
        print("Triggering \(type) at velocity \(Int(velocity * 127))")
    }
}

enum DrumType {
    case kick, snare, hihat, clap, openHat, crash, ride, perc
}
```

### Advanced Example: Motion-Controlled Spatial Effects

Learn about device motion integration and spatial audio control:

```swift
struct MotionEffects: View {
    @State private var motionEnabled = false
    @State private var effectIntensity: Double = 0.5
    @State private var manualControl = CGPoint(x: 0.5, y: 0.5)
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Spatial Audio Control")
                .font(.title2)
                .fontWeight(.bold)
            
            // Motion toggle - Learn about enabling device sensors
            InsetToggleButton(label: "DEVICE MOTION", isOn: $motionEnabled)
            
            // Effect intensity - Learn about parameter scaling
            VStack {
                Text("Effect Intensity: \(Int(effectIntensity * 100))%")
                KnobMinimal1(value: $effectIntensity)
                    .frame(width: 80, height: 80)
            }
            
            // Advanced 3D visualization - Learn about spatial representation
            GyroNeumorphic4()
                .frame(width: 200, height: 200)
                .opacity(motionEnabled ? 1.0 : 0.3)
                .onMotionChange { rotation in
                    if motionEnabled {
                        updateSpatialEffect(
                            x: rotation.pitch,
                            y: rotation.roll,
                            z: rotation.yaw,
                            intensity: effectIntensity
                        )
                    }
                }
            
            // XY pad for manual control - Learn about hybrid interfaces
            VStack {
                Text("Manual Control \(motionEnabled ? "(Disabled - Using Motion)" : "")")
                    .font(.caption)
                NeumorphicXYPad(value: $manualControl)
                    .frame(width: 150, height: 150)
                    .disabled(motionEnabled)
                    .onChange(of: manualControl) { newPosition in
                        if !motionEnabled {
                            updateSpatialEffect(
                                x: newPosition.x - 0.5, // Center at 0
                                y: newPosition.y - 0.5, // Center at 0
                                z: 0.0,
                                intensity: effectIntensity
                            )
                        }
                    }
            }
            
            Text("Tilt your device or use the XY pad to control spatial effects")
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
        .padding()
        .theme(.darkPro) // Professional dark theme for studio use
    }
    
    func updateSpatialEffect(x: Double, y: Double, z: Double, intensity: Double) {
        // Apply motion/position data to spatial audio effects
        let scaledX = x * intensity
        let scaledY = y * intensity
        let scaledZ = z * intensity
        
        // Connect to your spatial audio processor
        print("Spatial effect: X=\(String(format: "%.2f", scaledX)), Y=\(String(format: "%.2f", scaledY)), Z=\(String(format: "%.2f", scaledZ))")
    }
}

// Mock type for demonstration - in real implementation this would come from CoreMotion
struct DeviceRotation {
    let pitch: Double  // Forward/backward tilt
    let roll: Double   // Left/right tilt  
    let yaw: Double    // Rotation around vertical axis
}
```

## Performance & Optimization

- **60fps interactions** on all supported devices
- **GPU-accelerated rendering** for complex visual effects  
- **Optimized gesture recognition** for precise audio control
- **Memory efficient** component architecture
- **Battery conscious** motion sensing

## Platform Support

| Platform | Version | Features |
|----------|---------|----------|
| iOS | 15.0+ | Full feature set including motion sensing |
| macOS | 12.0+ | All components with trackpad/mouse optimization |
| watchOS | 8.0+ | Essential components optimized for small screens |
| tvOS | 15.0+ | Remote-optimized interactions |

## Documentation & API Reference

### DocC Documentation
For comprehensive API documentation with interactive examples, build and browse the DocC documentation:

```bash
# Clone the repository
git clone [repository-url]
cd AudioUI

# Build DocC documentation
swift package generate-documentation --target AudioUI

# Browse documentation locally
swift package preview-documentation --target AudioUI
```

### Quick Reference Guides

- **[Getting Started Guide](Documentation/GettingStarted.md)** - Your first AudioUI app in 15 minutes
- **[Component Reference](Documentation/Components.md)** - Complete component catalog with examples
- **[Theming Guide](Documentation/Theming.md)** - Deep dive into the theming system
- **[Performance Guide](Documentation/Performance.md)** - Optimization techniques for audio UIs
- **[Migration Guide](MIGRATION.md)** - Upgrading from previous versions

### Learning Resources

- **[Audio UI Design Principles](Documentation/DesignPrinciples.md)** - Understanding audio interface design
- **[Tutorials](Documentation/Tutorials/)** - Step-by-step walkthroughs
- **[Sample Projects](Examples/)** - Complete example applications
- **[Best Practices](Documentation/BestPractices.md)** - Patterns and recommendations

## API Documentation Structure

AudioUI follows DocC documentation standards with:

- **Articles**: Conceptual guides and tutorials
- **Symbols**: Complete API reference with examples
- **Resources**: Sample code and assets
- **Links**: Cross-references between related APIs

### Key Documentation Features

- 📖 **Comprehensive Symbol Documentation**: Every public API is documented with purpose, parameters, and examples
- 🎯 **Interactive Examples**: Code samples you can copy and run immediately
- 🎨 **Visual Style Guides**: Screenshots and design explanations for each component
- 🔗 **Cross-Platform Notes**: Platform-specific behavior and optimizations clearly marked
- 🚀 **Performance Insights**: Memory usage, render performance, and optimization tips included
- 🎵 **Audio Context**: Real-world audio application examples for each component

## Migration Guide

See [MIGRATION.md](MIGRATION.md) for detailed upgrade instructions from earlier versions.

## Contributing

We welcome contributions! Please see our contributing guidelines for more information.

## License

AudioUI is available under the MIT license. See the LICENSE file for more info.

---

**AudioUI** - Building the future of audio interfaces, one component at a time. 🎵
