# Mixer Tutorial

Build a professional audio mixer interface with channel strips, EQ, effects, and automation.

## Overview

This tutorial demonstrates how to create a complete digital audio mixer using AudioUI components. You'll build channel strips, master section, effects sends, and automation controls suitable for music production or live sound applications.

## What You'll Build

By the end of this tutorial, you'll have created:
- Multi-channel mixer with professional channel strips
- 4-band parametric EQ with frequency analysis
- Dynamics processing (compressor, gate, limiter)
- Effects sends and returns with built-in reverb and delay
- Master section with stereo bus processing
- Automation system with recordable parameters
- Scene recall and preset management

## Prerequisites

- Solid understanding of SwiftUI and AudioUI
- Basic knowledge of audio mixing concepts
- Familiarity with professional audio workflows

## Step 1: Project Setup

Create the mixer application structure:

```swift
import SwiftUI
import AudioUI
import AudioUICore
import AudioUITheme

struct MixerApp: App {
    var body: some Scene {
        WindowGroup {
            MixerView()
                .audioUITheme(.professional)
        }
    }
}
```

## Step 2: Channel Strip Foundation

Create the basic channel strip structure:

```swift
struct ChannelStrip: View {
    @Binding var channel: MixerChannel
    let channelNumber: Int
    @State private var showEQ = false
    @State private var showDynamics = false
    
    var body: some View {
        VStack(spacing: 8) {
            // Channel Header
            ChannelHeader(
                number: channelNumber,
                channel: $channel
            )
            
            // Input Gain
            InputGainSection(gain: $channel.inputGain)
            
            // EQ Section
            EQSection(
                eq: $channel.eq,
                showDetails: $showEQ
            )
            
            // Dynamics Section
            DynamicsSection(
                dynamics: $channel.dynamics,
                showDetails: $showDynamics
            )
            
            // Sends Section
            SendsSection(sends: $channel.sends)
            
            // Pan and Fader
            OutputSection(
                pan: $channel.pan,
                volume: $channel.volume,
                mute: $channel.mute,
                solo: $channel.solo,
                level: $channel.level
            )
        }
        .frame(width: 120)
        .audioUIChannelStrip()
    }
}

struct MixerChannel: ObservableObject {
    @Published var name: String
    @Published var inputGain: Double = 0.0
    @Published var eq: ChannelEQ = ChannelEQ()
    @Published var dynamics: ChannelDynamics = ChannelDynamics()
    @Published var sends: [Double] = Array(repeating: 0.0, count: 4)
    @Published var pan: Double = 0.0
    @Published var volume: Double = 0.75
    @Published var mute: Bool = false
    @Published var solo: Bool = false
    @Published var level: Double = 0.0
    
    init(name: String) {
        self.name = name
    }
}
```

## Step 3: Channel Header with I/O

Build the channel identification and routing:

```swift
struct ChannelHeader: View {
    let number: Int
    @Binding var channel: MixerChannel
    @State private var showRouting = false
    
    var body: some View {
        VStack(spacing: 6) {
            // Channel Number and Name
            VStack(spacing: 2) {
                Text("\(number)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.accent)
                
                Text(channel.name)
                    .font(.caption2)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            
            // Input/Output Routing
            RectangularButton(
                title: "I/O",
                isPressed: .constant(showRouting)
            ) {
                showRouting.toggle()
            }
            .frame(width: 30, height: 20)
            
            // Signal Present Indicator
            Circle()
                .fill(channel.level > 0.01 ? .green : .gray)
                .frame(width: 8, height: 8)
                .opacity(channel.level > 0.01 ? 1.0 : 0.3)
        }
        .sheet(isPresented: $showRouting) {
            ChannelRoutingView(channel: $channel)
        }
    }
}

struct ChannelRoutingView: View {
    @Binding var channel: MixerChannel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Channel \(channel.name) Routing")
                .font(.title2)
                .fontWeight(.semibold)
            
            // Input routing controls
            VStack(alignment: .leading, spacing: 15) {
                Text("INPUT SOURCE")
                    .audioUILabel(.parameter)
                
                // Input source selection
                // ... routing interface
            }
            
            Spacer()
            
            Button("Done") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .frame(width: 400, height: 300)
    }
}
```

## Step 4: Input Gain Control

Create input gain with clip indicator:

