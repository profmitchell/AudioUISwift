# Real-Time Audio

Design AudioUI interfaces that respond seamlessly to live audio processing while maintaining professional performance standards.

## Overview

Real-time audio applications require interfaces that update smoothly without interfering with audio processing. AudioUI provides specialized patterns and components designed for the unique demands of real-time audio systems.

## Real-Time Requirements

### Timing Constraints

Audio processing operates under strict timing requirements:

- **Audio Buffer Size**: Typically 64-512 samples
- **Sample Rate**: 44.1kHz to 192kHz  
- **Latency Target**: < 10ms for live performance
- **UI Update Rate**: 60-120 FPS without audio dropouts

### Thread Separation

Critical separation between audio processing and UI updates:

```swift
import AudioUI
import AVFoundation

class RealTimeAudioEngine: ObservableObject {
    // Audio processing thread (high priority)
    private var audioQueue = DispatchQueue(
        label: "audio.processing",
        qos: .userInteractive,
        attributes: .concurrent
    )
    
    // UI update thread (main thread)
    @Published var currentLevel: Float = 0
    @Published var frequency: Float = 440
    @Published var isProcessing: Bool = false
    
    private var audioEngine: AVAudioEngine
    private var playerNode: AVAudioPlayerNode
    
    init() {
        audioEngine = AVAudioEngine()
        playerNode = AVAudioPlayerNode()
        setupAudioGraph()
        setupRealTimeUpdates()
    }
    
    private func setupRealTimeUpdates() {
        // Audio thread provides data
        audioQueue.async {
            while self.isProcessing {
                let level = self.calculateCurrentLevel()
                let freq = self.calculateDominantFrequency()
                
                // UI updates on main thread
                DispatchQueue.main.async {
                    self.currentLevel = level
                    self.frequency = freq
                }
                
                // Control update rate
                Thread.sleep(forTimeInterval: 1/60)
            }
        }
    }
}
```

## Lock-Free Communication

### Atomic Updates

Use atomic operations for thread-safe communication:

```swift
import Foundation

class AtomicFloat {
    private var _value: UnsafeMutablePointer<Float>
    
    init(_ value: Float = 0) {
        _value = UnsafeMutablePointer<Float>.allocate(capacity: 1)
        _value.initialize(to: value)
    }
    
    deinit {
        _value.deallocate()
    }
    
    var value: Float {
        get {
            return _value.pointee
        }
        set {
            _value.pointee = newValue
        }
    }
    
    func atomicLoad() -> Float {
        return OSAtomicAdd32(0, _value)
    }
    
    func atomicStore(_ value: Float) {
        OSAtomicCompareAndSwap32(_value.pointee, value, _value)
    }
}

class RealTimeMeter: ObservableObject {
    private let atomicLevel = AtomicFloat()
    @Published var displayLevel: Float = 0
    
    // Called from audio thread
    func updateFromAudioThread(_ level: Float) {
        atomicLevel.atomicStore(level)
    }
    
    // Called from UI thread
    func updateDisplay() {
        displayLevel = atomicLevel.atomicLoad()
    }
}
```

### Ring Buffers

Efficient data sharing between threads:

```swift
class RingBuffer<T> {
    private var buffer: [T]
    private var capacity: Int
    private var writeIndex: Int = 0
    private var readIndex: Int = 0
    private let lock = NSLock()
    
    init(capacity: Int, defaultValue: T) {
        self.capacity = capacity
        self.buffer = Array(repeating: defaultValue, count: capacity)
    }
    
    func write(_ value: T) -> Bool {
        lock.lock()
        defer { lock.unlock() }
        
        let nextWrite = (writeIndex + 1) % capacity
        if nextWrite == readIndex {
            return false // Buffer full
        }
        
        buffer[writeIndex] = value
        writeIndex = nextWrite
        return true
    }
    
    func read() -> T? {
        lock.lock()
        defer { lock.unlock() }
        
        if readIndex == writeIndex {
            return nil // Buffer empty
        }
        
        let value = buffer[readIndex]
        readIndex = (readIndex + 1) % capacity
        return value
    }
}

class AudioDataBridge: ObservableObject {
    private let levelBuffer = RingBuffer<Float>(capacity: 1024, defaultValue: 0)
    @Published var currentLevels: [Float] = []
    
    // Audio thread writes
    func pushLevel(_ level: Float) {
        _ = levelBuffer.write(level)
    }
    
    // UI thread reads
    func updateUI() {
        var levels: [Float] = []
        while let level = levelBuffer.read() {
            levels.append(level)
        }
        
        if !levels.isEmpty {
            currentLevels = levels
        }
    }
}
```

