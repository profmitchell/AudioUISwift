# AudioUIMetalFX

GPU-accelerated visual effects and real-time graphics processing for audio interfaces.

## Overview

AudioUIMetalFX provides advanced visual effects using Metal Performance Shaders and custom GPU kernels. This module enables sophisticated real-time visualizations, particle systems, and effects that would be impossible with CPU-only rendering, all while maintaining 60fps performance.

Perfect for spectrum analyzers, waveform displays, particle-based VU meters, and immersive audio visualizations.

## Topics

### Core Effects System

- GPU-accelerated spectrum analysis
- Real-time waveform rendering
- Particle-based VU meters
- Custom shader integration

### Performance Optimization

- <doc:MetalEffects>
- <doc:PerformanceOptimization>
- GPU memory management
- Frame synchronization

### Integration Patterns

- SwiftUI view integration
- Audio data binding
- Multi-platform support
- Accessibility considerations

## Key Features

### 🚀 GPU Acceleration
All effects run on the GPU for maximum performance:
- Metal Performance Shaders integration
- Custom compute kernels
- Parallel processing
- Zero CPU overhead for rendering

### 📊 Real-Time Audio Visualization
Visualize audio data as it happens:
- FFT spectrum analysis at 60fps
- Waveform rendering with sample accuracy
- Dynamic range compression visualization
- Multi-channel audio support

### 🎨 Artistic Effects
Beautiful visual effects for creative applications:
- Particle systems with physics
- Procedural textures and patterns
- Bloom and glow effects
- Color grading and filters

### ⚡ Optimized Performance
Designed for real-time audio applications:
- Sub-millisecond latency
- Predictable frame timing
- Minimal memory allocations
- Efficient GPU memory usage

## Architecture

### Effect Pipeline

```
Audio Data → GPU Upload → Processing → Rendering → Display
     ↓            ↓           ↓          ↓         ↓
  Float32     Metal Buffer  Compute    Fragment   SwiftUI
  Arrays       Upload       Shaders    Shaders    View
```

### Core Components

#### SpectrumAnalyzer
Real-time FFT visualization with customizable frequency response:

```swift
import SwiftUI
import AudioUIMetalFX

struct SpectrumView: View {
    @StateObject private var analyzer = SpectrumAnalyzer()
    
    var body: some View {
        SpectrumAnalyzerView(analyzer: analyzer)
            .frame(height: 200)
            .onReceive(audioEngine.audioDataPublisher) { audioData in
                analyzer.processAudioData(audioData)
            }
    }
}
```

#### WaveformRenderer
High-performance waveform display with zoom and scrolling:

```swift
struct WaveformView: View {
    @StateObject private var renderer = WaveformRenderer()
    @State private var audioBuffer: AudioBuffer?
    
    var body: some View {
        WaveformDisplayView(renderer: renderer, buffer: audioBuffer)
            .gesture(
                MagnificationGesture()
                    .onChanged { scale in
                        renderer.setZoom(scale)
                    }
            )
    }
}
```

#### ParticleVUMeter
Physics-based VU meter with particle effects:

```swift
struct ParticleVU: View {
    @StateObject private var vuMeter = ParticleVUMeter()
    @State private var level: Float = 0.0
    
    var body: some View {
        ParticleVUMeterView(
            vuMeter: vuMeter,
            level: level,
            particleCount: 200,
            physics: .bounce
        )
        .frame(width: 300, height: 100)
    }
}
```

## Effect Types

### Spectrum Analysis Effects

#### Real-Time FFT Display
```swift
SpectrumAnalyzerView(
    analyzer: analyzer,
    frequencyRange: 20...20000,
    amplitudeRange: -60...0,
    colorScheme: .rainbow,
    barStyle: .gradient
)
```

#### Waterfall Display
```swift
WaterfallSpectrumView(
    analyzer: analyzer,
    timeDepth: 5.0, // 5 seconds of history
    colorMapping: .thermal
)
```

### Waveform Effects

#### Oscilloscope Display
```swift
OscilloscopeView(
    renderer: renderer,
    timebase: .milliseconds(10),
    triggerLevel: 0.1,
    channels: [.left, .right]
)
```

#### Vectorscope (Lissajous)
```swift
VectorscopeView(
    renderer: renderer,
    persistence: 0.95,
    trailLength: 100
)
```

### Particle Effects

#### Level-Responsive Particles
```swift
ParticleSystemView(
    particleCount: 500,
    emissionRate: { audioLevel * 100 },
    physics: ParticlePhysics(
        gravity: CGVector(dx: 0, dy: -0.5),
        damping: 0.98,
        collision: .bounce
    )
)
```

#### Frequency-Driven Animation
```swift
FrequencyParticleView(
    spectrumData: analyzer.frequencyBins,
    particlesPerBin: 10,
    colorMapping: .frequency
)
```

## Performance Characteristics

### GPU Memory Usage
- **Spectrum Analyzer**: ~2MB VRAM
- **Waveform Display**: ~4MB VRAM (depending on resolution)
- **Particle System**: ~1MB per 1000 particles

### Frame Rate Targets
- **60fps**: Standard target for smooth interaction
- **120fps**: Available on ProMotion displays
- **Variable refresh**: Adapts to display capabilities

### Audio Latency
- **Analysis**: <1ms from audio input to GPU processing
- **Rendering**: <16ms from analysis to display
- **Total**: <20ms end-to-end latency

## Integration Examples

### Professional Spectrum Analyzer

