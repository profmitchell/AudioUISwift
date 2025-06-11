# Looks and Feels

The visual appearance system that defines how AudioUI components render across different design aesthetics and interaction paradigms.

## Overview

AudioUI's Looks and Feels system provides a powerful abstraction layer that separates component behavior from visual appearance. This architecture enables the same functional component to render with completely different visual styles while maintaining consistent interaction patterns.

## Core Concepts

### Look Protocol

The `Look` protocol defines how a component should be visually rendered, handling drawing, colors, shadows, and visual effects.

```swift
public protocol Look {
    /// The visual style identifier
    var name: String { get }
    
    /// Primary color scheme
    var colorScheme: ColorScheme { get }
    
    /// Render a component with this look
    func render<Component: AudioUIComponent>(
        _ component: Component,
        in context: RenderContext
    ) -> some View
    
    /// Animation preferences for this look
    var animationStyle: AnimationStyle { get }
    
    /// Shadow configuration
    var shadowConfiguration: ShadowConfiguration { get }
}
```

### Feel Protocol

The `Feel` protocol defines interaction behaviors, haptic feedback, and response characteristics.

```swift
public protocol Feel {
    /// The interaction style identifier
    var name: String { get }
    
    /// Haptic feedback configuration
    var hapticConfiguration: HapticConfiguration { get }
    
    /// Touch response characteristics
    var touchResponse: TouchResponse { get }
    
    /// Handle component interaction
    func handleInteraction<Component: AudioUIComponent>(
        for component: Component,
        interaction: InteractionEvent
    )
    
    /// Animation timing for interactions
    var interactionTiming: AnimationTiming { get }
}
```

## Built-in Looks

### Neumorphic Look

Soft, raised surfaces that appear to emerge from the background.

```swift
struct NeumorphicLook: Look {
    let name = "neumorphic"
    let colorScheme: ColorScheme = .adaptive
    
    var shadowConfiguration: ShadowConfiguration {
        ShadowConfiguration(
            light: Shadow(
                color: .white.opacity(0.8),
                radius: 4,
                offset: CGPoint(x: -2, y: -2)
            ),
            dark: Shadow(
                color: .black.opacity(0.3),
                radius: 6,
                offset: CGPoint(x: 3, y: 3)
            )
        )
    }
    
    func render<Component: AudioUIComponent>(
        _ component: Component,
        in context: RenderContext
    ) -> some View {
        component
            .background(
                RoundedRectangle(cornerRadius: context.cornerRadius)
                    .fill(context.backgroundColor)
                    .shadow(
                        color: shadowConfiguration.light.color,
                        radius: shadowConfiguration.light.radius,
                        x: shadowConfiguration.light.offset.x,
                        y: shadowConfiguration.light.offset.y
                    )
                    .shadow(
                        color: shadowConfiguration.dark.color,
                        radius: shadowConfiguration.dark.radius,
                        x: shadowConfiguration.dark.offset.x,
                        y: shadowConfiguration.dark.offset.y
                    )
            )
    }
}
```

### Minimal Look

Clean, flat design with subtle borders and minimal visual effects.

```swift
struct MinimalLook: Look {
    let name = "minimal"
    let colorScheme: ColorScheme = .light
    
    var shadowConfiguration: ShadowConfiguration {
        ShadowConfiguration(
            light: Shadow.none,
            dark: Shadow(
                color: .black.opacity(0.1),
                radius: 1,
                offset: CGPoint(x: 0, y: 1)
            )
        )
    }
    
    func render<Component: AudioUIComponent>(
        _ component: Component,
        in context: RenderContext
    ) -> some View {
        component
            .background(
                RoundedRectangle(cornerRadius: 2)
                    .fill(context.backgroundColor)
                    .stroke(context.borderColor, lineWidth: 1)
            )
            .shadow(
                color: shadowConfiguration.dark.color,
                radius: shadowConfiguration.dark.radius,
                x: shadowConfiguration.dark.offset.x,
                y: shadowConfiguration.dark.offset.y
            )
    }
}
```

### Vintage Look

Warm, analog-inspired aesthetics with rich textures and gradients.

