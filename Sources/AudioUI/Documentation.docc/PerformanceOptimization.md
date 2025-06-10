# Performance Optimization

Advanced techniques and best practices for building high-performance audio interfaces with AudioUI that maintain smooth 60fps rendering and minimal CPU usage.

## Overview

Audio applications demand exceptional performance. Users expect interfaces that respond immediately to gestures while background audio processing continues uninterrupted. AudioUI provides several optimization strategies to achieve professional-level performance.

## Core Optimization Principles

### Frame Rate Targets

AudioUI components are designed to maintain consistent frame rates:

- **60 FPS**: Standard target for smooth UI interactions
- **120 FPS**: ProMotion displays and high-refresh screens  
- **Real-time**: Sub-frame timing for critical audio controls

### Memory Management

Efficient memory usage prevents audio dropouts:

```swift
import AudioUI

class OptimizedAudioInterface: ObservableObject {
    // Use @StateObject for expensive objects
    @StateObject private var audioEngine = AudioEngine()
    
    // Reuse views instead of creating new ones
    private let knobPool = ComponentPool<InsetNeumorphicKnob>(capacity: 32)
    private let meterPool = ComponentPool<ThemedLevelMeter>(capacity: 16)
    
    // Cache expensive calculations
    private var cachedSpectrumData: [Float] = []
    private var spectrumUpdateTimer: Timer?
    
    func optimizedSetup() {
        // Batch updates to reduce redraws
        DispatchQueue.main.async {
            self.updateAllControls()
        }
        
        // Use dedicated timer for real-time updates
        spectrumUpdateTimer = Timer.scheduledTimer(withTimeInterval: 1/60) { _ in
            self.updateSpectrum()
        }
    }
}
```

## Component-Level Optimizations

### Efficient Level Meters

Level meters update frequently and need careful optimization:

```swift
struct OptimizedLevelMeter: View {
    let level: Double
    let peak: Double
    
    // Cache drawing data
    @State private var segments: [SegmentData] = []
    @State private var lastUpdateTime: CFAbsoluteTime = 0
    
    var body: some View {
        Canvas { context, size in
            // Only redraw if values changed significantly
            let currentTime = CFAbsoluteTimeGetCurrent()
            guard currentTime - lastUpdateTime > 1/120 else { return }
            
            drawOptimizedMeter(context: context, size: size)
            lastUpdateTime = currentTime
        }
        .drawingGroup() // Composite into single layer
        .onChange(of: level) { newLevel in
            updateSegments(level: newLevel, peak: peak)
        }
    }
    
    private func drawOptimizedMeter(context: GraphicsContext, size: CGSize) {
        // Use pre-calculated segment data
        for segment in segments {
            context.fill(
                Path(roundedRect: segment.rect, cornerRadius: 1),
                with: .color(segment.color)
            )
        }
    }
    
    private func updateSegments(level: Double, peak: Double) {
        // Batch calculate all segments at once
        segments = SegmentCalculator.calculate(
            level: level,
            peak: peak,
            size: bounds.size
        )
    }
}
```

### Knob Optimization

Reduce knob rendering overhead during rotation:

```swift
struct HighPerformanceKnob: View {
    @Binding var value: Double
    
    // Pre-render static elements
    @State private var staticBackground: Image?
    @State private var rotationAngle: Angle = .zero
    
    var body: some View {
        ZStack {
            // Static background (rendered once)
            if let background = staticBackground {
                background
            } else {
                KnobBackground()
                    .onAppear {
                        staticBackground = renderStaticBackground()
                    }
            }
            
            // Only the thumb rotates
            KnobThumb()
                .rotationEffect(rotationAngle)
                .animation(.easeOut(duration: 0.05), value: rotationAngle)
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { gesture in
                    // Direct angle calculation without intermediate updates
                    let angle = calculateAngle(from: gesture.location)
                    updateValue(from: angle)
                }
        )
        .onChange(of: value) { newValue in
            rotationAngle = angleForValue(newValue)
        }
    }
    
    private func renderStaticBackground() -> Image {
        // Render background to bitmap once
        let renderer = ImageRenderer(content: KnobBackground())
        renderer.scale = UIScreen.main.scale
        return Image(uiImage: renderer.uiImage ?? UIImage())
    }
}
```

