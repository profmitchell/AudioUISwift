# Group Components

Container and layout components for organizing audio interface elements into logical groups and hierarchical structures.

## Overview

AudioUI's group components provide the structural foundation for complex audio interfaces. They organize individual controls and displays into meaningful clusters, creating intuitive layouts that mirror real-world hardware and professional software workflows.

## Layout Containers

### Channel Strips

The fundamental building block of mixing interfaces, combining multiple controls into a vertical layout representing a single audio channel.

```swift
import AudioUI

struct ChannelStrip: View {
    @StateObject private var channel = AudioChannel()
    
    var body: some View {
        VStack(spacing: 8) {
            // Input section
            AudioUIGroup("INPUT") {
                InsetNeumorphicKnob(
                    value: $channel.gain,
                    label: "GAIN"
                )
                
                ToggleButton(
                    isOn: $channel.phantomPower,
                    label: "48V"
                )
            }
            
            // EQ section
            AudioUIGroup("EQ") {
                HStack {
                    InsetNeumorphicKnob(
                        value: $channel.highFreq,
                        label: "HIGH"
                    )
                    InsetNeumorphicKnob(
                        value: $channel.midFreq,
                        label: "MID"
                    )
                    InsetNeumorphicKnob(
                        value: $channel.lowFreq,
                        label: "LOW"
                    )
                }
            }
            
            // Output section
            AudioUIGroup("OUTPUT") {
                VerticalInsetSlider(
                    value: $channel.faderLevel,
                    label: "LEVEL"
                )
                .frame(height: 200)
                
                ThemedLevelMeter(
                    level: channel.level,
                    peak: channel.peak,
                    label: "METER"
                )
                .frame(width: 30, height: 200)
            }
        }
        .frame(width: 120)
    }
}
```

### Effect Racks

Modular containers for organizing audio processing effects with consistent spacing and visual grouping.

```swift
struct EffectRack: View {
    @StateObject private var effectChain = AudioEffectChain()
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(effectChain.effects) { effect in
                EffectModule(effect: effect)
                    .audioUIGrouped("FX \(effect.id)")
            }
            
            // Add effect button
            CircularButton(
                action: effectChain.addEffect,
                icon: "plus"
            )
        }
        .audioUIGrouped("EFFECT RACK")
    }
}

struct EffectModule: View {
    let effect: AudioEffect
    
    var body: some View {
        HStack {
            // Effect controls based on type
            switch effect.type {
            case .reverb:
                ReverbControls(effect: effect)
            case .delay:
                DelayControls(effect: effect)
            case .chorus:
                ChorusControls(effect: effect)
            }
            
            // Bypass button
            ToggleButton(
                isOn: Binding(
                    get: { !effect.isBypassed },
                    set: { effect.isBypassed = !$0 }
                ),
                label: "ON"
            )
        }
    }
}
```

### Transport Controls

Grouped playback and recording controls that function as a cohesive unit.

```swift
struct TransportSection: View {
    @StateObject private var transport = AudioTransport()
    
    var body: some View {
        AudioUIGroup("TRANSPORT") {
            HStack(spacing: 12) {
                // Main transport buttons
                CircularButton(
                    action: transport.rewind,
                    icon: "backward.end"
                )
                
                CircularButton(
                    action: transport.play,
                    icon: transport.isPlaying ? "pause" : "play"
                )
                .highlighted(transport.isPlaying)
                
                CircularButton(
                    action: transport.record,
                    icon: "record.circle"
                )
                .highlighted(transport.isRecording)
                
                CircularButton(
                    action: transport.stop,
                    icon: "stop"
                )
                
                CircularButton(
                    action: transport.fastForward,
                    icon: "forward.end"
                )
            }
            
            // Transport status
            HStack {
                LED(isOn: transport.isPlaying, color: .green)
                Text("PLAY")
                
                Spacer()
                
                LED(isOn: transport.isRecording, color: .red)
                Text("REC")
            }
        }
    }
}
```

## Component Catalog

### AudioUIGroup

The primary grouping container that provides visual organization and consistent spacing.

**Features:**
- Titled sections with clear visual separation
- Automatic spacing and padding
- Theme-aware styling
- Collapsible sections (optional)

**Use Cases:**
- Channel strip sections (EQ, Dynamics, etc.)
- Effect parameter groupings
- Control panel organization

### ChannelStrip

A specialized vertical container optimized for audio channel layouts.

**Features:**
- Predefined sections for common channel elements
- Automatic spacing for faders and meters
- Responsive width handling
- Label positioning optimization

**Use Cases:**
- Mixing console channels
- Multi-track recorder interfaces
- Live sound control surfaces

### EffectRack

A dynamic container for chaining audio processing modules.

**Features:**
- Drag-and-drop reordering
- Add/remove effect slots
- Bypass state visualization
- Signal flow indicators

