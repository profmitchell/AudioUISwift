# Knobs

Professional rotary controls with authentic hardware behavior and stunning visual design.

## Overview

AudioUI knobs deliver the most precise and tactile way to control continuous audio parameters. Each knob is meticulously crafted to match the feel and behavior of professional hardware, featuring proper rotation curves, visual feedback, gesture recognition, and velocity sensitivity.

These components are perfect for synthesizer parameters, effect controls, mixer settings, and any scenario requiring precise continuous input with professional aesthetics.

## Available Knob Types

AudioUI provides multiple knob styles to match your design philosophy and functional requirements:

### InsetNeumorphicKnob
The flagship component featuring realistic inset design with depth, shadows, and smooth rotation:

```swift
import SwiftUI
import AudioUI
import AudioUITheme

struct ProfessionalSynthInterface: View {
    @State private var oscillatorFreq: Double = 0.5    // Normalized 0-1
    @State private var filterCutoff: Double = 0.7      // Normalized 0-1  
    @State private var resonance: Double = 0.3         // Normalized 0-1
    @State private var amplitude: Double = 0.8         // Normalized 0-1
    
    var body: some View {
        VStack(spacing: 40) {
            Text("OSCILLATOR SECTION")
                .audioUILabel(.section)
            
            HStack(spacing: 50) {
                // Frequency control with real-time display
                VStack(spacing: 12) {
                    Text("FREQUENCY")
                        .audioUILabel(.parameter)
                    
                    InsetNeumorphicKnob(
                        value: $oscillatorFreq,
                        onValueChange: { newValue in
                            // Real-time parameter updates
                            let hz = 20 + (newValue * 4980) // 20Hz to 5000Hz
                            print("Frequency: \(Int(hz))Hz")
                        }
                    )
                    .frame(width: 100, height: 100)
                    
                    Text("\(Int(20 + oscillatorFreq * 4980))Hz")
                        .audioUILabel(.value)
                        .fontDesign(.monospaced)
                }
                
                // Filter cutoff with logarithmic scaling
                VStack(spacing: 12) {
                    Text("CUTOFF")
                        .audioUILabel(.parameter)
                    
                    InsetNeumorphicKnob(
                        value: $filterCutoff,
                        curve: .logarithmic, // Better for frequency parameters
                        onValueChange: { newValue in
                            let hz = 20 * pow(1000, newValue) // 20Hz to 20kHz log scale
                            print("Cutoff: \(Int(hz))Hz")
                        }
                    )
                    .frame(width: 100, height: 100)
                    
                    Text("\(formatFrequency(20 * pow(1000, filterCutoff)))")
                        .audioUILabel(.value)
                        .fontDesign(.monospaced)
                }
            }
        }
        .theme(.audioUINeumorphic)
        .padding(40)
    }
    
    private func formatFrequency(_ hz: Double) -> String {
        if hz >= 1000 {
            return String(format: "%.1fkHz", hz / 1000)
        } else {
            return String(format: "%.0fHz", hz)
        }
    }
}
```

### KnobMinimal1
Clean, geometric knob perfect for professional and clinical applications:

```swift
struct ProfessionalEQ: View {
    @State private var lowGain: Double = 0.0
    @State private var midGain: Double = 0.0
    @State private var highGain: Double = 0.0
    @State private var lowFreq: Double = 80.0
    @State private var midFreq: Double = 1000.0
    @State private var highFreq: Double = 8000.0
    
    var body: some View {
        HStack(spacing: 25) {
            // Low frequency band
            VStack(spacing: 12) {
                Text("LOW")
                    .audioUILabel(.parameter)
                
                KnobMinimal1(value: Binding(
                    get: { (lowGain + 12) / 24 }, // -12dB to +12dB
                    set: { lowGain = ($0 * 24) - 12 }
                ))
                .frame(width: 50, height: 50)
                
                Text("\(lowGain, specifier: "%.1f") dB")
                    .audioUILabel(.value)
                
                KnobMinimal1(value: Binding(
                    get: { log10(lowFreq / 20) / log10(500) },
                    set: { lowFreq = 20 * pow(500/20, $0) }
                ))
                .frame(width: 35, height: 35)
                
                Text("\(Int(lowFreq)) Hz")
                    .audioUILabel(.value)
            }
            
            // Mid frequency band
            VStack(spacing: 12) {
                Text("MID")
                    .audioUILabel(.parameter)
                
                KnobMinimal1(value: Binding(
                    get: { (midGain + 12) / 24 },
                    set: { midGain = ($0 * 24) - 12 }
                ))
                .frame(width: 50, height: 50)
                
                Text("\(midGain, specifier: "%.1f") dB")
                    .audioUILabel(.value)
                
                KnobMinimal1(value: Binding(
                    get: { log10(midFreq / 200) / log10(5000/200) },
                    set: { midFreq = 200 * pow(5000/200, $0) }
                ))
                .frame(width: 35, height: 35)
                
                Text("\(Int(midFreq)) Hz")
                    .audioUILabel(.value)
            }
            
            // High frequency band
            VStack(spacing: 12) {
                Text("HIGH")
                    .audioUILabel(.parameter)
                
                KnobMinimal1(value: Binding(
                    get: { (highGain + 12) / 24 },
                    set: { highGain = ($0 * 24) - 12 }
                ))
                .frame(width: 50, height: 50)
                
                Text("\(highGain, specifier: "%.1f") dB")
                    .audioUILabel(.value)
                
                KnobMinimal1(value: Binding(
                    get: { log10(highFreq / 2000) / log10(20000/2000) },
                    set: { highFreq = 2000 * pow(20000/2000, $0) }
                ))
                .frame(width: 35, height: 35)
                
                Text("\(Int(highFreq)) Hz")
                    .audioUILabel(.value)
            }
        }
        .theme(.audioUIMinimal)
        .padding(20)
        .audioUIGroupBox()
    }
}
```

### VintageKnob
Retro-styled knob with classic hardware aesthetics:

```swift
struct VintageAmplifierInterface: View {
    @State private var volume: Double = 0.5
    @State private var bass: Double = 0.5
    @State private var treble: Double = 0.5
    @State private var gain: Double = 0.3
    @State private var reverb: Double = 0.2
    
    var body: some View {
        VStack(spacing: 25) {
            // Main controls row
            HStack(spacing: 35) {
                knobWithLabel("VOLUME", value: $volume, color: .orange)
                knobWithLabel("GAIN", value: $gain, color: .red)
                knobWithLabel("REVERB", value: $reverb, color: .blue)
            }
            
            // Tone controls row
            HStack(spacing: 35) {
                knobWithLabel("BASS", value: $bass, color: .green)
                knobWithLabel("TREBLE", value: $treble, color: .purple)
            }
        }
        .padding(30)
        .background(
            LinearGradient(
                colors: [Color(.systemGray5), Color(.systemGray4)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(20)
        .theme(.audioUIVintage)
    }
    
    private func knobWithLabel(
        _ label: String,
        value: Binding<Double>,
        color: Color
    ) -> some View {
        VStack(spacing: 8) {
            VintageKnob(value: value)
                .frame(width: 70, height: 70)
                .accentColor(color)
            
            Text(label)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.primary)
        }
    }
}
```

## Knob Behavior

### Rotation Mechanics
AudioUI knobs use authentic rotation behavior that matches real hardware:

```swift
struct KnobBehaviorExample: View {
    @State private var value: Double = 0.5
    
    var body: some View {
        VStack {
            InsetNeumorphicKnob(value: $value)
                .frame(width: 100, height: 100)
                .rotationRange(270) // 270-degree rotation
                .sensitivity(1.0) // Normal sensitivity
                .snapToDetents([0.0, 0.25, 0.5, 0.75, 1.0]) // Optional detents
                .hapticFeedback(.light) // Haptic feedback on detents
            
            Text("Value: \(value, specifier: "%.3f")")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
```

### Value Mapping
Different parameter types require different value mapping strategies:

```swift
struct ParameterMappingExamples: View {
    @State private var frequency: Double = 1000.0 // Linear Hz value
    @State private var gain: Double = 0.0 // dB value
    @State private var ratio: Double = 0.5 // 0-1 normalized
    
    var body: some View {
        HStack(spacing: 30) {
            // Logarithmic frequency mapping
            VStack {
                Text("FREQUENCY")
                InsetNeumorphicKnob(value: Binding(
                    get: { 
                        // Map 20Hz-20kHz to 0-1 logarithmically
                        log10(frequency / 20) / log10(20000 / 20)
                    },
                    set: { 
                        // Map 0-1 back to 20Hz-20kHz
                        frequency = 20 * pow(20000 / 20, $0)
                    }
                ))
                Text("\(Int(frequency)) Hz")
                    .font(.caption2)
            }
            
            // dB gain mapping with center detent
            VStack {
                Text("GAIN")
                InsetNeumorphicKnob(value: Binding(
                    get: { (gain + 24) / 48 }, // -24dB to +24dB
                    set: { gain = ($0 * 48) - 24 }
                ))
                .snapToDetents([0.5]) // Center at 0dB
                Text("\(gain, specifier: "%.1f") dB")
                    .font(.caption2)
            }
            
            // Linear ratio (0-1)
            VStack {
                Text("MIX")
                InsetNeumorphicKnob(value: $ratio)
                Text("\(Int(ratio * 100))%")
                    .font(.caption2)
            }
        }
    }
}
```

### Gesture Recognition
Knobs support multiple interaction methods:

```swift
struct GestureExample: View {
    @State private var value: Double = 0.5
    
    var body: some View {
        InsetNeumorphicKnob(value: $value)
            .frame(width: 80, height: 80)
            .onRotationGesture { delta in
                // Custom rotation handling
                value = max(0, min(1, value + delta * 0.01))
            }
            .onDoubleTap {
                // Reset to default value
                withAnimation(.easeInOut(duration: 0.3)) {
                    value = 0.5
                }
            }
            .onLongPressGesture {
                // Enter fine adjustment mode
                enterFineAdjustmentMode()
            }
    }
    
    private func enterFineAdjustmentMode() {
        // Implementation for fine adjustment
    }
}
```

## Advanced Knob Features

### Multi-Turn Knobs
For parameters requiring more precision:

```swift
struct MultiTurnKnob: View {
    @State private var turns: Int = 0
    @State private var position: Double = 0.5
    
    private var totalValue: Double {
        Double(turns) + position
    }
    
    var body: some View {
        VStack {
            InsetNeumorphicKnob(value: $position)
                .frame(width: 80, height: 80)
                .onChange(of: position) { newValue in
                    // Handle turn counting
                    if newValue < 0.1 && position > 0.9 {
                        turns += 1
                    } else if newValue > 0.9 && position < 0.1 {
                        turns -= 1
                    }
                }
            
            Text("Turns: \(turns)")
                .font(.caption2)
            
            Text("Total: \(totalValue, specifier: "%.2f")")
                .font(.caption2)
        }
    }
}
```

### Stepped Parameter Knobs
For discrete parameter values:

```swift
struct SteppedParameterKnob: View {
    @State private var selectedStep: Int = 4
    let steps = ["1/16", "1/8", "1/4", "1/2", "1/1", "2/1", "4/1"]
    
    var body: some View {
        VStack {
            InsetNeumorphicKnob(value: Binding(
                get: { Double(selectedStep) / Double(steps.count - 1) },
                set: { 
                    selectedStep = Int(round($0 * Double(steps.count - 1)))
                }
            ))
            .frame(width: 70, height: 70)
            .hapticFeedback(.light)
            
            Text(steps[selectedStep])
                .font(.caption)
                .fontWeight(.medium)
        }
    }
}
```

### Knob Arrays
Multiple related parameters:

```swift
struct KnobArrayExample: View {
    @State private var bandGains: [Double] = Array(repeating: 0.0, count: 8)
    let frequencies = [63, 125, 250, 500, 1000, 2000, 4000, 8000]
    
    var body: some View {
        VStack {
            Text("8-BAND GRAPHIC EQ")
                .font(.caption)
                .fontWeight(.bold)
            
            HStack(spacing: 8) {
                ForEach(0..<8) { index in
                    VStack(spacing: 6) {
                        MinimalKnob(value: Binding(
                            get: { (bandGains[index] + 12) / 24 },
                            set: { bandGains[index] = ($0 * 24) - 12 }
                        ))
                        .frame(width: 35, height: 35)
                        
                        Text("\(frequencies[index])")
                            .font(.system(size: 8))
                            .foregroundColor(.secondary)
                        
                        Text("\(bandGains[index], specifier: "%.0f")")
                            .font(.system(size: 8))
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .theme(.audioUIMinimal)
    }
}
```

## Performance Optimization