## Batch Updates and Timing

### Efficient Multi-Channel Updates

When updating many components simultaneously:

```swift
class MixingConsoleManager: ObservableObject {
    @Published var channels: [ChannelData] = []
    
    private var updateTimer: CADisplayLink?
    private var pendingUpdates: Set<Int> = []
    
    func startRealTimeUpdates() {
        updateTimer = CADisplayLink(target: self, selector: #selector(updateChannels))
        updateTimer?.add(to: .main, forMode: .common)
    }
    
    @objc private func updateChannels() {
        // Batch all updates into single UI refresh
        guard !pendingUpdates.isEmpty else { return }
        
        let updatedChannels = channels
        for channelIndex in pendingUpdates {
            if channelIndex < updatedChannels.count {
                updatedChannels[channelIndex] = getLatestChannelData(channelIndex)
            }
        }
        
        // Single update triggers all UI changes
        channels = updatedChannels
        pendingUpdates.removeAll()
    }
    
    func markChannelForUpdate(_ index: Int) {
        pendingUpdates.insert(index)
    }
}
```

### Smart Update Scheduling

Prioritize updates based on user interaction:

```swift
class SmartUpdateScheduler {
    private var highPriorityComponents: Set<ComponentID> = []
    private var normalPriorityComponents: Set<ComponentID> = []
    
    func scheduleUpdate(for component: ComponentID, priority: UpdatePriority) {
        switch priority {
        case .high:
            highPriorityComponents.insert(component)
            scheduleImmediate()
        case .normal:
            normalPriorityComponents.insert(component)
            scheduleNextFrame()
        case .low:
            scheduleWhenIdle()
        }
    }
    
    private func scheduleImmediate() {
        DispatchQueue.main.async {
            self.processHighPriorityUpdates()
        }
    }
    
    private func scheduleNextFrame() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1/60) {
            self.processNormalPriorityUpdates()
        }
    }
}
```

## Memory and Resource Management

### Component Pooling

Reuse expensive components instead of creating new ones:

```swift
class ComponentPool<T: AudioUIComponent> {
    private var available: [T] = []
    private var inUse: [T] = []
    private let factory: () -> T
    
    init(capacity: Int, factory: @escaping () -> T) {
        self.factory = factory
        for _ in 0..<capacity {
            available.append(factory())
        }
    }
    
    func acquire() -> T {
        if let component = available.popLast() {
            inUse.append(component)
            return component
        } else {
            let component = factory()
            inUse.append(component)
            return component
        }
    }
    
    func release(_ component: T) {
        if let index = inUse.firstIndex(where: { $0.id == component.id }) {
            inUse.remove(at: index)
            component.reset()  // Clear state
            available.append(component)
        }
    }
}
```

### Texture Management

Efficient handling of visual resources:

```swift
class TextureManager {
    private static var shared = TextureManager()
    private var textureCache: [String: MTLTexture] = [:]
    
    func texture(for key: String, generator: () -> MTLTexture) -> MTLTexture {
        if let cached = textureCache[key] {
            return cached
        }
        
        let texture = generator()
        textureCache[key] = texture
        return texture
    }
    
    func preloadCommonTextures() {
        // Load frequently used textures at startup
        _ = texture(for: "knob_background") {
            generateKnobBackgroundTexture()
        }
        
        _ = texture(for: "button_gradient") {
            generateButtonGradientTexture()
        }
    }
    
    func clearUnusedTextures() {
        // Periodically clean up unused textures
        let now = Date()
        textureCache = textureCache.filter { key, texture in
            texture.lastAccessTime.timeIntervalSince(now) < 30.0
        }
    }
}
```

## Real-Time Audio Considerations

### Thread Safety

Ensure UI updates don't interfere with audio processing:

```swift
class AudioSafeUIUpdater {
    private let audioQueue = DispatchQueue(
        label: "audio.processing",
        qos: .userInteractive
    )
    
    private let uiQueue = DispatchQueue.main
    
    func updateMeterValue(_ value: Float, for meterID: String) {
        // Audio thread provides the value
        audioQueue.async {
            let processedValue = self.processMeterValue(value)
            
            // UI updates happen on main thread
            self.uiQueue.async {
                self.updateMeterDisplay(processedValue, for: meterID)
            }
        }
    }
    
    private func processMeterValue(_ value: Float) -> Float {
        // Smooth the value to prevent jitter
        return smoothingFilter.process(value)
    }
}
```

