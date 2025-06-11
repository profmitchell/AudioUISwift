# Synthesizer Tutorial

Build a complete software synthesizer interface using AudioUI components.

## Overview

This tutorial guides you through creating a professional synthesizer interface from scratch, covering oscillators, filters, envelopes, and effects. You'll learn how to combine AudioUI components into a cohesive instrument interface.

## What You'll Build

By the end of this tutorial, you'll have created:
- Multi-oscillator synthesizer with waveform selection
- Multi-mode filter with cutoff and resonance controls
- ADSR envelope generator with visual feedback
- Built-in effects rack with delay and reverb
- Real-time parameter visualization
- Preset management system

## Prerequisites

- Basic knowledge of SwiftUI
- Understanding of audio synthesis concepts
- Familiarity with AudioUI components

## Step 1: Project Setup

First, create a new SwiftUI project and add AudioUI as a dependency:

```swift
import SwiftUI
import AudioUI
import AudioUICore
import AudioUITheme

struct SynthesizerApp: App {
    var body: some Scene {
        WindowGroup {
            SynthesizerView()
                .audioUITheme(.neumorphic)
        }
    }
}
```

## Step 2: Oscillator Section

Create the oscillator controls with waveform selection and tuning:

```swift
struct OscillatorSection: View {
    @Binding var waveform: Waveform
    @Binding var frequency: Double
    @Binding var detune: Double
    @Binding var pulseWidth: Double
    
    var body: some View {
        VStack(spacing: 20) {
            Text("OSCILLATOR")
                .audioUILabel(.section)
            
            HStack(spacing: 30) {
                // Waveform Selection
                VStack {
                    Text("WAVE")
                        .audioUILabel(.parameter)
                    
                    HStack {
                        ForEach(Waveform.allCases, id: \.self) { wave in
                            RectangularButton(
                                title: wave.symbol,
                                isPressed: .constant(waveform == wave)
                            ) {
                                waveform = wave
                            }
                            .frame(width: 40, height: 30)
                        }
                    }
                }
                
                // Frequency Control
                VStack {
                    Text("FREQ")
                        .audioUILabel(.parameter)
                    
                    InsetNeumorphicKnob(value: Binding(
                        get: { (frequency - 20) / 20000 },
                        set: { frequency = 20 + $0 * 20000 }
                    ))
                    .frame(width: 80, height: 80)
                    
                    Text("\(Int(frequency)) Hz")
                        .audioUILabel(.value)
                }
                
                // Detune Control
                VStack {
                    Text("DETUNE")
                        .audioUILabel(.parameter)
                    
                    InsetNeumorphicKnob(value: Binding(
                        get: { (detune + 50) / 100 },
                        set: { detune = $0 * 100 - 50 }
                    ))
                    .frame(width: 60, height: 60)
                    
                    Text("\(Int(detune)) ct")
                        .audioUILabel(.value)
                }
                
                // Pulse Width (for square wave)
                if waveform == .square {
                    VStack {
                        Text("WIDTH")
                            .audioUILabel(.parameter)
                        
                        InsetNeumorphicKnob(value: $pulseWidth)
                            .frame(width: 60, height: 60)
                        
                        Text("\(Int(pulseWidth * 100))%")
                            .audioUILabel(.value)
                    }
                    .transition(.opacity.combined(with: .scale))
                }
            }
            .animation(.easeInOut(duration: 0.2), value: waveform)
        }
        .audioUIGroupBox()
    }
}

enum Waveform: CaseIterable {
    case sine, triangle, sawtooth, square
    
    var symbol: String {
        switch self {
        case .sine: return "∿"
        case .triangle: return "△"
        case .sawtooth: return "⩙"
        case .square: return "⊓"
        }
    }
}
```

## Step 3: Filter Section

Implement a multi-mode filter with cutoff, resonance, and envelope amount:

```swift
struct FilterSection: View {
    @Binding var cutoff: Double
    @Binding var resonance: Double
    @Binding var filterType: FilterType
    @Binding var envelopeAmount: Double
    @Binding var keyTracking: Double
    
    var body: some View {
        VStack(spacing: 20) {
            Text("FILTER")
                .audioUILabel(.section)
            
            HStack(spacing: 30) {
                // Filter Type Selection
                VStack {
                    Text("TYPE")
                        .audioUILabel(.parameter)
                    
                    VStack(spacing: 8) {
                        ForEach(FilterType.allCases, id: \.self) { type in
                            RectangularButton(
                                title: type.abbreviation,
                                isPressed: .constant(filterType == type)
                            ) {
                                filterType = type
                            }
                            .frame(width: 50, height: 25)
                        }
                    }
                }
                
                // Cutoff Control with XY Pad
                VStack {
                    Text("CUTOFF & RESONANCE")
                        .audioUILabel(.parameter)
                    
                    FilterXYPad(
                        x: $cutoff,
                        y: $resonance
                    )
                    .frame(width: 120, height: 120)
                    
                    HStack {
                        Text("\(Int(cutoff * 20000)) Hz")
                        Spacer()
                        Text("\(Int(resonance * 100))%")
                    }
                    .audioUILabel(.value)
                    .frame(width: 120)
                }
                
                // Envelope Amount
                VStack {
                    Text("ENV AMT")
                        .audioUILabel(.parameter)
                    
                    VerticalInsetSlider(value: Binding(
                        get: { (envelopeAmount + 1) / 2 },
                        set: { envelopeAmount = $0 * 2 - 1 }
                    ))
                    .frame(width: 30, height: 100)
                    
                    Text("\(Int(envelopeAmount * 100))")
                        .audioUILabel(.value)
                }
                
                // Key Tracking
                VStack {
                    Text("KEY TRK")
                        .audioUILabel(.parameter)
                    
                    InsetNeumorphicKnob(value: $keyTracking)
                        .frame(width: 60, height: 60)
                    
                    Text("\(Int(keyTracking * 100))%")
                        .audioUILabel(.value)
                }
            }
        }
        .audioUIGroupBox()
    }
}

enum FilterType: CaseIterable {
    case lowpass, highpass, bandpass, notch
    
    var abbreviation: String {
        switch self {
        case .lowpass: return "LP"
        case .highpass: return "HP"
        case .bandpass: return "BP"
        case .notch: return "NT"
        }
    }
}
```

## Step 4: Envelope Generator

Create an ADSR envelope with visual feedback:

```swift
struct EnvelopeSection: View {
    @Binding var attack: Double
    @Binding var decay: Double
    @Binding var sustain: Double
    @Binding var release: Double
    @State private var isTriggered = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("ENVELOPE")
                .audioUILabel(.section)
            
            HStack(spacing: 30) {
                // Envelope Visualization
                VStack {
                    Text("ADSR CURVE")
                        .audioUILabel(.parameter)
                    
                    EnvelopeVisualization(
                        attack: attack,
                        decay: decay,
                        sustain: sustain,
                        release: release,
                        isTriggered: isTriggered
                    )
                    .frame(width: 200, height: 100)
                    .audioUIDisplay()
                    
                    // Trigger button for testing
                    RectangularButton(
                        title: "TRIGGER",
                        isPressed: $isTriggered
                    ) {
                        triggerEnvelope()
                    }
                    .frame(width: 80, height: 30)
                }
                
                // ADSR Controls
                HStack(spacing: 20) {
                    VStack {
                        Text("ATTACK")
                            .audioUILabel(.parameter)
                        
                        VerticalInsetSlider(value: $attack)
                            .frame(width: 30, height: 100)
                        
                        Text("\(Int(attack * 1000)) ms")
                            .audioUILabel(.value)
                    }
                    
                    VStack {
                        Text("DECAY")
                            .audioUILabel(.parameter)
                        
                        VerticalInsetSlider(value: $decay)
                            .frame(width: 30, height: 100)
                        
                        Text("\(Int(decay * 1000)) ms")
                            .audioUILabel(.value)
                    }
                    
                    VStack {
                        Text("SUSTAIN")
                            .audioUILabel(.parameter)
                        
                        VerticalInsetSlider(value: $sustain)
                            .frame(width: 30, height: 100)
                        
                        Text("\(Int(sustain * 100))%")
                            .audioUILabel(.value)
                    }
                    
                    VStack {
                        Text("RELEASE")
                            .audioUILabel(.parameter)
                        
                        VerticalInsetSlider(value: $release)
                            .frame(width: 30, height: 100)
                        
                        Text("\(Int(release * 1000)) ms")
                            .audioUILabel(.value)
                    }
                }
            }
        }
        .audioUIGroupBox()
    }
    
    private func triggerEnvelope() {
        withAnimation(.easeOut(duration: 0.1)) {
            isTriggered = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.easeOut(duration: 0.2)) {
                isTriggered = false
            }
        }
    }
}
```

## Step 5: Effects Section

Add built-in effects with real-time parameter control:

```swift
struct EffectsSection: View {
    @Binding var delayTime: Double
    @Binding var delayFeedback: Double
    @Binding var delayMix: Double
    @Binding var reverbSize: Double
    @Binding var reverbDamping: Double
    @Binding var reverbMix: Double
    
    var body: some View {
        VStack(spacing: 20) {
            Text("EFFECTS")
                .audioUILabel(.section)
            
            HStack(spacing: 40) {
                // Delay Section
                VStack(spacing: 15) {
                    Text("DELAY")
                        .audioUILabel(.subsection)
                    
                    HStack(spacing: 20) {
                        VStack {
                            Text("TIME")
                                .audioUILabel(.parameter)
                            
                            InsetNeumorphicKnob(value: $delayTime)
                                .frame(width: 60, height: 60)
                            
                            Text("\(Int(delayTime * 1000)) ms")
                                .audioUILabel(.value)
                        }
                        
                        VStack {
                            Text("FEEDBACK")
                                .audioUILabel(.parameter)
                            
                            InsetNeumorphicKnob(value: $delayFeedback)
                                .frame(width: 60, height: 60)
                            
                            Text("\(Int(delayFeedback * 100))%")
                                .audioUILabel(.value)
                        }
                        
                        VStack {
                            Text("MIX")
                                .audioUILabel(.parameter)
                            
                            InsetNeumorphicKnob(value: $delayMix)
                                .frame(width: 60, height: 60)
                            
                            Text("\(Int(delayMix * 100))%")
                                .audioUILabel(.value)
                        }
                    }
                }
                
                // Reverb Section
                VStack(spacing: 15) {
                    Text("REVERB")
                        .audioUILabel(.subsection)
                    
                    HStack(spacing: 20) {
                        VStack {
                            Text("SIZE")
                                .audioUILabel(.parameter)
                            
                            InsetNeumorphicKnob(value: $reverbSize)
                                .frame(width: 60, height: 60)
                            
                            Text("\(Int(reverbSize * 100))%")
                                .audioUILabel(.value)
                        }
                        
                        VStack {
                            Text("DAMPING")
                                .audioUILabel(.parameter)
                            
                            InsetNeumorphicKnob(value: $reverbDamping)
                                .frame(width: 60, height: 60)
                            
                            Text("\(Int(reverbDamping * 100))%")
                                .audioUILabel(.value)
                        }
                        
                        VStack {
                            Text("MIX")
                                .audioUILabel(.parameter)
                            
                            InsetNeumorphicKnob(value: $reverbMix)
                                .frame(width: 60, height: 60)
                            
                            Text("\(Int(reverbMix * 100))%")
                                .audioUILabel(.value)
                        }
                    }
                }
            }
        }
        .audioUIGroupBox()
    }
}
```

## Step 6: Master Section

Create the master output controls with level metering:

```swift
struct MasterSection: View {
    @Binding var volume: Double
    @Binding var pan: Double
    @State private var leftLevel: Double = 0.0
    @State private var rightLevel: Double = 0.0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("MASTER")
                .audioUILabel(.section)
            
            HStack(spacing: 30) {
                // Level Meters
                VStack {
                    Text("LEVELS")
                        .audioUILabel(.parameter)
                    
                    HStack(spacing: 10) {
                        VStack {
                            Text("L")
                                .audioUILabel(.small)
                            
                            LevelMeter(level: leftLevel)
                                .frame(width: 20, height: 120)
                        }
                        
                        VStack {
                            Text("R")
                                .audioUILabel(.small)
                            
                            LevelMeter(level: rightLevel)
                                .frame(width: 20, height: 120)
                        }
                    }
                }
                
                // Volume Control
                VStack {
                    Text("VOLUME")
                        .audioUILabel(.parameter)
                    
                    VerticalInsetSlider(value: $volume)
                        .frame(width: 40, height: 120)
                    
                    Text("\(Int(volume * 100))")
                        .audioUILabel(.value)
                }
                
                // Pan Control
                VStack {
                    Text("PAN")
                        .audioUILabel(.parameter)
                    
                    HorizontalFader(value: Binding(
                        get: { (pan + 1) / 2 },
                        set: { pan = $0 * 2 - 1 }
                    ))
                    .frame(width: 100, height: 30)
                    
                    Text(panLabel)
                        .audioUILabel(.value)
                }
            }
        }
        .audioUIGroupBox()
        .onReceive(Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()) { _ in
            updateLevels()
        }
    }
    
    private var panLabel: String {
        if abs(pan) < 0.05 {
            return "CENTER"
        } else if pan > 0 {
            return "R\(Int(pan * 100))"
        } else {
            return "L\(Int(-pan * 100))"
        }
    }
    
    private func updateLevels() {
        // Simulate audio level updates
        leftLevel = Double.random(in: 0...volume)
        rightLevel = Double.random(in: 0...volume)
    }
}
```

## Step 7: Complete Synthesizer View

Combine all sections into the main synthesizer interface:

```swift
struct SynthesizerView: View {
    // Oscillator parameters
    @State private var waveform: Waveform = .sawtooth
    @State private var frequency: Double = 440.0
    @State private var detune: Double = 0.0
    @State private var pulseWidth: Double = 0.5
    
    // Filter parameters
    @State private var cutoff: Double = 0.8
    @State private var resonance: Double = 0.2
    @State private var filterType: FilterType = .lowpass
    @State private var envelopeAmount: Double = 0.5
    @State private var keyTracking: Double = 0.5
    
    // Envelope parameters
    @State private var attack: Double = 0.1
    @State private var decay: Double = 0.3
    @State private var sustain: Double = 0.7
    @State private var release: Double = 0.4
    
    // Effects parameters
    @State private var delayTime: Double = 0.25
    @State private var delayFeedback: Double = 0.3
    @State private var delayMix: Double = 0.2
    @State private var reverbSize: Double = 0.6
    @State private var reverbDamping: Double = 0.4
    @State private var reverbMix: Double = 0.15
    
    // Master parameters
    @State private var volume: Double = 0.8
    @State private var pan: Double = 0.0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Header
                Text("AudioUI Synthesizer")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .audioUIAccent()
                
                // Oscillator Section
                OscillatorSection(
                    waveform: $waveform,
                    frequency: $frequency,
                    detune: $detune,
                    pulseWidth: $pulseWidth
                )
                
                // Filter Section
                FilterSection(
                    cutoff: $cutoff,
                    resonance: $resonance,
                    filterType: $filterType,
                    envelopeAmount: $envelopeAmount,
                    keyTracking: $keyTracking
                )
                
                // Envelope Section
                EnvelopeSection(
                    attack: $attack,
                    decay: $decay,
                    sustain: $sustain,
                    release: $release
                )
                
                // Effects Section
                EffectsSection(
                    delayTime: $delayTime,
                    delayFeedback: $delayFeedback,
                    delayMix: $delayMix,
                    reverbSize: $reverbSize,
                    reverbDamping: $reverbDamping,
                    reverbMix: $reverbMix
                )
                
                // Master Section
                MasterSection(
                    volume: $volume,
                    pan: $pan
                )
                
                // Preset Management
                PresetSection()
            }
            .padding(20)
        }
        .audioUIBackground()
    }
}
```

## Step 8: Adding Presets

Implement preset management for saving and loading synthesizer settings:

```swift
struct PresetSection: View {
    @State private var presets: [SynthPreset] = SynthPreset.builtInPresets
    @State private var selectedPreset: SynthPreset?
    @State private var showingSaveDialog = false
    
    var body: some View {
        VStack(spacing: 15) {
            Text("PRESETS")
                .audioUILabel(.section)
            
            HStack(spacing: 15) {
                // Preset List
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(presets) { preset in
                            RectangularButton(
                                title: preset.name,
                                isPressed: .constant(selectedPreset?.id == preset.id)
                            ) {
                                loadPreset(preset)
                            }
                            .frame(width: 100, height: 40)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Save Button
                RectangularButton(
                    title: "SAVE",
                    isPressed: .constant(false)
                ) {
                    showingSaveDialog = true
                }
                .frame(width: 60, height: 40)
            }
        }
        .audioUIGroupBox()
        .sheet(isPresented: $showingSaveDialog) {
            SavePresetView { name in
                saveCurrentPreset(name: name)
            }
        }
    }
    
    private func loadPreset(_ preset: SynthPreset) {
        selectedPreset = preset
        // Apply preset parameters to synthesizer
        // This would typically update all the @State variables
    }
    
    private func saveCurrentPreset(name: String) {
        let newPreset = SynthPreset(
            name: name,
            // Capture current parameter values
            waveform: .sawtooth, // Current waveform
            cutoff: 0.8,         // Current cutoff
            // ... other parameters
        )
        presets.append(newPreset)
    }
}

struct SynthPreset: Identifiable, Codable {
    let id = UUID()
    let name: String
    let waveform: Waveform
    let cutoff: Double
    // ... other parameters
    
    static let builtInPresets = [
        SynthPreset(name: "Lead", waveform: .sawtooth, cutoff: 0.8),
        SynthPreset(name: "Bass", waveform: .square, cutoff: 0.4),
        SynthPreset(name: "Pad", waveform: .triangle, cutoff: 0.6),
        SynthPreset(name: "Pluck", waveform: .sine, cutoff: 0.9)
    ]
}
```

## Conclusion

You've now built a complete synthesizer interface using AudioUI! This tutorial demonstrated:

- **Component Integration**: Combining different AudioUI components
- **Real-time Controls**: Responsive parameter manipulation
- **Visual Feedback**: Live displays and meters
- **Preset Management**: Saving and loading configurations
- **Professional Layout**: Organized, intuitive interface design

## Next Steps

- Connect to an audio engine (AVAudioEngine, AudioKit, etc.)
- Add MIDI input support
- Implement polyphony
- Add more oscillator types
- Create custom visual effects
- Build a keyboard interface

The synthesizer you've built provides a solid foundation for creating professional audio software with AudioUI!