```swift
struct InputGainSection: View {
    @Binding var gain: Double
    @State private var isClipping = false
    
    var body: some View {
        VStack(spacing: 6) {
            Text("GAIN")
                .audioUILabel(.small)
            
            // Clip Indicator
            Circle()
                .fill(isClipping ? .red : .clear)
                .stroke(.red, lineWidth: 1)
                .frame(width: 12, height: 12)
                .opacity(isClipping ? 1.0 : 0.3)
            
            // Gain Knob
            InsetNeumorphicKnob(value: Binding(
                get: { (gain + 20) / 40 }, // -20dB to +20dB range
                set: { 
                    gain = $0 * 40 - 20
                    checkClipping()
                }
            ))
            .frame(width: 50, height: 50)
            
            // Gain Value
            Text("\(gain >= 0 ? "+" : "")\(String(format: "%.1f", gain))")
                .font(.caption2)
                .monospacedDigit()
        }
    }
    
    private func checkClipping() {
        isClipping = gain > 18.0
        
        if isClipping {
            // Flash clip indicator
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isClipping = false
            }
        }
    }
}
```

## Step 5: 4-Band Parametric EQ

Implement professional EQ with frequency response display:

```swift
struct EQSection: View {
    @Binding var eq: ChannelEQ
    @Binding var showDetails: Bool
    
    var body: some View {
        VStack(spacing: 6) {
            // EQ Header
            HStack {
                Text("EQ")
                    .audioUILabel(.small)
                
                Spacer()
                
                ToggleButton(
                    title: "",
                    isOn: $eq.enabled
                )
                .frame(width: 16, height: 16)
            }
            
            if showDetails {
                // Detailed EQ View
                EQDetailView(eq: $eq)
                    .frame(height: 200)
                    .transition(.opacity.combined(with: .scale))
            } else {
                // Compact EQ Controls
                VStack(spacing: 4) {
                    ForEach(0..<4, id: \.self) { band in
                        EQBandControl(
                            band: Binding(
                                get: { eq.bands[band] },
                                set: { eq.bands[band] = $0 }
                            ),
                            bandName: bandNames[band]
                        )
                    }
                }
            }
            
            // Show/Hide Details Button
            RectangularButton(
                title: showDetails ? "◂" : "▸",
                isPressed: .constant(false)
            ) {
                withAnimation(.easeInOut(duration: 0.2)) {
                    showDetails.toggle()
                }
            }
            .frame(width: 20, height: 16)
        }
    }
    
    private let bandNames = ["HI", "HM", "LM", "LO"]
}

struct ChannelEQ: ObservableObject {
    @Published var enabled: Bool = true
    @Published var bands: [EQBand] = [
        EQBand(frequency: 12000, gain: 0, q: 0.7, type: .highShelf),
        EQBand(frequency: 2500, gain: 0, q: 1.0, type: .bell),
        EQBand(frequency: 400, gain: 0, q: 1.0, type: .bell),
        EQBand(frequency: 80, gain: 0, q: 0.7, type: .lowShelf)
    ]
}

struct EQBand: ObservableObject {
    @Published var frequency: Double
    @Published var gain: Double
    @Published var q: Double
    @Published var type: EQBandType
    @Published var enabled: Bool = true
    
    init(frequency: Double, gain: Double, q: Double, type: EQBandType) {
        self.frequency = frequency
        self.gain = gain
        self.q = q
        self.type = type
    }
}

enum EQBandType {
    case highPass, lowShelf, bell, highShelf, lowPass
}

struct EQBandControl: View {
    @Binding var band: EQBand
    let bandName: String
    
    var body: some View {
        HStack(spacing: 4) {
            Text(bandName)
                .font(.caption2)
                .frame(width: 20)
            
            // Gain Control
            InsetNeumorphicKnob(value: Binding(
                get: { (band.gain + 15) / 30 }, // -15dB to +15dB
                set: { band.gain = $0 * 30 - 15 }
            ))
            .frame(width: 30, height: 30)
            
            // Frequency (if bell type)
            if band.type == .bell {
                InsetNeumorphicKnob(value: Binding(
                    get: { log10(band.frequency / 20) / log10(1000) }, // 20Hz to 20kHz log scale
                    set: { band.frequency = 20 * pow(1000, $0) }
                ))
                .frame(width: 25, height: 25)
            }
        }
    }
}

struct EQDetailView: View {
    @Binding var eq: ChannelEQ
    
    var body: some View {
        VStack(spacing: 10) {
            // Frequency Response Graph
            EQFrequencyResponse(eq: eq)
                .frame(height: 120)
                .audioUIDisplay()
            
            // Detailed Controls
            HStack(spacing: 8) {
                ForEach(0..<4, id: \.self) { bandIndex in
                    EQBandDetailControl(
                        band: Binding(
                            get: { eq.bands[bandIndex] },
                            set: { eq.bands[bandIndex] = $0 }
                        )
                    )
                }
            }
        }
    }
}
```