### Non-Blocking Updates

Prevent UI updates from blocking audio processing:

```swift
class NonBlockingMeterUpdater {
    private var latestValues: [String: Float] = [:]
    private var displayValues: [String: Float] = [:]
    private let updateLock = NSLock()
    
    func setValue(_ value: Float, for meterID: String) {
        // Non-blocking write from audio thread
        if updateLock.try() {
            latestValues[meterID] = value
            updateLock.unlock()
        }
        // If lock fails, skip this update (audio continues)
    }
    
    func updateDisplays() {
        // UI thread reads latest values
        updateLock.lock()
        let valuesToDisplay = latestValues
        latestValues.removeAll()
        updateLock.unlock()
        
        // Update UI with batched values
        for (meterID, value) in valuesToDisplay {
            updateMeterDisplay(value, for: meterID)
        }
    }
}
```

## Profiling and Debugging

### Performance Monitoring

Track performance metrics in real-time:

```swift
class PerformanceMonitor {
    private var frameTime: CFAbsoluteTime = 0
    private var updateCounts: [String: Int] = [:]
    
    func startFrameTimer() {
        frameTime = CFAbsoluteTimeGetCurrent()
    }
    
    func endFrameTimer() {
        let elapsed = CFAbsoluteTimeGetCurrent() - frameTime
        let fps = 1.0 / elapsed
        
        if fps < 55 { // Below 60fps threshold
            reportPerformanceIssue(fps: fps)
        }
    }
    
    func trackUpdate(for component: String) {
        updateCounts[component, default: 0] += 1
    }
    
    func generatePerformanceReport() -> PerformanceReport {
        return PerformanceReport(
            averageFPS: calculateAverageFPS(),
            updateFrequencies: updateCounts,
            memoryUsage: getCurrentMemoryUsage(),
            recommendations: generateOptimizationRecommendations()
        )
    }
}
```

### Optimization Tools

Built-in tools to identify performance bottlenecks:

```swift
extension View {
    func performanceProfiled(_ identifier: String) -> some View {
        self.background(
            PerformanceProfiler(identifier: identifier)
        )
    }
}

struct PerformanceProfiler: View {
    let identifier: String
    
    var body: some View {
        EmptyView()
            .onAppear {
                PerformanceMonitor.shared.startProfiling(identifier)
            }
            .onDisappear {
                PerformanceMonitor.shared.endProfiling(identifier)
            }
    }
}

// Usage
InsetNeumorphicKnob(value: $frequency)
    .performanceProfiled("FrequencyKnob")
```

## Best Practices Summary

### Do's
- Use `drawingGroup()` for complex visual compositions
- Cache expensive calculations and pre-render static content  
- Batch UI updates to minimize redraw cycles
- Profile regularly and optimize bottlenecks
- Use component pooling for frequently created/destroyed views
- Implement proper thread separation between audio and UI

### Don'ts
- Don't update UI from audio processing threads
- Avoid creating new views on every frame
- Don't perform expensive calculations in view bodies
- Avoid unnecessary precision in animations and updates
- Don't block the main thread with heavy computations
- Avoid memory allocations in real-time update paths

### Performance Targets
- **UI Responsiveness**: < 16ms frame time (60 FPS)
- **Memory Usage**: < 100MB for typical interfaces
- **CPU Usage**: < 10% for UI rendering (leaving 90% for audio)
- **Battery Life**: Minimal impact on device battery consumption

Professional audio applications built with AudioUI achieve smooth, responsive interfaces that never interfere with audio processing, providing users with the reliable performance they expect from professional tools.

## Topics

### Optimization Strategies
- Component pooling
- Batch updates
- Memory management
- Resource caching

### Real-Time Considerations
- Thread safety
- Non-blocking updates
- Audio-safe UI patterns
- Performance monitoring

### Profiling Tools
- Performance metrics
- Optimization recommendations
- Bottleneck identification
- Memory usage tracking