## Performance-Optimized Components

### Efficient Level Meters

Level meters optimized for real-time updates:

```swift
struct RealTimeLevelMeter: View {
    let level: Float
    let peak: Float
    
    // Cache drawing calculations
    @State private var segmentCount: Int = 20
    @State private var segmentHeight: CGFloat = 0
    @State private var segmentSpacing: CGFloat = 1
    
    var body: some View {
        GeometryReader { geometry in
            Canvas { context, size in
                updateSegmentCalculations(size: size)
                drawOptimizedMeter(context: context, size: size)
            }
            .drawingGroup() // Composite to single layer
        }
    }
    
    private func updateSegmentCalculations(size: CGSize) {
        segmentHeight = (size.height - CGFloat(segmentCount - 1) * segmentSpacing) / CGFloat(segmentCount)
    }
    
    private func drawOptimizedMeter(context: GraphicsContext, size: CGSize) {
        let activeSegments = Int(level * Float(segmentCount))
        let peakSegment = Int(peak * Float(segmentCount))
        
        for i in 0..<segmentCount {
            let y = size.height - CGFloat(i + 1) * (segmentHeight + segmentSpacing)
            let rect = CGRect(x: 0, y: y, width: size.width, height: segmentHeight)
            
            let color: Color
            if i < activeSegments {
                color = segmentColor(for: i, total: segmentCount)
            } else if i == peakSegment {
                color = .yellow
            } else {
                color = .gray.opacity(0.3)
            }
            
            context.fill(Path(roundedRect: rect, cornerRadius: 1), with: .color(color))
        }
    }
    
    private func segmentColor(for index: Int, total: Int) -> Color {
        let ratio = Float(index) / Float(total)
        if ratio < 0.7 {
            return .green
        } else if ratio < 0.9 {
            return .yellow
        } else {
            return .red
        }
    }
}
```

### Batch Update Manager

Coordinate multiple component updates efficiently:

```swift
class RealTimeUpdateManager: ObservableObject {
    @Published var meterLevels: [Float] = Array(repeating: 0, count: 32)
    @Published var knobValues: [Float] = Array(repeating: 0.5, count: 16)
    @Published var buttonStates: [Bool] = Array(repeating: false, count: 8)
    
    private var pendingUpdates: Set<UpdateType> = []
    private var updateTimer: Timer?
    
    enum UpdateType {
        case meters, knobs, buttons
    }
    
    init() {
        startBatchUpdates()
    }
    
    private func startBatchUpdates() {
        updateTimer = Timer.scheduledTimer(withTimeInterval: 1/60) { _ in
            self.processPendingUpdates()
        }
    }
    
    // Called from audio thread
    func scheduleUpdate(_ type: UpdateType) {
        DispatchQueue.main.async {
            self.pendingUpdates.insert(type)
        }
    }
    
    private func processPendingUpdates() {
        guard !pendingUpdates.isEmpty else { return }
        
        // Batch all updates into single UI refresh
        for updateType in pendingUpdates {
            switch updateType {
            case .meters:
                updateMeterLevels()
            case .knobs:
                updateKnobValues()
            case .buttons:
                updateButtonStates()
            }
        }
        
        pendingUpdates.removeAll()
    }
}
```

