# ``AudioUI``

The ultimate SwiftUI framework for professional audio interface development.

## Overview

AudioUI is a comprehensive, production-ready framework that empowers developers to create stunning audio applications with professional-grade components and intuitive interactions. Built from the ground up for SwiftUI, it combines hardware-inspired design, advanced theming capabilities, and Metal-accelerated graphics into a unified development experience.

Whether you're building a DAW, synthesizer, mixer, effects processor, or any audio application that demands precision and real-time interaction, AudioUI provides the components, patterns, and performance you need to create exceptional user experiences.

### What Makes AudioUI Special

- **50+ Professional Components**: From velocity-sensitive drum pads to precision knobs and XY controllers
- **Dual Design Philosophies**: Choose between Minimal and Neumorphic aesthetics for any component
- **Real-Time Performance**: Optimized for 60fps interactions with Metal GPU acceleration
- **Complete Theming System**: Flexible Looks & Feels with pre-built themes and full customization
- **Cross-Platform**: Native support for iOS, macOS, watchOS, and tvOS
- **Production-Ready**: Used in shipping applications with comprehensive testing

## Topics

### Getting Started

- <doc:GettingStarted>
- <doc:FirstAudioInterface>
- <doc:DesignPhilosophies>
- <doc:DesignPrinciples>

### Framework Architecture

- <doc:AudioUICore>
- <doc:AudioUITheme>
- <doc:AudioUIComponents>
- <doc:AudioUIMetalFX>

### Component Library

- <doc:Buttons>
- <doc:Knobs>
- <doc:Sliders>
- <doc:DrumPads>
- <doc:XYPads>
- <doc:MotionControls>
- <doc:Displays>
- <doc:GroupComponents>

### Theming & Customization

- <doc:ThemingGuide>
- <doc:LooksAndFeels>
- <doc:CustomThemes>
- <doc:BuiltInThemes>

### Performance & Platform

- <doc:PerformanceOptimization>
- <doc:MetalEffects>
- <doc:RealTimeAudio>
- <doc:CrossPlatformConsiderations>

### Complete Tutorials

- <doc:SynthesizerTutorial>
- <doc:DrumMachineTutorial>
- <doc:MixerTutorial>
- <doc:MotionControlTutorial>

### API Reference

- ``AudioUICore``
- ``AudioUITheme``
- ``AudioUIComponents``
- ``AudioUIMetalFX``

## Key Features

### 🎛️ Professional Audio Controls
50+ components including velocity-sensitive drum pads, precision knobs, XY controllers, and professional faders - all designed with authentic hardware inspiration and haptic feedback.

### 🎨 Dual Design Philosophies
Every component available in both **Minimal** (clean, geometric) and **Neumorphic** (soft, tactile) styles. Mix and match or choose one philosophy for consistent design language.

### ⚡ Real-Time Performance
Optimized for 60fps interactions with Metal GPU acceleration. Complex visual effects, real-time parameter updates, and smooth animations even on older devices.

### 🧩 Modular Architecture
Use individual modules (Core, Theme, Components, MetalFX) or the complete framework. Perfect for both learning individual concepts and shipping production apps.

### 📱 True Multi-Platform
Native support for iOS, macOS, watchOS, and tvOS with platform-optimized interactions, gestures, and layouts. One codebase, all Apple platforms.

### 🎵 Production-Ready Components
Each component includes velocity sensitivity, parameter mapping, MIDI support, accessibility features, and comprehensive customization options.

### 📚 Learning-Focused Documentation
Extensive documentation with tutorials, examples, and clear architectural patterns. Learn both basic usage and advanced customization techniques.

## Quick Start

Get up and running with AudioUI in minutes:

```swift
import SwiftUI
import AudioUI
import AudioUITheme

struct MyFirstAudioInterface: View {
    @State private var volume: Double = 0.5
    @State private var frequency: Double = 440.0
    @State private var position = CGPoint(x: 0.5, y: 0.5)
    
    var body: some View {
        VStack(spacing: 40) {
            // Professional neumorphic knob
            InsetNeumorphicKnob(value: $volume)
                .frame(width: 120, height: 120)
            
            // Clean minimal fader
            VerticalInsetSlider(value: Binding(
                get: { frequency / 2000.0 },
                set: { frequency = $0 * 2000.0 }
            ))
            .frame(height: 200)
            
            // XY controller for complex parameters
            XYPadMinimal1(position: $position)
                .frame(width: 300, height: 300)
        }
        .theme(.audioUINeumorphic)
        .padding()
    }
}
```

### Installation

Add AudioUI to your Package.swift or through Xcode:

```swift
dependencies: [
    .package(url: "https://github.com/your-org/AudioUI", from: "1.0.0")
]
```

### Choose Your Design Philosophy

AudioUI components come in two flavors:

```swift
// Minimal: Clean, geometric, high-contrast
VerticalInsetSlider(value: $value)
    .theme(.audioUIMinimal)

// Neumorphic: Soft, tactile, depth-based
InsetNeumorphicKnob(value: $value)
    .theme(.audioUINeumorphic)
```

## Design Philosophies

AudioUI embraces two distinct design approaches, allowing you to choose the aesthetic that best fits your application:

### Minimal Philosophy
- **Clean geometric shapes** with precise lines and high contrast
- **Functional aesthetics** prioritizing clarity and immediate recognition
- **Professional appearance** perfect for DAWs, broadcast tools, and clinical applications
- **Examples**: Logic Pro X, Pro Tools, professional broadcast equipment

### Neumorphic Philosophy  
- **Soft, tactile surfaces** with realistic depth and shadow
- **Physical metaphors** that feel like real hardware controls
- **Immersive experience** ideal for creative apps and virtual instruments
- **Examples**: Hardware synthesizers, boutique audio gear, creative music apps

### Mix and Match
You can combine both philosophies in the same interface:

```swift
VStack {
    // Neumorphic for creative controls
    InsetNeumorphicKnob(value: $creativity)
    
    // Minimal for precise technical controls  
    VerticalInsetSlider(value: $precision)
}
```

Each component is available in both styles, teaching you how the same functionality can express completely different design languages while maintaining consistent behavior and accessibility.

## Platform Requirements

- **iOS**: 15.0+ (iOS 18.0+ for latest features)
- **macOS**: 12.0+ (macOS 15.0+ for latest features)  
- **watchOS**: 8.0+
- **tvOS**: 15.0+
- **Swift**: 5.9+
- **Xcode**: 15.0+

## What's New in 2025

- **Enhanced Metal Effects**: GPU-accelerated visual effects for all components
- **Improved Accessibility**: VoiceOver, Voice Control, and Switch Control support
- **Advanced Theming**: New Look & Feel customization options
- **Performance Optimizations**: 60fps guaranteed even on older devices
- **Expanded Component Library**: New motion controls, advanced displays, and professional mixers