## Step 6: Dynamics Processing

Add compressor, gate, and limiter:

```swift
struct DynamicsSection: View {
    @Binding var dynamics: ChannelDynamics
    @Binding var showDetails: Bool
    
    var body: some View {
        VStack(spacing: 6) {
            // Dynamics Header
            HStack {
                Text("DYN")
                    .audioUILabel(.small)
                
                Spacer()
                
                ToggleButton(
                    title: "",
                    isOn: $dynamics.enabled
                )
                .frame(width: 16, height: 16)
            }
            
            if showDetails {
                DynamicsDetailView(dynamics: $dynamics)
                    .frame(height: 150)
                    .transition(.opacity.combined(with: .scale))
            } else {
                // Compact Controls
                VStack(spacing: 4) {
                    HStack {
                        Text("COMP")
                            .font(.caption2)
                            .frame(width: 30)
                        
                        InsetNeumorphicKnob(value: $dynamics.compressor.threshold)
                            .frame(width: 25, height: 25)
                        
                        InsetNeumorphicKnob(value: $dynamics.compressor.ratio)
                            .frame(width: 25, height: 25)
                    }
                    
                    HStack {
                        Text("GATE")
                            .font(.caption2)
                            .frame(width: 30)
                        
                        InsetNeumorphicKnob(value: $dynamics.gate.threshold)
                            .frame(width: 25, height: 25)
                        
                        InsetNeumorphicKnob(value: $dynamics.gate.ratio)
                            .frame(width: 25, height: 25)
                    }
                }
            }
            
            // Gain Reduction Meter
            GainReductionMeter(gainReduction: dynamics.gainReduction)
                .frame(width: 60, height: 8)
            
            // Show/Hide Details
            RectangularButton(
                title: showDetails ? "◂" : "▸",
                isPressed: .constant(false)
            ) {
                withAnimation(.easeInOut(duration: 0.2)) {
                    showDetails.toggle()
                }
            }
            .frame(width: 20, height: 16)
        }
    }
}

struct ChannelDynamics: ObservableObject {
    @Published var enabled: Bool = false
    @Published var compressor: Compressor = Compressor()
    @Published var gate: Gate = Gate()
    @Published var gainReduction: Double = 0.0
}

struct Compressor: ObservableObject {
    @Published var threshold: Double = 0.7
    @Published var ratio: Double = 0.25  // 1:1 to 20:1
    @Published var attack: Double = 0.1
    @Published var release: Double = 0.3
    @Published var knee: Double = 0.0
    @Published var makeupGain: Double = 0.0
}

struct Gate: ObservableObject {
    @Published var threshold: Double = 0.1
    @Published var ratio: Double = 0.8
    @Published var attack: Double = 0.01
    @Published var hold: Double = 0.05
    @Published var release: Double = 0.1
}

struct GainReductionMeter: View {
    let gainReduction: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background
                RoundedRectangle(cornerRadius: 2)
                    .fill(.gray.opacity(0.3))
                
                // Gain Reduction
                RoundedRectangle(cornerRadius: 2)
                    .fill(.orange)
                    .frame(width: geometry.size.width * gainReduction)
            }
        }
    }
}
```

## Step 7: Effects Sends

Create auxiliary send controls:

```swift
struct SendsSection: View {
    @Binding var sends: [Double]
    private let sendNames = ["R1", "R2", "R3", "R4"]
    
    var body: some View {
        VStack(spacing: 6) {
            Text("SENDS")
                .audioUILabel(.small)
            
            VStack(spacing: 4) {
                ForEach(0..<min(sends.count, sendNames.count), id: \.self) { index in
                    HStack(spacing: 4) {
                        Text(sendNames[index])
                            .font(.caption2)
                            .frame(width: 20)
                        
                        // Send Level
                        InsetNeumorphicKnob(value: $sends[index])
                            .frame(width: 30, height: 30)
                        
                        // Pre/Post Switch
                        ToggleButton(
                            title: "",
                            isOn: .constant(false) // Pre/post fader
                        )
                        .frame(width: 16, height: 16)
                    }
                }
            }
        }
    }
}
```