## Low-Latency Patterns

### Direct Hardware Access

For critical applications requiring minimal latency:

```swift
import CoreAudio
import AudioToolbox

class UltraLowLatencyEngine {
    private var audioUnit: AudioComponentInstance?
    private var sampleRate: Double = 44100
    private var bufferSize: UInt32 = 64
    
    private let uiUpdateCallback: (Float) -> Void
    
    init(uiUpdateCallback: @escaping (Float) -> Void) {
        self.uiUpdateCallback = uiUpdateCallback
        setupAudioUnit()
    }
    
    private func setupAudioUnit() {
        var description = AudioComponentDescription(
            componentType: kAudioUnitType_Output,
            componentSubType: kAudioUnitSubType_HALOutput,
            componentManufacturer: kAudioUnitManufacturer_Apple,
            componentFlags: 0,
            componentFlagsMask: 0
        )
        
        guard let component = AudioComponentFindNext(nil, &description) else {
            return
        }
        
        AudioComponentInstanceNew(component, &audioUnit)
        
        // Set render callback
        var callbackStruct = AURenderCallbackStruct(
            inputProc: audioRenderCallback,
            inputProcRefCon: UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque())
        )
        
        AudioUnitSetProperty(
            audioUnit!,
            kAudioUnitProperty_SetRenderCallback,
            kAudioUnitScope_Input,
            0,
            &callbackStruct,
            UInt32(MemoryLayout<AURenderCallbackStruct>.size)
        )
    }
    
    private let audioRenderCallback: AURenderCallback = { (
        inRefCon,
        ioActionFlags,
        inTimeStamp,
        inBusNumber,
        inNumberFrames,
        ioData
    ) -> OSStatus in
        let engine = Unmanaged<UltraLowLatencyEngine>.fromOpaque(inRefCon).takeUnretainedValue()
        return engine.renderAudio(ioData: ioData!, frameCount: inNumberFrames)
    }
    
    private func renderAudio(ioData: UnsafeMutablePointer<AudioBufferList>, frameCount: UInt32) -> OSStatus {
        // Process audio here
        let level = calculateLevel(from: ioData, frameCount: frameCount)
        
        // Ultra-low latency UI update
        DispatchQueue.main.async {
            self.uiUpdateCallback(level)
        }
        
        return noErr
    }
}
```

### Efficient State Management

Minimize state changes and updates:

```swift
class EfficiientAudioState: ObservableObject {
    // Group related values to minimize update notifications
    struct MeterState {
        var level: Float
        var peak: Float
        var clip: Bool
    }
    
    struct ControlState {
        var frequency: Float
        var resonance: Float
        var cutoff: Float
    }
    
    @Published var meterState = MeterState(level: 0, peak: 0, clip: false)
    @Published var controlState = ControlState(frequency: 440, resonance: 0.5, cutoff: 0.7)
    
    // Batch updates to reduce redraws
    func updateMeterValues(level: Float, peak: Float, clip: Bool) {
        let newState = MeterState(level: level, peak: peak, clip: clip)
        
        // Only update if values changed significantly
        if shouldUpdate(newState, from: meterState) {
            meterState = newState
        }
    }
    
    private func shouldUpdate(_ new: MeterState, from old: MeterState) -> Bool {
        return abs(new.level - old.level) > 0.01 ||
               abs(new.peak - old.peak) > 0.01 ||
               new.clip != old.clip
    }
}
```

## Audio-Driven Animations

### Responsive UI Elements

Create interfaces that feel connected to the audio:

```swift
struct AudioResponsiveKnob: View {
    @Binding var value: Double
    let audioLevel: Float
    
    @State private var pulseScale: CGFloat = 1.0
    @State private var glowOpacity: Double = 0.0
    
    var body: some View {
        InsetNeumorphicKnob(value: $value)
            .scaleEffect(pulseScale)
            .shadow(
                color: .blue.opacity(glowOpacity),
                radius: 20
            )
            .onChange(of: audioLevel) { level in
                // Respond to audio with subtle animation
                withAnimation(.easeOut(duration: 0.1)) {
                    pulseScale = 1.0 + CGFloat(level) * 0.1
                    glowOpacity = Double(level) * 0.5
                }
            }
    }
}
```

