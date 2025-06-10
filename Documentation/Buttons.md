# Buttons

Tactile button components for audio interface controls with professional behavior and styling.

## Overview

AudioUI buttons provide the foundation for triggering actions, toggling states, and momentary controls in audio applications. Each button type offers authentic hardware-inspired behavior with proper tactile feedback, visual states, and accessibility support.

Available in both Minimal and Neumorphic design philosophies, buttons integrate seamlessly with the AudioUI theming system.

## Button Types

### CircularButton
Round buttons perfect for transport controls, bypass switches, and effect triggers.

```swift
import SwiftUI
import AudioUI

struct TransportControls: View {
    @State private var isPlaying = false
    @State private var isRecording = false
    
    var body: some View {
        HStack(spacing: 20) {
            CircularButton {
                // Play/Pause action
                isPlaying.toggle()
                audioEngine.togglePlayback()
            } label: {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            .theme(.audioUINeumorphic)
            
            CircularButton {
                // Record action
                isRecording.toggle()
                audioEngine.toggleRecording()
            } label: {
                Circle()
                    .fill(isRecording ? Color.red : Color.gray)
                    .frame(width: 20, height: 20)
            }
            .theme(.audioUINeumorphic)
        }
    }
}
```

### RectangularButton
Rectangular buttons ideal for labeled controls, channel strips, and function keys.

```swift
struct MixerChannelButtons: View {
    @State private var isMuted = false
    @State private var isSoloed = false
    @State private var isRecordEnabled = false
    
    var body: some View {
        VStack(spacing: 8) {
            RectangularButton {
                isMuted.toggle()
            } label: {
                Text("MUTE")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(isMuted ? .red : .primary)
            }
            .frame(width: 50, height: 25)
            
            RectangularButton {
                isSoloed.toggle()
            } label: {
                Text("SOLO")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(isSoloed ? .yellow : .primary)
            }
            .frame(width: 50, height: 25)
            
            RectangularButton {
                isRecordEnabled.toggle()
            } label: {
                Text("REC")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(isRecordEnabled ? .red : .primary)
            }
            .frame(width: 50, height: 25)
        }
        .theme(.audioUIMinimal)
    }
}
```

### ToggleButton
Specialized buttons for binary state controls with clear visual feedback.

```swift
struct EffectBypassControls: View {
    @State private var reverbEnabled = true
    @State private var delayEnabled = false
    @State private var compressorEnabled = true
    
    var body: some View {
        HStack(spacing: 15) {
            ToggleButton(isOn: $reverbEnabled) {
                VStack(spacing: 4) {
                    Image("reverb-icon")
                        .foregroundColor(reverbEnabled ? .blue : .gray)
                    Text("REVERB")
                        .font(.caption)
                        .foregroundColor(reverbEnabled ? .primary : .secondary)
                }
            }
            
            ToggleButton(isOn: $delayEnabled) {
                VStack(spacing: 4) {
                    Image("delay-icon")
                        .foregroundColor(delayEnabled ? .green : .gray)
                    Text("DELAY")
                        .font(.caption)
                        .foregroundColor(delayEnabled ? .primary : .secondary)
                }
            }
            
            ToggleButton(isOn: $compressorEnabled) {
                VStack(spacing: 4) {
                    Image("compressor-icon")
                        .foregroundColor(compressorEnabled ? .orange : .gray)
                    Text("COMP")
                        .font(.caption)
                        .foregroundColor(compressorEnabled ? .primary : .secondary)
                }
            }
        }
        .theme(.audioUINeumorphic)
    }
}
```

## Button Behavior

### Press States
All buttons provide visual feedback for different interaction states:

- **Default**: Normal resting state
- **Pressed**: Visual indication of active press
- **Disabled**: Clearly communicates unavailable state
- **Loading**: Shows processing or async operations

### Haptic Feedback
Buttons provide appropriate haptic feedback based on context:

```swift
CircularButton {
    // Action with haptic feedback
    HapticManager.shared.impact(.medium)
    performAction()
} label: {
    Text("TRIGGER")
}
.hapticFeedback(.impact(.medium))
```

### Accessibility
All buttons include comprehensive accessibility support:

```swift
RectangularButton {
    toggleMute()
} label: {
    Text("MUTE")
}
.accessibilityLabel("Mute channel")
.accessibilityHint("Double tap to mute or unmute this channel")
.accessibilityAddTraits(isMuted ? [.button, .selected] : [.button])
```

## Design Philosophy Integration

### Minimal Philosophy
Clean, geometric buttons with high contrast and precise visual hierarchy:

```swift
struct MinimalButtonExample: View {
    var body: some View {
        VStack(spacing: 16) {
            CircularButton {
                // Action
            } label: {
                Image(systemName: "play.fill")
                    .font(.title2)
            }
            .buttonStyle(.minimal)
            
            RectangularButton {
                // Action  
            } label: {
                Text("BYPASS")
                    .font(.caption)
                    .fontWeight(.medium)
            }
            .buttonStyle(.minimal)
        }
        .theme(.audioUIMinimal)
    }
}
```

### Neumorphic Philosophy
Soft, tactile buttons with realistic depth and shadow:

```swift
struct NeumorphicButtonExample: View {
    var body: some View {
        VStack(spacing: 16) {
            CircularButton {
                // Action
            } label: {
                Image(systemName: "power")
                    .font(.title2)
            }
            .buttonStyle(.neumorphic)
            
            RectangularButton {
                // Action
            } label: {
                Text("POWER")
                    .font(.caption)
                    .fontWeight(.medium)
            }
            .buttonStyle(.neumorphic)
        }
        .theme(.audioUINeumorphic)
    }
}
```

