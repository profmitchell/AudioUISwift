# Metal Effects

Leverage GPU acceleration to create stunning real-time visual effects for advanced audio applications using AudioUI's Metal-powered rendering system.

## Overview

AudioUIMetalFX provides GPU-accelerated visual effects that respond to audio in real-time. These effects use Apple's Metal framework to achieve smooth 60fps+ rendering while maintaining low CPU usage, essential for professional audio applications.

## Core Metal Effects

### Spectrum Analyzer

Real-time frequency domain visualization with customizable appearance:

```swift
import AudioUI
import AudioUIMetalFX

struct SpectrumAnalyzer: View {
    @StateObject private var audioEngine = AudioEngine()
    
    var body: some View {
        SpectrumVisualizer(
            fftData: audioEngine.fftBuffer,
            barCount: 64,
            style: .bars
        )
        .frame(height: 200)
        .onAppear {
            audioEngine.startAnalysis()
        }
    }
}
```

**Configuration Options:**
```swift
SpectrumVisualizer(
    fftData: audioEngine.fftBuffer,
    barCount: 32,                    // Number of frequency bars
    style: .bars,                    // .bars, .line, .filled
    colorScheme: .spectrum,          // Color mapping
    smoothing: 0.8,                  // Temporal smoothing
    logScale: true,                  // Logarithmic frequency scale
    peakHold: true,                  // Peak indicators
    falloffRate: 0.95               // Peak decay rate
)
```

### Waveform Display

Real-time time domain visualization:

```swift
struct WaveformDisplay: View {
    @StateObject private var audioEngine = AudioEngine()
    
    var body: some View {
        WaveformVisualizer(
            audioBuffer: audioEngine.timeBuffer,
            style: .oscilloscope
        )
        .frame(height: 150)
        .background(Color.black)
    }
}
```

**Waveform Styles:**
- `.oscilloscope`: Classic oscilloscope display
- `.filled`: Filled waveform with gradient
- `.mirrored`: Symmetric waveform display
- `.stereo`: Dual-channel visualization

### Level Meter Array

GPU-accelerated multi-channel level display:

```swift
struct MultiChannelMeters: View {
    let channelCount: Int = 32
    @StateObject private var mixer = AudioMixer()
    
    var body: some View {
        MetalLevelMeterArray(
            levels: mixer.channelLevels,
            peaks: mixer.channelPeaks,
            orientation: .vertical
        )
        .frame(width: 400, height: 200)
    }
}
```

### Particle Effects

Audio-reactive particle systems:

```swift
struct AudioParticles: View {
    @StateObject private var audioEngine = AudioEngine()
    
    var body: some View {
        ParticleSystemView(
            intensity: audioEngine.overallLevel,
            frequency: audioEngine.dominantFrequency,
            style: .fireflies
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
}
```

## Advanced Effects

### Spectrogram

Time-frequency analysis with scrolling display:

```swift
struct SpectrogramView: View {
    @StateObject private var audioEngine = AudioEngine()
    
    var body: some View {
        MetalSpectrogram(
            fftData: audioEngine.fftBuffer,
            bufferSize: 1024,
            colorMap: .jet,
            scrollDirection: .leftToRight
        )
        .frame(width: 400, height: 300)
    }
}
```

### 3D Spectrum

Three-dimensional frequency visualization:

```swift
struct Spectrum3D: View {
    @StateObject private var audioEngine = AudioEngine()
    @State private var rotationAngle: Float = 0
    
    var body: some View {
        Metal3DSpectrum(
            fftData: audioEngine.fftBuffer,
            rotation: rotationAngle,
            perspective: 0.5,
            depth: 2.0
        )
        .frame(width: 300, height: 300)
        .gesture(
            DragGesture()
                .onChanged { value in
                    rotationAngle = Float(value.translation.x * 0.01)
                }
        )
    }
}
```

### Vectorscope

Stereo field visualization:

```swift
struct Vectorscope: View {
    @StateObject private var audioEngine = AudioEngine()
    
    var body: some View {
        MetalVectorscope(
            leftChannel: audioEngine.leftBuffer,
            rightChannel: audioEngine.rightBuffer,
            persistence: 0.9,
            dotSize: 2.0
        )
        .frame(width: 200, height: 200)
        .clipShape(Circle())
    }
}
```

## Custom Metal Effects

### Creating Custom Shaders

Build your own audio-reactive effects:

```swift
struct CustomAudioVisualizer: View {
    @StateObject private var audioEngine = AudioEngine()
    
    var body: some View {
        MetalView(
            shader: "custom_audio_shader",
            uniforms: [
                "time": CACurrentMediaTime(),
                "audioLevel": audioEngine.overallLevel,
                "bassLevel": audioEngine.bassLevel,
                "midLevel": audioEngine.midLevel,
                "trebleLevel": audioEngine.trebleLevel
            ]
        )
        .frame(width: 300, height: 300)
    }
}
```

**Custom Metal Shader Example:**
```metal
#include <metal_stdlib>
using namespace metal;

struct VertexOut {
    float4 position [[position]];
    float2 texCoord;
};

fragment float4 custom_audio_shader(
    VertexOut in [[stage_in]],
    constant float &time [[buffer(0)]],
    constant float &audioLevel [[buffer(1)]],
    constant float &bassLevel [[buffer(2)]],
    constant float &midLevel [[buffer(3)]],
    constant float &trebleLevel [[buffer(4)]]
) {
    float2 uv = in.texCoord;
    
    // Create audio-reactive waves
    float wave1 = sin(uv.x * 10.0 + time * 2.0) * audioLevel;
    float wave2 = sin(uv.y * 8.0 + time * 1.5) * bassLevel;
    
    // Combine frequency bands
    float3 color = float3(
        trebleLevel * (0.5 + 0.5 * sin(uv.x * 20.0 + time)),
        midLevel * (0.5 + 0.5 * sin(uv.y * 15.0 + time * 0.8)),
        bassLevel * (0.5 + 0.5 * sin((uv.x + uv.y) * 10.0 + time * 0.6))
    );
    
    // Apply wave distortion
    color *= (1.0 + wave1 + wave2) * 0.5;
    
    return float4(color, 1.0);
}
```

### Shader Uniforms

Pass real-time audio data to Metal shaders:

```swift
class AudioToShaderBridge: ObservableObject {
    @Published var uniforms: [String: Float] = [:]
    private var audioEngine: AudioEngine
    
    init(audioEngine: AudioEngine) {
        self.audioEngine = audioEngine
        startUpdating()
    }
    
    private func startUpdating() {
        Timer.scheduledTimer(withTimeInterval: 1/60) { _ in
            self.updateUniforms()
        }
    }
    
    private func updateUniforms() {
        uniforms = [
            "time": Float(CACurrentMediaTime()),
            "overallLevel": audioEngine.overallLevel,
            "bassLevel": audioEngine.bassLevel,
            "midLevel": audioEngine.midLevel,
            "trebleLevel": audioEngine.trebleLevel,
            "kick": audioEngine.kickLevel,
            "snare": audioEngine.snareLevel,
            "hihat": audioEngine.hihatLevel
        ]
    }
}
```

## Performance Optimization

### GPU Memory Management

Efficient use of Metal resources:

```swift
class MetalEffectManager {
    private var device: MTLDevice
    private var commandQueue: MTLCommandQueue
    private var textureCache: [String: MTLTexture] = [:]
    
    init() {
        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("Metal not supported")
        }
        self.device = device
        self.commandQueue = device.makeCommandQueue()!
    }
    
    func cachedTexture(for key: String, size: CGSize) -> MTLTexture {
        if let cached = textureCache[key] {
            return cached
        }
        
        let descriptor = MTLTextureDescriptor.texture2DDescriptor(
            pixelFormat: .rgba8Unorm,
            width: Int(size.width),
            height: Int(size.height),
            mipmapped: false
        )
        descriptor.usage = [.shaderRead, .renderTarget]
        
        let texture = device.makeTexture(descriptor: descriptor)!
        textureCache[key] = texture
        return texture
    }
}
```

### Render Pipeline Optimization