**Use Cases:**
- Plugin hosts
- Guitar amp simulators
- Mastering suites

### ControlPanel

A flexible grid-based container for organizing related controls.

**Features:**
- Automatic grid layout
- Responsive column counts
- Group labeling
- Consistent control spacing

## Advanced Grouping Patterns

### Tabbed Interfaces

For complex interfaces with multiple functional areas:

```swift
struct SynthesizerInterface: View {
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            // Tab selector
            HStack {
                ForEach(0..<3) { index in
                    TabButton(
                        isSelected: selectedTab == index,
                        title: ["OSC", "FILTER", "AMP"][index]
                    ) {
                        selectedTab = index
                    }
                }
            }
            
            // Tab content
            Group {
                switch selectedTab {
                case 0:
                    OscillatorControls()
                case 1:
                    FilterControls()
                case 2:
                    AmplifierControls()
                default:
                    EmptyView()
                }
            }
            .audioUIGrouped()
        }
    }
}
```

### Hierarchical Organization

For deeply nested control structures:

```swift
struct MasterSection: View {
    var body: some View {
        AudioUIGroup("MASTER") {
            // Primary controls
            HStack {
                InsetNeumorphicKnob(
                    value: $masterGain,
                    label: "GAIN"
                )
                
                // Sub-group for monitoring
                AudioUIGroup("MONITOR") {
                    VStack {
                        ToggleButton(
                            isOn: $monitorEnabled,
                            label: "ON"
                        )
                        
                        InsetNeumorphicKnob(
                            value: $monitorLevel,
                            label: "LEVEL"
                        )
                    }
                }
            }
            
            // Output meters
            HStack {
                ThemedLevelMeter(
                    level: leftLevel,
                    peak: leftPeak,
                    label: "L"
                )
                
                ThemedLevelMeter(
                    level: rightLevel,
                    peak: rightPeak,
                    label: "R"
                )
            }
        }
    }
}
```

## Performance Considerations

### View Hierarchy Optimization

Group components are designed to minimize view hierarchy depth while maintaining clear organization:

- Efficient container views that don't add unnecessary layers
- Lazy loading for large collections of grouped elements
- View recycling for dynamic content

### Update Efficiency

- Group containers batch updates to child components
- Selective redrawing based on changed content
- Optimized layout calculations

## Design Guidelines

### Visual Hierarchy

- Use consistent grouping patterns throughout the interface
- Vary group sizes to indicate relative importance
- Maintain clear visual separation between groups

### Spacing and Alignment

- Follow consistent spacing rules within and between groups
- Align related elements across different groups
- Use white space effectively to prevent cramped layouts

### Labeling

- Provide clear, concise group labels
- Use consistent label positioning
- Consider internationalization for label text

## Integration Examples

### Professional Mixing Console

```swift
struct MixingConsoleView: View {
    @StateObject private var console = MixingConsole()
    
    var body: some View {
        HStack {
            // Input channels
            ScrollView(.horizontal) {
                HStack {
                    ForEach(console.inputChannels) { channel in
                        ChannelStrip(channel: channel)
                    }
                }
            }
            
            // Master section
            VStack {
                EffectRack(effects: console.masterEffects)
                
                AudioUIGroup("MASTER OUTPUT") {
                    StereoLevelMeter(
                        leftLevel: console.masterLeft,
                        rightLevel: console.masterRight
                    )
                    
                    InsetNeumorphicKnob(
                        value: $console.masterGain,
                        label: "MASTER"
                    )
                }
            }
        }
    }
}
```

### Synthesizer Workstation

```swift
struct SynthWorkstation: View {
    var body: some View {
        VStack {
            // Performance controls
            AudioUIGroup("PERFORMANCE") {
                HStack {
                    MotionXYPad(
                        x: $performanceX,
                        y: $performanceY,
                        label: "EXPRESSION"
                    )
                    
                    VStack {
                        CircularSlider(
                            value: $modWheel,
                            label: "MOD"
                        )
                        
                        CircularSlider(
                            value: $pitchBend,
                            label: "PITCH"
                        )
                    }
                }
            }
            
            // Sound generation
            HStack {
                OscillatorSection()
                FilterSection()
                AmplifierSection()
            }
            
            // Effects and output
            HStack {
                EffectRack(effects: synthEffects)
                OutputSection()
            }
        }
    }
}
```

Group components create the organizational backbone of professional audio interfaces, enabling complex functionality while maintaining intuitive, logical layouts that users can navigate efficiently.

## Topics

### Container Components
- ``AudioUIGroup``
- ``ChannelStrip``
- ``EffectRack``
- ``ControlPanel``

### Layout Patterns
- Hierarchical organization
- Tabbed interfaces
- Responsive grouping

### Design Guidelines
- Visual hierarchy
- Spacing and alignment
- Performance optimization