### Efficient Value Updates
```swift
// ✅ Good: Debounce expensive operations
@State private var cutoffFrequency: Double = 1000
@State private var updateTimer: Timer?

InsetNeumorphicKnob(value: $cutoffFrequency)
    .onChange(of: cutoffFrequency) { newValue in
        updateTimer?.invalidate()
        updateTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: false) { _ in
            audioEngine.updateFilterCutoff(newValue)
        }
    }
```

### Memory Management
```swift
// ✅ Reuse knobs with @State
@State private var knobValue: Double = 0.5

// ❌ Avoid creating new instances
// Don't create InsetNeumorphicKnob() directly in body repeatedly
```

## Real-World Integration Examples

### Analog Synthesizer Module
```swift
struct AnalogSynthModule: View {
    @ObservedObject var synthEngine: SynthEngine
    
    var body: some View {
        VStack(spacing: 20) {
            // Oscillator Section
            HStack(spacing: 25) {
                parameterKnob(
                    "FREQ",
                    value: $synthEngine.oscillatorFreq,
                    range: 0.1...4000.0,
                    mapping: .logarithmic
                )
                
                parameterKnob(
                    "DETUNE",
                    value: $synthEngine.detune,
                    range: -50...50,
                    mapping: .linear
                )
                
                parameterKnob(
                    "WAVE",
                    value: $synthEngine.waveform,
                    range: 0...3,
                    mapping: .stepped
                )
            }
            
            // Filter Section
            HStack(spacing: 25) {
                parameterKnob(
                    "CUTOFF",
                    value: $synthEngine.filterCutoff,
                    range: 20...20000,
                    mapping: .logarithmic
                )
                
                parameterKnob(
                    "RES",
                    value: $synthEngine.resonance,
                    range: 0...1,
                    mapping: .linear
                )
                
                parameterKnob(
                    "ENV",
                    value: $synthEngine.envelopeAmount,
                    range: -1...1,
                    mapping: .linear
                )
            }
        }
        .theme(.audioUINeumorphic)
    }
    
    private func parameterKnob(
        _ label: String,
        value: Binding<Double>,
        range: ClosedRange<Double>,
        mapping: ParameterMapping
    ) -> some View {
        VStack(spacing: 8) {
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
            
            InsetNeumorphicKnob(value: Binding(
                get: { mapping.normalize(value.wrappedValue, range: range) },
                set: { value.wrappedValue = mapping.denormalize($0, range: range) }
            ))
            .frame(width: 60, height: 60)
            
            Text(mapping.formatValue(value.wrappedValue))
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}
```

### Professional Mixing Console Channel
```swift
struct MixingConsoleChannel: View {
    @ObservedObject var channel: ChannelStrip
    
    var body: some View {
        VStack(spacing: 10) {
            // Channel number
            Text("CH \(channel.number)")
                .font(.caption)
                .fontWeight(.bold)
            
            // High-frequency EQ
            knobWithLabel(
                "HF",
                value: $channel.hfGain,
                color: .blue
            )
            
            // High-mid frequency EQ
            knobWithLabel(
                "HMF",
                value: $channel.hmfGain,
                color: .green
            )
            
            // Low-mid frequency EQ  
            knobWithLabel(
                "LMF",
                value: $channel.lmfGain,
                color: .yellow
            )
            
            // Low-frequency EQ
            knobWithLabel(
                "LF",
                value: $channel.lfGain,
                color: .red
            )
            
            // Aux sends
            ForEach(0..<channel.auxSends.count, id: \.self) { index in
                MinimalKnob(value: $channel.auxSends[index])
                    .frame(width: 25, height: 25)
            }
        }
        .theme(.audioUIMinimal)
        .frame(width: 60)
    }
    
    private func knobWithLabel(
        _ label: String,
        value: Binding<Double>,
        color: Color
    ) -> some View {
        VStack(spacing: 4) {
            MinimalKnob(value: Binding(
                get: { (value.wrappedValue + 15) / 30 }, // -15dB to +15dB
                set: { value.wrappedValue = ($0 * 30) - 15 }
            ))
            .frame(width: 35, height: 35)
            .accentColor(color)
            
            Text(label)
                .font(.system(size: 8))
                .foregroundColor(.secondary)
        }
    }
}
```

## See Also

- <doc:Sliders> - Linear controls for different parameter types
- <doc:Buttons> - Discrete controls and switching
- <doc:AudioUIComponents> - Complete component overview
- <doc:ThemingGuide> - Applying themes to knobs