Reduce GPU overhead with efficient pipelines:

```swift
class OptimizedAudioVisualizer {
    private var renderPipelineState: MTLRenderPipelineState?
    private var vertexBuffer: MTLBuffer?
    
    func setupOptimizedPipeline() {
        // Create vertex buffer once
        let vertices: [Float] = [
            -1, -1, 0, 1,  // Bottom left
             1, -1, 1, 1,  // Bottom right
            -1,  1, 0, 0,  // Top left
             1,  1, 1, 0   // Top right
        ]
        
        vertexBuffer = device.makeBuffer(
            bytes: vertices,
            length: vertices.count * MemoryLayout<Float>.size,
            options: []
        )
        
        // Setup render pipeline
        let descriptor = MTLRenderPipelineDescriptor()
        descriptor.vertexFunction = library.makeFunction(name: "vertex_main")
        descriptor.fragmentFunction = library.makeFunction(name: "fragment_main")
        descriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        renderPipelineState = try! device.makeRenderPipelineState(descriptor: descriptor)
    }
}
```

## Integration Patterns

### Combining with AudioUI Components

Integrate Metal effects with standard AudioUI components:

```swift
struct ProfessionalAnalyzer: View {
    @StateObject private var audioEngine = AudioEngine()
    @State private var selectedBand: Int = 0
    
    var body: some View {
        VStack {
            // Spectrum analyzer with Metal rendering
            SpectrumVisualizer(
                fftData: audioEngine.fftBuffer,
                selectedBand: selectedBand
            )
            .frame(height: 200)
            
            // AudioUI controls below
            HStack {
                ForEach(0..<8) { band in
                    VStack {
                        InsetNeumorphicKnob(
                            value: $audioEngine.bandGains[band],
                            label: "\(bandFrequencies[band])Hz"
                        )
                        .frame(width: 40, height: 40)
                        .highlighted(selectedBand == band)
                        .onTapGesture {
                            selectedBand = band
                        }
                    }
                }
            }
        }
    }
}
```

### Real-Time Response

Ensure effects respond immediately to audio changes:

```swift
class RealTimeEffectController: ObservableObject {
    @Published var effectIntensity: Float = 0
    private var audioEngine: AudioEngine
    private var displayLink: CADisplayLink?
    
    init(audioEngine: AudioEngine) {
        self.audioEngine = audioEngine
        startDisplayLink()
    }
    
    private func startDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink?.add(to: .main, forMode: .common)
    }
    
    @objc private func update() {
        // Update at screen refresh rate
        let newIntensity = audioEngine.calculateEffectIntensity()
        
        // Smooth the value to prevent jitter
        effectIntensity = effectIntensity * 0.9 + newIntensity * 0.1
    }
}
```

## Accessibility Considerations

### Alternative Representations

Provide non-visual alternatives for audio information:

```swift
struct AccessibleSpectrumView: View {
    @StateObject private var audioEngine = AudioEngine()
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    
    var body: some View {
        Group {
            if reduceMotion {
                // Static representation
                HStack {
                    ForEach(audioEngine.frequencyBands.indices, id: \.self) { index in
                        Rectangle()
                            .fill(Color.blue)
                            .frame(
                                width: 20,
                                height: CGFloat(audioEngine.frequencyBands[index]) * 100
                            )
                    }
                }
            } else {
                // Full Metal effects
                SpectrumVisualizer(fftData: audioEngine.fftBuffer)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Audio spectrum")
        .accessibilityValue(audioEngine.accessibilityDescription)
    }
}
```

Metal effects in AudioUI provide the visual polish and real-time responsiveness that distinguish professional audio applications from basic tools, while maintaining the performance required for professional audio work.

## Topics

### Core Effects
- ``SpectrumVisualizer``
- ``WaveformVisualizer``
- ``MetalLevelMeterArray``
- ``ParticleSystemView``

### Advanced Visualizations
- ``MetalSpectrogram``
- ``Metal3DSpectrum``
- ``MetalVectorscope``

### Custom Development
- Custom Metal shaders
- Performance optimization
- Real-time integration
- Accessibility support
