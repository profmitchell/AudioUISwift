# Cross-Platform Considerations

Building audio interfaces that work seamlessly across iOS, macOS, and beyond.

## Overview

AudioUI is designed as a cross-platform framework that provides consistent behavior and appearance across different Apple platforms while respecting platform-specific design conventions and capabilities.

## Platform Support

### iOS (iPhone & iPad)
- **Touch Interaction**: Optimized for finger-based touch input
- **Haptic Feedback**: Integrated with iOS haptics for tactile responses
- **Motion Controls**: Full Core Motion integration for gyroscope and accelerometer
- **Form Factor**: Adaptive layouts for different screen sizes

```swift
#if os(iOS)
import UIKit

struct iOSOptimizedKnob: View {
    var body: some View {
        InsetNeumorphicKnob(value: .constant(0.5))
            .frame(width: 80, height: 80) // Touch-friendly size
            .hapticFeedback(.selection, trigger: dragGesture)
    }
}
#endif
```

### macOS
- **Precise Input**: Support for mouse and trackpad precision
- **Keyboard Shortcuts**: Standard macOS modifier key support
- **Window Management**: Proper integration with macOS window system
- **Accessibility**: Full VoiceOver and keyboard navigation

```swift
#if os(macOS)
struct macOSOptimizedKnob: View {
    var body: some View {
        InsetNeumorphicKnob(value: .constant(0.5))
            .frame(width: 60, height: 60) // Smaller for precise input
            .onKeyPress(.arrowUp) { _ in
                // Fine adjustment with arrow keys
                return .handled
            }
    }
}
#endif
```

### visionOS (Future)
- **Spatial Computing**: 3D positioning and depth
- **Eye Tracking**: Gaze-based interaction
- **Hand Gestures**: Natural gesture recognition
- **Immersive Audio**: Spatial audio integration

## Adaptive Design Patterns

### Input Method Detection

```swift
struct AdaptiveKnob: View {
    @Environment(\.inputDevice) private var inputDevice
    
    var body: some View {
        switch inputDevice {
        case .touch:
            TouchOptimizedKnob()
        case .mouse:
            PrecisionKnob()
        case .trackpad:
            GestureKnob()
        default:
            DefaultKnob()
        }
    }
}
```

### Screen Size Adaptation

```swift
struct ResponsiveMixer: View {
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.width > 768 {
                // Desktop/tablet layout
                HStack {
                    ChannelStrip()
                    ChannelStrip()
                    ChannelStrip()
                    ChannelStrip()
                }
            } else {
                // Mobile layout
                ScrollView(.horizontal) {
                    HStack {
                        ChannelStrip()
                        ChannelStrip()
                    }
                }
            }
        }
    }
}
```

## Platform-Specific Features

### Motion Controls (iOS Only)

```swift
#if os(iOS) && canImport(CoreMotion)
struct MotionControlledFilter: View {
    @StateObject private var motionManager = MotionManager()
    
    var body: some View {
        FilterXYPad(
            x: .constant(motionManager.attitude.roll),
            y: .constant(motionManager.attitude.pitch)
        )
        .onAppear {
            motionManager.startUpdates()
        }
    }
}
#endif
```

### Precision Input (macOS)

```swift
#if os(macOS)
struct PrecisionFader: View {
    @State private var value: Double = 0.5
    
    var body: some View {
        VerticalInsetSlider(value: $value)
            .onKeyPress(.arrowUp) { _ in
                value = min(1.0, value + 0.01) // Fine increment
                return .handled
            }
            .onKeyPress(.arrowDown) { _ in
                value = max(0.0, value - 0.01)
                return .handled
            }
    }
}
#endif
```

## Performance Considerations

### Memory Management

```swift
// Use @StateObject for platform-specific managers
struct CrossPlatformComponent: View {
    #if os(iOS)
    @StateObject private var hapticManager = HapticManager()
    #endif
    
    #if os(macOS)
    @StateObject private var keyboardManager = KeyboardManager()
    #endif
    
    var body: some View {
        // Shared UI code
        ComponentView()
    }
}
```

### Resource Loading

```swift
extension Image {
    static func platformIcon(_ name: String) -> Image {
        #if os(iOS)
        return Image(systemName: "\(name).circle")
        #elseif os(macOS)
        return Image(systemName: "\(name).square")
        #else
        return Image(systemName: name)
        #endif
    }
}
```

## Accessibility

### Cross-Platform Accessibility

```swift
struct AccessibleKnob: View {
    @Binding var value: Double
    
    var body: some View {
        InsetNeumorphicKnob(value: $value)
            .accessibilityLabel("Filter Cutoff")
            .accessibilityValue("\(Int(value * 100))%")
            .accessibilityAdjustableAction { direction in
                switch direction {
                case .increment:
                    value = min(1.0, value + 0.1)
                case .decrement:
                    value = max(0.0, value - 0.1)
                @unknown default:
                    break
                }
            }
    }
}
```

### Platform-Specific Accessibility

```swift
#if os(macOS)
extension View {
    func macOSKeyboardNavigation() -> some View {
        self
            .focusable()
            .onKeyPress(.tab) { _ in
                // Handle tab navigation
                return .handled
            }
    }
}
#endif
```

## Testing Across Platforms

### Platform-Specific Tests

```swift
#if os(iOS)
class iOSTouchTests: XCTestCase {
    func testTouchGestures() {
        // iOS-specific touch testing
    }
}
#endif

#if os(macOS)
class macOSInputTests: XCTestCase {
    func testKeyboardInput() {
        // macOS-specific keyboard testing
    }
}
#endif
```

### Shared Behavior Tests

```swift
class CrossPlatformTests: XCTestCase {
    func testValueBinding() {
        // Test that works on all platforms
        let knob = InsetNeumorphicKnob(value: .constant(0.5))
        // Verify binding behavior
    }
}
```

## Best Practices

### 1. Design for Touch First
- Use minimum 44pt touch targets on iOS
- Provide visual feedback for all interactions
- Consider thumb reach zones

### 2. Leverage Platform Strengths
- Use haptics on iOS for tactile feedback
- Implement keyboard shortcuts on macOS
- Support trackpad gestures where available

### 3. Maintain Consistency
- Keep core functionality identical across platforms
- Adapt only the interaction methods
- Use the same visual design language

### 4. Test on Real Devices
- Test touch interactions on actual iOS devices
- Verify mouse precision on macOS
- Check performance on different hardware

### 5. Progressive Enhancement
- Start with basic functionality that works everywhere
- Add platform-specific enhancements as available
- Gracefully degrade when features aren't supported

## Migration Path

When adding new platform support:

1. **Identify Core Functionality**: What works universally?
2. **Platform-Specific Features**: What unique capabilities exist?
3. **Adaptation Layer**: How to bridge the differences?
4. **Testing Strategy**: How to ensure quality across platforms?

AudioUI's architecture makes it straightforward to extend to new platforms while maintaining a consistent developer experience.