```swift
struct ProfessionalSpectrumAnalyzer: View {
    @StateObject private var analyzer = SpectrumAnalyzer(
        fftSize: 2048,
        windowFunction: .hann,
        overlapFactor: 0.5
    )
    
    @State private var frequencyRange: ClosedRange<Double> = 20...20000
    @State private var amplitudeRange: ClosedRange<Double> = -80...0
    
    var body: some View {
        VStack {
            // Main spectrum display
            SpectrumAnalyzerView(
                analyzer: analyzer,
                frequencyRange: frequencyRange,
                amplitudeRange: amplitudeRange,
                style: .logarithmic,
                colorScheme: .professional
            )
            .frame(height: 300)
            
            // Controls
            HStack {
                VStack {
                    Text("Freq Range")
                    RangeSlider(range: $frequencyRange, bounds: 1...22050)
                }
                
                VStack {
                    Text("Amp Range")
                    RangeSlider(range: $amplitudeRange, bounds: -120...10)
                }
            }
            .padding()
        }
        .onReceive(AudioEngine.shared.audioDataPublisher) { data in
            analyzer.processAudioData(data)
        }
    }
}
```

### Creative Waveform Visualizer

```swift
struct CreativeWaveformVisualizer: View {
    @StateObject private var renderer = WaveformRenderer()
    @State private var effectStyle: WaveformStyle = .neon
    @State private var colorMode: ColorMode = .rainbow
    
    var body: some View {
        ZStack {
            // Background effects
            WaveformBackgroundEffectView(
                renderer: renderer,
                style: .particles,
                intensity: 0.3
            )
            
            // Main waveform
            WaveformDisplayView(
                renderer: renderer,
                style: effectStyle,
                colorMode: colorMode,
                thickness: 2.0,
                glow: true
            )
            
            // Overlay effects
            WaveformOverlayEffectView(
                renderer: renderer,
                style: .bloom,
                intensity: 0.7
            )
        }
        .background(Color.black)
    }
}
```

### Multi-Channel VU Array

```swift
struct MultiChannelVUArray: View {
    @StateObject private var vuArray = MultiChannelVUMeter(channels: 8)
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<8) { channel in
                ParticleVUMeterView(
                    vuMeter: vuArray.vuMeters[channel],
                    level: vuArray.levels[channel],
                    style: .digital,
                    orientation: .vertical
                )
                .frame(width: 40, height: 200)
            }
        }
        .onReceive(AudioEngine.shared.multiChannelPublisher) { levels in
            vuArray.updateLevels(levels)
        }
    }
}
```

## Custom Shader Integration

### Creating Custom Effects

You can create custom Metal shaders for unique visualizations:

```swift
import MetalKit

class CustomAudioEffect: AudioUIEffect {
    private var computePipelineState: MTLComputePipelineState?
    
    func setupShaders(device: MTLDevice) {
        let library = device.makeDefaultLibrary()
        let function = library?.makeFunction(name: "audioWaveDistortion")
        
        do {
            computePipelineState = try device.makeComputePipelineState(function: function!)
        } catch {
            print("Failed to create pipeline state: \(error)")
        }
    }
    
    func processAudioVisualization(
        commandBuffer: MTLCommandBuffer,
        audioData: MTLBuffer,
        outputTexture: MTLTexture
    ) {
        guard let pipelineState = computePipelineState else { return }
        
        let computeEncoder = commandBuffer.makeComputeCommandEncoder()!
        computeEncoder.setComputePipelineState(pipelineState)
        computeEncoder.setBuffer(audioData, offset: 0, index: 0)
        computeEncoder.setTexture(outputTexture, index: 0)
        
        let threadgroupSize = MTLSize(width: 16, height: 16, depth: 1)
        let threadgroups = MTLSize(
            width: (outputTexture.width + 15) / 16,
            height: (outputTexture.height + 15) / 16,
            depth: 1
        )
        
        computeEncoder.dispatchThreadgroups(threadgroups, threadsPerThreadgroup: threadgroupSize)
        computeEncoder.endEncoding()
    }
}
```

## Platform Support

### iOS/iPadOS
- Full Metal support on A7+ devices
- Optimized for touch interaction
- Adaptive quality based on thermal state

### macOS
- Desktop-class GPU performance
- Multi-display support
- External GPU compatibility

### tvOS
- Optimized for 4K displays
- Focus engine integration
- Remote control interaction

## Best Practices

### Memory Management
```swift
// ✅ Good: Reuse Metal resources
@StateObject private var analyzer = SpectrumAnalyzer()

// ❌ Bad: Creating new resources each frame
// Don't create SpectrumAnalyzer() in body
```

### Performance Monitoring
```swift
struct PerformanceMonitor: View {
    @StateObject private var metrics = MetalPerformanceMetrics()
    
    var body: some View {
        VStack {
            Text("GPU Time: \(metrics.gpuTime, specifier: "%.2f")ms")
            Text("Memory: \(metrics.memoryUsage / 1024 / 1024)MB")
        }
    }
}
```

### Accessibility
```swift
SpectrumAnalyzerView(analyzer: analyzer)
    .accessibilityLabel("Audio spectrum analyzer")
    .accessibilityValue("Frequency response visualization")
    .accessibilityAddTraits(.updatesFrequently)
```

## See Also

- <doc:MetalEffects> - Advanced Metal programming patterns
- <doc:PerformanceOptimization> - Real-time optimization techniques
- <doc:AudioUIComponents> - Component integration patterns
- <doc:RealTimeAudio> - Audio processing considerations