```swift
struct VintageLook: Look {
    let name = "vintage"
    let colorScheme: ColorScheme = .dark
    
    var shadowConfiguration: ShadowConfiguration {
        ShadowConfiguration(
            light: Shadow(
                color: .orange.opacity(0.2),
                radius: 3,
                offset: CGPoint(x: -1, y: -1)
            ),
            dark: Shadow(
                color: .brown.opacity(0.6),
                radius: 8,
                offset: CGPoint(x: 2, y: 4)
            )
        )
    }
    
    func render<Component: AudioUIComponent>(
        _ component: Component,
        in context: RenderContext
    ) -> some View {
        component
            .background(
                RoundedRectangle(cornerRadius: context.cornerRadius)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.brown.opacity(0.8),
                                Color.orange.opacity(0.4)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: context.cornerRadius)
                            .stroke(
                                LinearGradient(
                                    colors: [.copper, .gold],
                                    startPoint: .top,
                                    endPoint: .bottom
                                ),
                                lineWidth: 2
                            )
                    )
            )
            .shadow(
                color: shadowConfiguration.dark.color,
                radius: shadowConfiguration.dark.radius,
                x: shadowConfiguration.dark.offset.x,
                y: shadowConfiguration.dark.offset.y
            )
    }
}
```

## Built-in Feels

### Precise Feel

Responsive, immediate feedback for precise control scenarios.

```swift
struct PreciseFeel: Feel {
    let name = "precise"
    
    var hapticConfiguration: HapticConfiguration {
        HapticConfiguration(
            enabled: true,
            lightFeedback: .selection,
            mediumFeedback: .impactLight,
            heavyFeedback: .impactMedium
        )
    }
    
    var touchResponse: TouchResponse {
        TouchResponse(
            sensitivity: .high,
            dampening: .minimal,
            acceleration: .linear
        )
    }
    
    var interactionTiming: AnimationTiming {
        AnimationTiming(
            duration: 0.1,
            curve: .easeOut
        )
    }
    
    func handleInteraction<Component: AudioUIComponent>(
        for component: Component,
        interaction: InteractionEvent
    ) {
        switch interaction.type {
        case .began:
            HapticEngine.shared.playFeedback(
                hapticConfiguration.lightFeedback
            )
        case .changed:
            // Continuous feedback for drag operations
            if interaction.velocity > 0.5 {
                HapticEngine.shared.playFeedback(
                    hapticConfiguration.mediumFeedback
                )
            }
        case .ended:
            HapticEngine.shared.playFeedback(
                hapticConfiguration.heavyFeedback
            )
        }
    }
}
```

### Smooth Feel

Fluid, comfortable interactions with gentle feedback.

```swift
struct SmoothFeel: Feel {
    let name = "smooth"
    
    var hapticConfiguration: HapticConfiguration {
        HapticConfiguration(
            enabled: true,
            lightFeedback: .selection,
            mediumFeedback: .impactLight,
            heavyFeedback: .impactLight
        )
    }
    
    var touchResponse: TouchResponse {
        TouchResponse(
            sensitivity: .medium,
            dampening: .moderate,
            acceleration: .easeInOut
        )
    }
    
    var interactionTiming: AnimationTiming {
        AnimationTiming(
            duration: 0.3,
            curve: .easeInOut
        )
    }
    
    func handleInteraction<Component: AudioUIComponent>(
        for component: Component,
        interaction: InteractionEvent
    ) {
        // Gentle haptic feedback
        if interaction.type == .began {
            HapticEngine.shared.playFeedback(
                hapticConfiguration.lightFeedback
            )
        }
    }
}
```

## Custom Look Creation

Creating a custom look involves implementing the `Look` protocol:

```swift
struct MetalLook: Look {
    let name = "metal"
    let colorScheme: ColorScheme = .dark
    
    var animationStyle: AnimationStyle {
        AnimationStyle(
            springResponse: 0.6,
            springDampingFraction: 0.8
        )
    }
    
    var shadowConfiguration: ShadowConfiguration {
        ShadowConfiguration(
            light: Shadow(
                color: .white.opacity(0.1),
                radius: 2,
                offset: CGPoint(x: -1, y: -1)
            ),
            dark: Shadow(
                color: .black.opacity(0.8),
                radius: 12,
                offset: CGPoint(x: 4, y: 6)
            )
        )
    }
    
    func render<Component: AudioUIComponent>(
        _ component: Component,
        in context: RenderContext
    ) -> some View {
        component
            .background(
                RoundedRectangle(cornerRadius: context.cornerRadius)
                    .fill(
                        RadialGradient(
                            colors: [
                                Color.gray.opacity(0.9),
                                Color.black.opacity(0.7)
                            ],
                            center: .topLeading,
                            startRadius: 10,
                            endRadius: 100
                        )
                    )
                    .overlay(
                        // Metallic highlight
                        RoundedRectangle(cornerRadius: context.cornerRadius)
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        .white.opacity(0.3),
                                        .clear,
                                        .white.opacity(0.1)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    )
            )
            .shadow(
                color: shadowConfiguration.dark.color,
                radius: shadowConfiguration.dark.radius,
                x: shadowConfiguration.dark.offset.x,
                y: shadowConfiguration.dark.offset.y
            )
    }
}
```

## Custom Feel Creation

Creating a custom feel for specialized interaction patterns:

```swift
struct VintageAnalogFeel: Feel {
    let name = "vintage_analog"
    
    var hapticConfiguration: HapticConfiguration {
        HapticConfiguration(
            enabled: true,
            lightFeedback: .selection,
            mediumFeedback: .impactMedium,
            heavyFeedback: .impactHeavy
        )
    }
    
    var touchResponse: TouchResponse {
        TouchResponse(
            sensitivity: .low,
            dampening: .heavy,
            acceleration: .custom(
                // Simulate analog component inertia
                curve: { progress in
                    let resistance = 0.3
                    return pow(progress, 1.0 + resistance)
                }
            )
        )
    }
    
    var interactionTiming: AnimationTiming {
        AnimationTiming(
            duration: 0.4,
            curve: .custom(
                // Analog-style settling
                curve: { t in
                    let overshoot = sin(t * .pi * 3) * exp(-t * 4) * 0.1
                    return t + overshoot
                }
            )
        )
    }
    
    func handleInteraction<Component: AudioUIComponent>(
        for component: Component,
        interaction: InteractionEvent
    ) {
        switch interaction.type {
        case .began:
            // Simulate mechanical engagement
            HapticEngine.shared.playCustomPattern([
                .impact(.light, delay: 0),
                .impact(.medium, delay: 0.05)
            ])
            
        case .changed:
            // Simulate detent positions for knobs
            if let knob = component as? KnobComponent {
                let detentPositions = knob.detentPositions
                let currentPosition = knob.normalizedValue
                
                if detentPositions.contains(where: { 
                    abs($0 - currentPosition) < 0.02 
                }) {
                    HapticEngine.shared.playFeedback(.impactMedium)
                }
            }
            
        case .ended:
            // Simulate mechanical release
            HapticEngine.shared.playFeedback(.impactLight)
        }
    }
}
```

## Look and Feel Combinations

Combining looks and feels creates complete design systems:

```swift
// Professional studio aesthetic
let studioDesign = LookAndFeel(
    look: NeumorphicLook(),
    feel: PreciseFeel()
)

// Consumer-friendly interface
let consumerDesign = LookAndFeel(
    look: MinimalLook(),
    feel: SmoothFeel()
)

// Vintage hardware emulation
let vintageDesign = LookAndFeel(
    look: VintageLook(),
    feel: VintageAnalogFeel()
)

// Apply to components
InsetNeumorphicKnob(value: $frequency)
    .lookAndFeel(studioDesign)

CircularButton(action: play)
    .lookAndFeel(consumerDesign)

VintageKnob(value: $resonance)
    .lookAndFeel(vintageDesign)
```

## Advanced Features

### Dynamic Look Switching

```swift
struct AdaptiveLookView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedLook: Look = MinimalLook()
    
    var body: some View {
        VStack {
            Picker("Visual Style", selection: $selectedLook) {
                Text("Minimal").tag(MinimalLook() as Look)
                Text("Neumorphic").tag(NeumorphicLook() as Look)
                Text("Vintage").tag(VintageLook() as Look)
            }
            
            // Components adapt automatically
            HStack {
                InsetNeumorphicKnob(value: $gain)
                CircularButton(action: mute)
                VerticalInsetSlider(value: $volume)
            }
            .look(selectedLook)
        }
    }
}
```

### Context-Aware Rendering

```swift
extension Look {
    func contextualRender<Component: AudioUIComponent>(
        _ component: Component,
        in context: RenderContext
    ) -> some View {
        let adaptedContext = RenderContext(
            size: context.size,
            backgroundColor: backgroundColor(for: context.environment),
            foregroundColor: foregroundColor(for: context.environment),
            cornerRadius: cornerRadius(for: context.componentType),
            borderColor: borderColor(for: context.state)
        )
        
        return render(component, in: adaptedContext)
    }
    
    private func backgroundColor(for environment: EnvironmentContext) -> Color {
        switch environment.usage {
        case .studio:
            return Color.gray.opacity(0.9)
        case .live:
            return Color.black.opacity(0.95)
        case .consumer:
            return Color.white
        }
    }
}
```

The Looks and Feels system provides the visual and interactive foundation that makes AudioUI components feel consistent and professional across different design aesthetics while maintaining the flexibility to match any application's brand or user preferences.

## Topics

### Core Protocols
- ``Look``
- ``Feel``
- ``LookAndFeel``

### Built-in Looks
- ``NeumorphicLook``
- ``MinimalLook``
- ``VintageLook``
- ``MetalLook``

### Built-in Feels
- ``PreciseFeel``
- ``SmoothFeel``
- ``VintageAnalogFeel``

### Customization
- Creating custom looks
- Creating custom feels
- Dynamic look switching
- Context-aware rendering