## Advanced Button Patterns

### Multi-State Buttons
Buttons that cycle through multiple states:

```swift
struct MultiStateButton: View {
    @State private var currentState: PlaybackState = .stopped
    
    enum PlaybackState: CaseIterable {
        case stopped, playing, paused
        
        var icon: String {
            switch self {
            case .stopped: return "stop.fill"
            case .playing: return "pause.fill"
            case .paused: return "play.fill"
            }
        }
        
        var color: Color {
            switch self {
            case .stopped: return .gray
            case .playing: return .green
            case .paused: return .yellow
            }
        }
    }
    
    var body: some View {
        CircularButton {
            currentState = PlaybackState.allCases[
                (PlaybackState.allCases.firstIndex(of: currentState)! + 1) % PlaybackState.allCases.count
            ]
        } label: {
            Image(systemName: currentState.icon)
                .font(.title2)
                .foregroundColor(currentState.color)
        }
        .frame(width: 60, height: 60)
    }
}
```

### Momentary vs Latching
Different button behaviors for different use cases:

```swift
struct ButtonBehaviorExample: View {
    @State private var isMomentaryPressed = false
    @State private var isLatched = false
    
    var body: some View {
        HStack(spacing: 20) {
            // Momentary button (active only while pressed)
            CircularButton {
                // No action - handled by press gestures
            } label: {
                Text("HOLD")
                    .font(.caption)
                    .foregroundColor(isMomentaryPressed ? .red : .primary)
            }
            .onPressGesture(
                onPress: { isMomentaryPressed = true },
                onRelease: { isMomentaryPressed = false }
            )
            
            // Latching button (toggles state)
            ToggleButton(isOn: $isLatched) {
                Text("LATCH")
                    .font(.caption)
                    .foregroundColor(isLatched ? .green : .primary)
            }
        }
    }
}
```

### Button Groups
Organized collections of related buttons:

```swift
struct TransportButtonGroup: View {
    @State private var currentTransportState: TransportState = .stopped
    
    var body: some View {
        HStack(spacing: 12) {
            Group {
                transportButton(.rewind, "backward.end.fill")
                transportButton(.play, "play.fill")
                transportButton(.stop, "stop.fill")
                transportButton(.record, "record.circle.fill")
                transportButton(.fastForward, "forward.end.fill")
            }
            .frame(width: 44, height: 44)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    private func transportButton(_ action: TransportAction, _ icon: String) -> some View {
        CircularButton {
            handleTransportAction(action)
        } label: {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(action == .record ? .red : .primary)
        }
    }
    
    private func handleTransportAction(_ action: TransportAction) {
        // Handle transport logic
    }
}
```

## Performance Considerations

### Efficient State Management
```swift
// ✅ Good: Use @State for local button state
@State private var isPressed = false

// ✅ Good: Use @Binding for external state
@Binding var isEnabled: Bool

// ❌ Avoid: Creating new objects in body
// Don't create Button() directly in body repeatedly
```

### Animation Performance
```swift
// ✅ Optimized button animations
CircularButton {
    action()
} label: {
    label
}
.scaleEffect(isPressed ? 0.95 : 1.0)
.animation(.easeInOut(duration: 0.1), value: isPressed)
```

## Integration Examples

### Professional DAW Transport
```swift
struct DAWTransport: View {
    @ObservedObject var transport: TransportController
    
    var body: some View {
        HStack(spacing: 8) {
            CircularButton {
                transport.rewind()
            } label: {
                Image(systemName: "backward.end.fill")
            }
            
            CircularButton {
                transport.togglePlayPause()
            } label: {
                Image(systemName: transport.isPlaying ? "pause.fill" : "play.fill")
                    .foregroundColor(transport.isPlaying ? .green : .primary)
            }
            
            CircularButton {
                transport.stop()
            } label: {
                Image(systemName: "stop.fill")
            }
            
            CircularButton {
                transport.toggleRecord()
            } label: {
                Image(systemName: "record.circle.fill")
                    .foregroundColor(transport.isRecording ? .red : .primary)
            }
            
            CircularButton {
                transport.fastForward()
            } label: {
                Image(systemName: "forward.end.fill")
            }
        }
        .theme(.audioUIMinimal)
    }
}
```

### Effect Pedal Interface
```swift
struct EffectPedalInterface: View {
    @State private var isEffectEnabled = false
    @State private var presetIndex = 0
    let presets = ["Clean", "Crunch", "Lead", "Vintage"]
    
    var body: some View {
        VStack(spacing: 20) {
            // Main bypass button
            CircularButton {
                isEffectEnabled.toggle()
                HapticManager.shared.impact(.heavy)
            } label: {
                Text("BYPASS")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(isEffectEnabled ? .green : .red)
            }
            .frame(width: 80, height: 80)
            
            // Preset selector
            HStack(spacing: 8) {
                ForEach(presets.indices, id: \.self) { index in
                    RectangularButton {
                        presetIndex = index
                        loadPreset(index)
                    } label: {
                        Text(presets[index])
                            .font(.caption2)
                            .foregroundColor(index == presetIndex ? .blue : .primary)
                    }
                    .frame(width: 45, height: 20)
                }
            }
        }
        .padding(20)
        .background(Color(.systemGray5))
        .cornerRadius(16)
        .theme(.audioUINeumorphic)
    }
    
    private func loadPreset(_ index: Int) {
        // Load preset logic
    }
}
```

## See Also

- <doc:AudioUIComponents> - Complete component overview
- <doc:ThemingGuide> - Applying themes to buttons
- <doc:DesignPhilosophies> - Understanding Minimal vs Neumorphic approaches
- <doc:Knobs> - Rotary controls for continuous values