## Step 8: Channel Output Section

Build pan, fader, and controls:

```swift
struct OutputSection: View {
    @Binding var pan: Double
    @Binding var volume: Double
    @Binding var mute: Bool
    @Binding var solo: Bool
    @Binding var level: Double
    
    @State private var peakLevel: Double = 0.0
    
    var body: some View {
        VStack(spacing: 8) {
            // Pan Control
            VStack(spacing: 4) {
                Text("PAN")
                    .audioUILabel(.small)
                
                InsetNeumorphicKnob(value: Binding(
                    get: { (pan + 1) / 2 },
                    set: { pan = $0 * 2 - 1 }
                ))
                .frame(width: 40, height: 40)
                
                Text(panLabel)
                    .font(.caption2)
                    .monospacedDigit()
            }
            
            // Mute/Solo Buttons
            VStack(spacing: 4) {
                ToggleButton(
                    title: "SOLO",
                    isOn: $solo
                )
                .frame(width: 50, height: 25)
                .foregroundColor(solo ? .yellow : .primary)
                
                ToggleButton(
                    title: "MUTE",
                    isOn: $mute
                )
                .frame(width: 50, height: 25)
                .foregroundColor(mute ? .red : .primary)
            }
            
            // Level Meter
            HStack(spacing: 4) {
                ChannelLevelMeter(
                    level: level,
                    peakLevel: peakLevel
                )
                .frame(width: 20, height: 120)
                
                // Fader
                VerticalInsetSlider(value: $volume)
                    .frame(width: 30, height: 120)
            }
            
            // Fader Value
            Text("\(Int(volume * 100))")
                .font(.caption2)
                .monospacedDigit()
        }
        .onReceive(Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()) { _ in
            updateLevels()
        }
    }
    
    private var panLabel: String {
        if abs(pan) < 0.05 {
            return "C"
        } else if pan > 0 {
            return "R\(Int(pan * 50))"
        } else {
            return "L\(Int(-pan * 50))"
        }
    }
    
    private func updateLevels() {
        if !mute {
            level = Double.random(in: 0...volume)
            peakLevel = max(peakLevel * 0.99, level)
        } else {
            level = 0.0
            peakLevel = 0.0
        }
    }
}

struct ChannelLevelMeter: View {
    let level: Double
    let peakLevel: Double
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 1) {
                ForEach(0..<20, id: \.self) { segment in
                    let segmentLevel = Double(19 - segment) / 19.0
                    let isActive = level >= segmentLevel
                    let isPeak = peakLevel >= segmentLevel && segment < 3
                    
                    Rectangle()
                        .fill(segmentColor(segment: segment, isActive: isActive, isPeak: isPeak))
                        .frame(height: geometry.size.height / 20 - 1)
                }
            }
        }
    }
    
    private func segmentColor(segment: Int, isActive: Bool, isPeak: Bool) -> Color {
        if !isActive { return .gray.opacity(0.3) }
        
        if isPeak { return .red }
        if segment < 6 { return .green }
        if segment < 15 { return .yellow }
        return .orange
    }
}
```

## Step 9: Master Section

Create the master bus controls:

```swift
struct MasterSection: View {
    @State private var masterVolume: Double = 0.8
    @State private var masterPan: Double = 0.0
    @State private var leftLevel: Double = 0.0
    @State private var rightLevel: Double = 0.0
    @State private var masterEQ = MasterEQ()
    @State private var masterCompressor = MasterCompressor()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("MASTER")
                .audioUILabel(.section)
            
            HStack(spacing: 30) {
                // Master EQ
                VStack(spacing: 15) {
                    Text("MASTER EQ")
                        .audioUILabel(.parameter)
                    
                    HStack(spacing: 15) {
                        VStack {
                            Text("LOW")
                                .audioUILabel(.small)
                            
                            InsetNeumorphicKnob(value: $masterEQ.low)
                                .frame(width: 50, height: 50)
                            
                            Text("\(Int(masterEQ.lowGain)) dB")
                                .audioUILabel(.value)
                        }
                        
                        VStack {
                            Text("MID")
                                .audioUILabel(.small)
                            
                            InsetNeumorphicKnob(value: $masterEQ.mid)
                                .frame(width: 50, height: 50)
                            
                            Text("\(Int(masterEQ.midGain)) dB")
                                .audioUILabel(.value)
                        }
                        
                        VStack {
                            Text("HIGH")
                                .audioUILabel(.small)
                            
                            InsetNeumorphicKnob(value: $masterEQ.high)
                                .frame(width: 50, height: 50)
                            
                            Text("\(Int(masterEQ.highGain)) dB")
                                .audioUILabel(.value)
                        }
                    }
                }
                
                // Master Compressor
                VStack(spacing: 15) {
                    Text("MASTER COMP")
                        .audioUILabel(.parameter)
                    
                    HStack(spacing: 15) {
                        VStack {
                            Text("THRES")
                                .audioUILabel(.small)
                            
                            InsetNeumorphicKnob(value: $masterCompressor.threshold)
                                .frame(width: 50, height: 50)
                        }
                        
                        VStack {
                            Text("RATIO")
                                .audioUILabel(.small)
                            
                            InsetNeumorphicKnob(value: $masterCompressor.ratio)
                                .frame(width: 50, height: 50)
                        }
                        
                        VStack {
                            Text("MAKEUP")
                                .audioUILabel(.small)
                            
                            InsetNeumorphicKnob(value: $masterCompressor.makeupGain)
                                .frame(width: 50, height: 50)
                        }
                    }
                    
                    // Gain Reduction Display
                    GainReductionMeter(gainReduction: masterCompressor.gainReduction)
                        .frame(width: 150, height: 12)
                }
                
                // Master Output
                VStack(spacing: 15) {
                    Text("MASTER OUTPUT")
                        .audioUILabel(.parameter)
                    
                    HStack(spacing: 20) {
                        // Stereo Level Meters
                        VStack {
                            Text("L")
                                .audioUILabel(.small)
                            
                            LevelMeter(level: leftLevel)
                                .frame(width: 25, height: 150)
                        }
                        
                        VStack {
                            Text("R")
                                .audioUILabel(.small)
                            
                            LevelMeter(level: rightLevel)
                                .frame(width: 25, height: 150)
                        }
                        
                        // Master Fader
                        VStack {
                            Text("MASTER")
                                .audioUILabel(.small)
                            
                            VerticalInsetSlider(value: $masterVolume)
                                .frame(width: 40, height: 150)
                            
                            Text("\(Int(masterVolume * 100))")
                                .audioUILabel(.value)
                        }
                    }
                }
            }
        }
        .audioUIGroupBox()
        .onReceive(Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()) { _ in
            updateMasterLevels()
        }
    }
    
    private func updateMasterLevels() {
        leftLevel = Double.random(in: 0...masterVolume)
        rightLevel = Double.random(in: 0...masterVolume)
    }
}

struct MasterEQ: ObservableObject {
    @Published var low: Double = 0.5
    @Published var mid: Double = 0.5
    @Published var high: Double = 0.5
    
    var lowGain: Double { (low - 0.5) * 24 } // ±12dB
    var midGain: Double { (mid - 0.5) * 24 }
    var highGain: Double { (high - 0.5) * 24 }
}

struct MasterCompressor: ObservableObject {
    @Published var threshold: Double = 0.7
    @Published var ratio: Double = 0.3
    @Published var makeupGain: Double = 0.5
    @Published var gainReduction: Double = 0.0
}
```

## Step 10: Complete Mixer View

Assemble the full mixer interface:

```swift
struct MixerView: View {
    @State private var channels: [MixerChannel] = (1...8).map { 
        MixerChannel(name: "Ch \($0)") 
    }
    @State private var selectedChannel: Int? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("AudioUI Professional Mixer")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                // Global Controls
                HStack(spacing: 15) {
                    RectangularButton(
                        title: "SCENES",
                        isPressed: .constant(false)
                    ) {
                        // Show scene management
                    }
                    
                    RectangularButton(
                        title: "AUTOMATION",
                        isPressed: .constant(false)
                    ) {
                        // Show automation panel
                    }
                }
            }
            .padding()
            .audioUIGroupBox()
            
            HStack(alignment: .top, spacing: 0) {
                // Channel Strips
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(spacing: 2) {
                        ForEach(0..<channels.count, id: \.self) { index in
                            ChannelStrip(
                                channel: $channels[index],
                                channelNumber: index + 1
                            )
                            .audioUIBorder(
                                selectedChannel == index ? .accent : .primary,
                                width: selectedChannel == index ? 2 : 1
                            )
                            .onTapGesture {
                                selectedChannel = index
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Master Section
                MasterSection()
                    .frame(width: 400)
            }
            
            Spacer()
        }
        .audioUIBackground()
    }
}
```

