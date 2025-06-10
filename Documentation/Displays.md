# Display Components

Visual feedback components for displaying audio levels, status information, and real-time data in professional audio interfaces.

## Overview

AudioUI's display components provide essential visual feedback for audio applications. These components are designed to show real-time information clearly and efficiently, from simple LED indicators to complex multi-channel level meters.

## Visual Feedback Components

### Level Meters

Level meters are fundamental to any audio interface, providing instant visual feedback about signal levels.

```swift
import AudioUI

struct MixerChannelView: View {
    @State private var level: Double = 0.5
    @State private var peak: Double = 0.8
    
    var body: some View {
        VStack {
            // Themed level meter with peak hold
            ThemedLevelMeter(
                level: level,
                peak: peak,
                label: "CH 1"
            )
            .frame(width: 40, height: 200)
            
            // Basic level meter primitive
            LevelMeter(
                level: level,
                peak: peak,
                orientation: .vertical,
                size: CGSize(width: 30, height: 150)
            )
        }
    }
}
```

### LED Indicators

Simple but effective status indicators for various audio states.

```swift
struct TransportControls: View {
    @State private var isPlaying = false
    @State private var isRecording = false
    @State private var hasSignal = true
    
    var body: some View {
        HStack(spacing: 12) {
            // Play indicator
            LED(isOn: isPlaying, color: .green)
            
            // Record indicator
            LED(isOn: isRecording, color: .red, size: 16)
            
            // Signal presence indicator
            LED(isOn: hasSignal, color: .blue, size: 8)
        }
    }
}
```

### Status Displays

Complex status information organized in clear, readable formats.

```swift
struct AudioEngineStatus: View {
    var body: some View {
        StatusBar(items: [
            StatusBar.StatusItem(
                icon: "waveform",
                text: "44.1kHz",
                status: .normal
            ),
            StatusBar.StatusItem(
                icon: "timer",
                text: "256 samples",
                status: .normal
            ),
            StatusBar.StatusItem(
                icon: "cpu",
                text: "23%",
                status: level < 0.8 ? .normal : .warning
            )
        ])
    }
}
```

## Component Catalog

### ThemedLevelMeter

A professional-grade level meter with peak hold, scale markings, and theme integration.

**Features:**
- Peak hold with customizable decay
- dB scale markings
- Clipping indicators
- Horizontal and vertical orientations
- Theme-aware styling

**Use Cases:**
- Channel strips in mixing consoles
- Master output monitoring
- Input gain staging
- Multitrack recording interfaces

### LevelMeter (Primitive)

The core level meter component providing essential functionality without theming.

**Features:**
- Real-time level display
- Optional peak indicators
- Customizable colors and sizing
- Efficient rendering for multiple instances

### LED

Simple LED indicator component for binary status display.

**Features:**
- On/off states with smooth transitions
- Customizable colors and sizes
- Optimized for arrays of indicators
- Accessibility support

### StatusBar

Organized display of multiple status items with consistent formatting.

**Features:**
- Multiple status types (normal, warning, error)
- Icon and text combination
- Automatic spacing and alignment
- Responsive layout

## Advanced Displays

### Multi-Channel Meters

For complex audio routing scenarios:

```swift
struct MultichannelMeter: View {
    let channels: [AudioChannel]
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(channels.indices, id: \.self) { index in
                ThemedLevelMeter(
                    level: channels[index].level,
                    peak: channels[index].peak,
                    label: "CH \(index + 1)"
                )
                .frame(width: 25, height: 200)
            }
        }
    }
}
```

### Spectrum Display Integration

Combining displays with MetalFX visualizers:

```swift
struct SpectrumMeterCombo: View {
    var body: some View {
        VStack {
            // Real-time spectrum analysis
            SpectrumVisualizer(
                intensity: audioEngine.spectrumIntensity,
                barCount: 32
            )
            .frame(height: 100)
            
            // Traditional level meter
            ThemedLevelMeter(
                level: audioEngine.masterLevel,
                peak: audioEngine.masterPeak,
                label: "MASTER"
            )
            .frame(width: 60, height: 150)
        }
    }
}
```

## Performance Considerations

### Efficient Updates

Display components are optimized for real-time updates:

- Level meters use efficient drawing algorithms
- LED components batch updates for arrays
- Status displays only redraw when values change

### Memory Usage

- Primitive components have minimal memory footprint
- Themed components cache rendering resources
- Large meter arrays use view recycling

## Design Guidelines

### Visual Hierarchy

- Use size and color to indicate importance
- Group related status indicators
- Maintain consistent spacing and alignment

### Color Coding

- Green: Normal operation, good signal levels
- Yellow/Orange: Caution, approaching limits
- Red: Warning, clipping, or error states
- Blue: Information, special states

### Accessibility

- All displays support high contrast modes
- LED indicators include text alternatives
- Status information is available to screen readers

## Integration Examples

### Professional Mixing Console

```swift
struct MixingConsole: View {
    @StateObject private var mixer = AudioMixer()
    
    var body: some View {
        HStack {
            ForEach(mixer.channels) { channel in
                VStack {
                    // Channel controls
                    ChannelStrip(channel: channel)
                    
                    // Level display
                    ThemedLevelMeter(
                        level: channel.level,
                        peak: channel.peak,
                        label: channel.name
                    )
                    .frame(width: 40, height: 300)
                }
            }
            
            // Master section
            VStack {
                StatusBar(items: mixer.systemStatus)
                
                ThemedLevelMeter(
                    level: mixer.masterLevel,
                    peak: mixer.masterPeak,
                    label: "MASTER"
                )
                .frame(width: 60, height: 300)
            }
        }
    }
}
```

Display components form the visual feedback backbone of professional audio interfaces, providing users with immediate, clear information about their audio systems' state and performance.

## Topics

### Level Meters
- ``ThemedLevelMeter``
- ``LevelMeter``

### Status Indicators  
- ``LED``
- ``StatusBar``

### Integration Patterns
- Multi-channel displays
- Real-time updates
- Performance optimization