### Beat-Synchronized Effects

Sync UI elements to musical timing:

```swift
class BeatDetector: ObservableObject {
    @Published var beatDetected: Bool = false
    @Published var tempo: Float = 120.0
    
    private var audioEngine: AudioEngine
    private var lastBeatTime: CFAbsoluteTime = 0
    
    init(audioEngine: AudioEngine) {
        self.audioEngine = audioEngine
        startBeatDetection()
    }
    
    private func startBeatDetection() {
        Timer.scheduledTimer(withTimeInterval: 1/60) { _ in
            self.analyzeBeat()
        }
    }
    
    private func analyzeBeat() {
        let currentTime = CFAbsoluteTimeGetCurrent()
        let level = audioEngine.kickLevel
        
        // Simple beat detection
        if level > 0.8 && (currentTime - lastBeatTime) > 0.3 {
            lastBeatTime = currentTime
            
            DispatchQueue.main.async {
                self.beatDetected = true
                
                // Reset beat state
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.beatDetected = false
                }
            }
        }
    }
}

struct BeatSyncButton: View {
    @ObservedObject var beatDetector: BeatDetector
    let action: () -> Void
    
    @State private var beatScale: CGFloat = 1.0
    
    var body: some View {
        CircularButton(action: action)
            .scaleEffect(beatScale)
            .onChange(of: beatDetector.beatDetected) { detected in
                if detected {
                    withAnimation(.easeOut(duration: 0.2)) {
                        beatScale = 1.2
                    }
                    withAnimation(.easeOut(duration: 0.3).delay(0.1)) {
                        beatScale = 1.0
                    }
                }
            }
    }
}
```

## Debugging Real-Time Systems

### Performance Monitoring

Track real-time performance metrics:

```swift
class RealTimePerformanceMonitor {
    private var audioCallbackTimes: [CFAbsoluteTime] = []
    private var uiUpdateTimes: [CFAbsoluteTime] = []
    private var dropoutCount: Int = 0
    
    func recordAudioCallback() {
        let time = CFAbsoluteTimeGetCurrent()
        audioCallbackTimes.append(time)
        
        // Keep only recent samples
        if audioCallbackTimes.count > 1000 {
            audioCallbackTimes.removeFirst(100)
        }
    }
    
    func recordUIUpdate() {
        let time = CFAbsoluteTimeGetCurrent()
        uiUpdateTimes.append(time)
        
        if uiUpdateTimes.count > 1000 {
            uiUpdateTimes.removeFirst(100)
        }
    }
    
    func recordDropout() {
        dropoutCount += 1
    }
    
    func generateReport() -> PerformanceReport {
        let avgAudioInterval = calculateAverageInterval(audioCallbackTimes)
        let avgUIInterval = calculateAverageInterval(uiUpdateTimes)
        
        return PerformanceReport(
            audioCallbackRate: 1.0 / avgAudioInterval,
            uiUpdateRate: 1.0 / avgUIInterval,
            dropoutCount: dropoutCount,
            isStable: dropoutCount < 5 && avgAudioInterval < 0.01
        )
    }
}
```

Real-time audio interfaces require careful attention to thread management, efficient updates, and minimal latency patterns. AudioUI provides the tools and patterns needed to build professional-grade real-time audio applications.

## Topics

### Thread Management
- Audio processing separation
- Lock-free communication
- Atomic operations
- Ring buffers

### Performance Optimization
- Efficient components
- Batch updates
- Low-latency patterns
- State management

### Audio-Driven UI
- Responsive elements
- Beat synchronization
- Real-time effects
- Performance monitoring