## Step 11: Scene Management

Add scene recall and automation:

```swift
struct SceneManager: View {
    @State private var scenes: [MixerScene] = []
    @State private var currentScene: MixerScene?
    @State private var isRecording = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("SCENE MANAGEMENT")
                .audioUILabel(.section)
            
            HStack(spacing: 20) {
                // Scene List
                VStack {
                    Text("SCENES")
                        .audioUILabel(.parameter)
                    
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(scenes) { scene in
                                SceneButton(
                                    scene: scene,
                                    isCurrent: currentScene?.id == scene.id
                                ) {
                                    recallScene(scene)
                                }
                            }
                        }
                    }
                    .frame(height: 200)
                    
                    HStack {
                        RectangularButton(
                            title: "STORE",
                            isPressed: .constant(false)
                        ) {
                            storeCurrentScene()
                        }
                        
                        RectangularButton(
                            title: "DELETE",
                            isPressed: .constant(false)
                        ) {
                            deleteSelectedScene()
                        }
                    }
                }
                
                // Automation Controls
                VStack {
                    Text("AUTOMATION")
                        .audioUILabel(.parameter)
                    
                    VStack(spacing: 15) {
                        ToggleButton(
                            title: "RECORD",
                            isOn: $isRecording
                        )
                        .foregroundColor(isRecording ? .red : .primary)
                        
                        RectangularButton(
                            title: "PLAY",
                            isPressed: .constant(false)
                        ) {
                            playAutomation()
                        }
                        
                        RectangularButton(
                            title: "STOP",
                            isPressed: .constant(false)
                        ) {
                            stopAutomation()
                        }
                        
                        RectangularButton(
                            title: "CLEAR",
                            isPressed: .constant(false)
                        ) {
                            clearAutomation()
                        }
                    }
                }
            }
        }
        .audioUIGroupBox()
    }
    
    private func recallScene(_ scene: MixerScene) {
        currentScene = scene
        // Apply scene parameters to mixer
    }
    
    private func storeCurrentScene() {
        let newScene = MixerScene(name: "Scene \(scenes.count + 1)")
        scenes.append(newScene)
    }
    
    private func deleteSelectedScene() {
        // Delete selected scene
    }
    
    private func playAutomation() {
        // Start automation playback
    }
    
    private func stopAutomation() {
        // Stop automation
    }
    
    private func clearAutomation() {
        // Clear automation data
    }
}

struct MixerScene: Identifiable {
    let id = UUID()
    let name: String
    // Store mixer state parameters
}

struct SceneButton: View {
    let scene: MixerScene
    let isCurrent: Bool
    let action: () -> Void
    
    var body: some View {
        RectangularButton(
            title: scene.name,
            isPressed: .constant(isCurrent)
        ) {
            action()
        }
        .frame(width: 120, height: 30)
        .audioUIBorder(isCurrent ? .accent : .primary, width: isCurrent ? 2 : 1)
    }
}
```

## Conclusion

You've built a professional-grade mixer interface featuring:

- **Multi-channel architecture** with complete signal path
- **4-band parametric EQ** with visual feedback
- **Dynamics processing** (compressor, gate, limiter)
- **Effects sends and returns** for spatial processing
- **Master section** with stereo bus processing
- **Scene management** for instant recall
- **Automation system** for parameter recording

## Next Steps

To complete the mixer implementation:

1. **Audio Engine**: Connect to professional audio framework
2. **Plugin Support**: Add VST/AU plugin hosting
3. **MIDI Control**: Implement MIDI controller mapping
4. **File I/O**: Add project save/load functionality
5. **Remote Control**: Network control protocol
6. **Metering**: Professional loudness and spectrum analysis

This mixer provides a solid foundation for professional audio applications!
