# Sliders

Linear control components for precise parameter adjustment with professional fader behavior.

## Overview

AudioUI sliders provide linear control over continuous parameters, perfect for volume faders, crossfaders, balance controls, and any parameter that benefits from linear visual representation. Each slider type offers authentic feel with proper curves, detents, and gesture recognition.

## Slider Types

### VerticalInsetSlider
Professional vertical fader perfect for mixing consoles and level controls:

```swift
import SwiftUI
import AudioUI

struct MixerChannelStrip: View {
    @State private var channelLevel: Double = 0.75
    @State private var auxSend1: Double = 0.0
    @State private var auxSend2: Double = 0.0
    @State private var panPosition: Double = 0.5
    
    var body: some View {
        VStack(spacing: 15) {
            // Aux sends
            HStack(spacing: 12) {
                VStack {
                    Text("AUX 1")
                        .font(.caption2)
                    VerticalInsetSlider(value: $auxSend1)
                        .frame(width: 20, height: 80)
                }
                
                VStack {
                    Text("AUX 2")
                        .font(.caption2)
                    VerticalInsetSlider(value: $auxSend2)
                        .frame(width: 20, height: 80)
                }
            }
            
            // Main fader
            VStack {
                Text("LEVEL")
                    .font(.caption)
                    .fontWeight(.medium)
                
                VerticalInsetSlider(value: $channelLevel)
                    .frame(width: 30, height: 200)
                
                Text("\(Int((channelLevel - 1.0) * 60)) dB")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            // Pan control
            VStack {
                Text("PAN")
                    .font(.caption2)
                HorizontalInsetSlider(value: $panPosition)
                    .frame(width: 60, height: 20)
                Text(panPosition < 0.4 ? "L" : panPosition > 0.6 ? "R" : "C")
                    .font(.caption2)
            }
        }
        .theme(.audioUIMinimal)
        .padding()
    }
}
```

### HorizontalFader
Horizontal sliders ideal for crossfaders, balance controls, and compact interfaces:

```swift
struct CrossfaderInterface: View {
    @State private var crossfaderPosition: Double = 0.5
    @State private var masterVolume: Double = 0.8
    @State private var cueLevel: Double = 0.6
    
    var body: some View {
        VStack(spacing: 25) {
            // Master controls
            HStack(spacing: 30) {
                VStack {
                    Text("MASTER")
                        .font(.caption)
                        .fontWeight(.bold)
                    
                    HorizontalFader(value: $masterVolume)
                        .frame(width: 150, height: 30)
                    
                    Text("\(Int(masterVolume * 100))%")
                        .font(.caption2)
                }
                
                VStack {
                    Text("CUE")
                        .font(.caption)
                        .fontWeight(.bold)
                    
                    HorizontalFader(value: $cueLevel)
                        .frame(width: 100, height: 25)
                    
                    Text("\(Int(cueLevel * 100))%")
                        .font(.caption2)
                }
            }
            
            // Crossfader
            VStack {
                Text("CROSSFADER")
                    .font(.caption)
                    .fontWeight(.bold)
                
                HorizontalFader(value: $crossfaderPosition)
                    .frame(width: 200, height: 40)
                    .snapToDetents([0.5]) // Center detent
                
                HStack {
                    Text("A")
                        .font(.caption)
                        .foregroundColor(crossfaderPosition < 0.3 ? .blue : .secondary)
                    
                    Spacer()
                    
                    Text("CENTER")
                        .font(.caption2)
                        .foregroundColor(abs(crossfaderPosition - 0.5) < 0.1 ? .green : .secondary)
                    
                    Spacer()
                    
                    Text("B")
                        .font(.caption)
                        .foregroundColor(crossfaderPosition > 0.7 ? .red : .secondary)
                }
                .frame(width: 200)
            }
        }
        .theme(.audioUINeumorphic)
    }
}
```

### CircularSlider
Circular sliders for compact parameter control:

```swift
struct CompactEffectControls: View {
    @State private var effectMix: Double = 0.5
    @State private var feedbackAmount: Double = 0.3
    @State private var modulationRate: Double = 0.7
    
    var body: some View {
        HStack(spacing: 25) {
            circularControl("MIX", value: $effectMix, color: .blue)
            circularControl("FEEDBACK", value: $feedbackAmount, color: .orange)
            circularControl("RATE", value: $modulationRate, color: .green)
        }
        .theme(.audioUINeumorphic)
    }
    
    private func circularControl(
        _ label: String,
        value: Binding<Double>,
        color: Color
    ) -> some View {
        VStack(spacing: 8) {
            Text(label)
                .font(.caption)
                .fontWeight(.medium)
            
            CircularSlider(value: value)
                .frame(width: 60, height: 60)
                .accentColor(color)
            
            Text("\(Int(value.wrappedValue * 100))%")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}
```

## Slider Behavior

### Fader Curves
Different parameter types require different response curves:

```swift
struct FaderCurveExample: View {
    @State private var linearValue: Double = 0.5
    @State private var audioValue: Double = 0.5
    @State private var exponentialValue: Double = 0.5
    
    var body: some View {
        HStack(spacing: 30) {
            // Linear response
            VStack {
                Text("LINEAR")
                VerticalInsetSlider(value: $linearValue)
                    .frame(width: 25, height: 150)
                Text("\(Int(linearValue * 100))%")
                    .font(.caption2)
            }
            
            // Audio taper (logarithmic)
            VStack {
                Text("AUDIO")
                VerticalInsetSlider(value: Binding(
                    get: { 
                        // Convert dB to slider position
                        let db = 20 * log10(max(audioValue, 0.001))
                        return (db + 60) / 60 // -60dB to 0dB range
                    },
                    set: { 
                        // Convert slider position to linear amplitude
                        let db = ($0 * 60) - 60
                        audioValue = pow(10, db / 20)
                    }
                ))
                .frame(width: 25, height: 150)
                Text("\(20 * log10(max(audioValue, 0.001)), specifier: "%.1f") dB")
                    .font(.caption2)
            }
            
            // Exponential response
            VStack {
                Text("EXP")
                VerticalInsetSlider(value: Binding(
                    get: { sqrt(exponentialValue) },
                    set: { exponentialValue = $0 * $0 }
                ))
                .frame(width: 25, height: 150)
                Text("\(Int(exponentialValue * 100))%")
                    .font(.caption2)
            }
        }
    }
}
```

### Detents and Snapping
Sliders can snap to important values:

```swift
struct DetentExample: View {
    @State private var gainValue: Double = 0.5 // Represents 0dB
    
    var body: some View {
        VStack {
            Text("GAIN CONTROL")
                .font(.caption)
                .fontWeight(.bold)
            
            VerticalInsetSlider(value: $gainValue)
                .frame(width: 30, height: 200)
                .snapToDetents([
                    0.0,   // -inf dB (mute)
                    0.1,   // -20 dB
                    0.25,  // -12 dB
                    0.375, // -6 dB
                    0.5,   // 0 dB (unity)
                    0.625, // +6 dB
                    0.75,  // +12 dB
                    1.0    // +20 dB
                ])
                .hapticFeedback(.light)
            
            let db = gainValue == 0 ? -Double.infinity : 20 * log10(gainValue * 2)
            Text(gainValue == 0 ? "MUTE" : "\(db, specifier: "%.1f") dB")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}
```

## Advanced Slider Features

### Range Sliders
Control minimum and maximum values simultaneously:

```swift
struct RangeSliderExample: View {
    @State private var frequencyRange: ClosedRange<Double> = 200...2000
    @State private var dynamicRange: ClosedRange<Double> = -40...0
    
    var body: some View {
        VStack(spacing: 25) {
            // Frequency range for bandpass filter
            VStack {
                Text("BANDPASS FILTER")
                    .font(.caption)
                    .fontWeight(.bold)
                
                HorizontalRangeSlider(
                    range: Binding(
                        get: { 
                            let min = log10(frequencyRange.lowerBound / 20) / log10(20000 / 20)
                            let max = log10(frequencyRange.upperBound / 20) / log10(20000 / 20)
                            return min...max
                        },
                        set: { 
                            let minFreq = 20 * pow(20000 / 20, $0.lowerBound)
                            let maxFreq = 20 * pow(20000 / 20, $0.upperBound)
                            frequencyRange = minFreq...maxFreq
                        }
                    )
                )
                .frame(width: 200, height: 30)
                
                Text("\(Int(frequencyRange.lowerBound)) - \(Int(frequencyRange.upperBound)) Hz")
                    .font(.caption2)
            }
            
            // Dynamic range for compressor
            VStack {
                Text("DYNAMIC RANGE")
                    .font(.caption)
                    .fontWeight(.bold)
                
                HorizontalRangeSlider(
                    range: Binding(
                        get: { 
                            ((dynamicRange.lowerBound + 60) / 60)...((dynamicRange.upperBound + 60) / 60)
                        },
                        set: { 
                            dynamicRange = (($0.lowerBound * 60) - 60)...(($0.upperBound * 60) - 60)
                        }
                    )
                )
                .frame(width: 200, height: 30)
                
                Text("\(dynamicRange.lowerBound, specifier: "%.0f") to \(dynamicRange.upperBound, specifier: "%.0f") dB")
                    .font(.caption2)
            }
        }
        .theme(.audioUIMinimal)
    }
}
```

### Motorized Faders
Faders that can be automated or reset programmatically:

```swift
struct MotorizedFaderExample: View {
    @State private var currentValue: Double = 0.5
    @State private var automationValue: Double = 0.5
    @State private var isAutomationActive = false
    
    var body: some View {
        VStack {
            Text("MOTORIZED FADER")
                .font(.caption)
                .fontWeight(.bold)
            
            VerticalInsetSlider(
                value: isAutomationActive ? $automationValue : $currentValue
            )
            .frame(width: 30, height: 200)
            .disabled(isAutomationActive)
            .opacity(isAutomationActive ? 0.7 : 1.0)
            
            HStack {
                Button("AUTOMATION") {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isAutomationActive.toggle()
                        if isAutomationActive {
                            automationValue = currentValue
                            startAutomation()
                        }
                    }
                }
                .foregroundColor(isAutomationActive ? .green : .primary)
                
                Button("RESET") {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        currentValue = 0.5
                        automationValue = 0.5
                    }
                }
            }
            .font(.caption)
        }
    }
    
    private func startAutomation() {
        // Simulate automation movement
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if !isAutomationActive {
                timer.invalidate()
                return
            }
            
            withAnimation(.linear(duration: 0.1)) {
                automationValue = 0.5 + 0.3 * sin(Date().timeIntervalSince1970 * 2)
            }
        }
    }
}
```

## Integration Examples

### Professional DAW Channel Strip
```swift
struct DAWChannelStrip: View {
    @ObservedObject var channel: DAWChannel
    
    var body: some View {
        VStack(spacing: 12) {
            // Channel identification
            Text("CH \(channel.number)")
                .font(.caption)
                .fontWeight(.bold)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color(.systemGray5))
                .cornerRadius(4)
            
            // Input gain
            VStack(spacing: 4) {
                Text("GAIN")
                    .font(.system(size: 8))
                VerticalInsetSlider(value: Binding(
                    get: { (channel.inputGain + 20) / 40 }, // -20 to +20 dB
                    set: { channel.inputGain = ($0 * 40) - 20 }
                ))
                .frame(width: 15, height: 60)
                Text("\(channel.inputGain, specifier: "%.0f")")
                    .font(.system(size: 8))
            }
            
            // Aux sends
            VStack(spacing: 8) {
                Text("AUX")
                    .font(.system(size: 8))
                
                ForEach(0..<4) { auxIndex in
                    VerticalInsetSlider(value: $channel.auxSends[auxIndex])
                        .frame(width: 12, height: 40)
                }
            }
            
            // Pan control
            VStack(spacing: 4) {
                Text("PAN")
                    .font(.system(size: 8))
                HorizontalInsetSlider(value: $channel.panPosition)
                    .frame(width: 40, height: 12)
                    .snapToDetents([0.5])
            }
            
            // Main fader
            VStack(spacing: 8) {
                Text("LEVEL")
                    .font(.system(size: 8))
                
                VerticalInsetSlider(value: Binding(
                    get: { channel.faderLevel },
                    set: { channel.faderLevel = $0 }
                ))
                .frame(width: 25, height: 150)
                .snapToDetents([0.0, 0.75]) // Unity gain detent
                
                Text("\(20 * log10(max(channel.faderLevel, 0.001)), specifier: "%.0f")")
                    .font(.system(size: 8))
            }
            
            // Mute and Solo buttons
            HStack(spacing: 4) {
                Button("M") {
                    channel.isMuted.toggle()
                }
                .frame(width: 20, height: 15)
                .font(.system(size: 8))
                .foregroundColor(channel.isMuted ? .white : .primary)
                .background(channel.isMuted ? .red : Color(.systemGray4))
                .cornerRadius(2)
                
                Button("S") {
                    channel.isSoloed.toggle()
                }
                .frame(width: 20, height: 15)
                .font(.system(size: 8))
                .foregroundColor(channel.isSoloed ? .black : .primary)
                .background(channel.isSoloed ? .yellow : Color(.systemGray4))
                .cornerRadius(2)
            }
        }
        .frame(width: 60)
        .theme(.audioUIMinimal)
    }
}
```

### DJ Mixer Interface
```swift
struct DJMixerInterface: View {
    @State private var channel1Level: Double = 0.8
    @State private var channel2Level: Double = 0.8
    @State private var crossfaderPosition: Double = 0.5
    @State private var masterLevel: Double = 0.9
    @State private var cueLevel: Double = 0.6
    
    var body: some View {
        HStack(spacing: 30) {
            // Channel 1
            djChannel(
                "CHANNEL 1",
                level: $channel1Level,
                color: .blue
            )
            
            // Crossfader section
            VStack(spacing: 20) {
                Text("CROSSFADER")
                    .font(.caption)
                    .fontWeight(.bold)
                
                HorizontalFader(value: $crossfaderPosition)
                    .frame(width: 200, height: 40)
                    .snapToDetents([0.5])
                
                HStack {
                    Text("A")
                        .foregroundColor(.blue)
                    Spacer()
                    Text("B")
                        .foregroundColor(.red)
                }
                .frame(width: 200)
                .font(.caption)
                
                // Master controls
                HStack(spacing: 25) {
                    VStack {
                        Text("MASTER")
                            .font(.caption)
                        VerticalInsetSlider(value: $masterLevel)
                            .frame(width: 30, height: 100)
                    }
                    
                    VStack {
                        Text("CUE")
                            .font(.caption)
                        VerticalInsetSlider(value: $cueLevel)
                            .frame(width: 25, height: 80)
                    }
                }
            }
            
            // Channel 2
            djChannel(
                "CHANNEL 2",
                level: $channel2Level,
                color: .red
            )
        }
        .theme(.audioUINeumorphic)
        .padding(30)
    }
    
    private func djChannel(
        _ title: String,
        level: Binding<Double>,
        color: Color
    ) -> some View {
        VStack(spacing: 15) {
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(color)
            
            // Channel fader
            VerticalInsetSlider(value: level)
                .frame(width: 30, height: 200)
                .accentColor(color)
            
            Text("\(Int(level.wrappedValue * 100))%")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}
```

## See Also

- <doc:Knobs> - Rotary controls for circular parameters
- <doc:XYPads> - Two-dimensional parameter control
- <doc:AudioUIComponents> - Complete component overview
- <doc:ThemingGuide> - Applying themes to sliders
