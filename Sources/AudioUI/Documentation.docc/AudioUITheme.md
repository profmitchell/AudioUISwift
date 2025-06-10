# AudioUITheme Module

Advanced theming system that separates visual appearance (Looks) from interaction behavior (Feels), enabling sophisticated and consistent audio interface design.

## Overview

AudioUITheme is the styling engine that transforms functional audio controls into beautiful, professional interfaces. By separating visual design from interaction behavior, it provides unprecedented flexibility in creating audio interfaces that match your application's needs and brand.

The theming system is built around two core concepts:
- **Looks**: Visual styling (colors, shadows, gradients, typography)
- **Feels**: Interaction behavior (animations, responsiveness, tactile feedback)

## Architecture

### The Look Protocol

Defines the visual appearance of interface elements:

```swift
protocol Look {
    // Brand Colors
    var brandPrimary: Color { get }
    var brandSecondary: Color { get }
    
    // Surface Colors
    var surface: Color { get }
    var surfacePressed: Color { get }
    var surfaceElevated: Color { get }
    
    // Interactive States
    var interactiveIdle: Color { get }
    var interactiveHover: Color { get }
    var interactivePressed: Color { get }
    var interactiveDisabled: Color { get }
    
    // Text Colors
    var textPrimary: Color { get }
    var textSecondary: Color { get }
    var textTertiary: Color { get }
    
    // Accent Colors
    var accent: Color { get }
    var accentSecondary: Color { get }
    
    // Effect Colors
    var shadowDark: Color { get }
    var shadowLight: Color { get }
    var glassBorder: Color { get }
    var glowPrimary: Color { get }
}
```

### The Feel Protocol

Defines interaction behavior and animations:

```swift
protocol Feel {
    // Shape Properties
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    
    // Shadow Properties
    var shadowRadius: CGFloat { get }
    var shadowOpacity: Double { get }
    
    // Effect Properties
    var glowIntensity: Double { get }
    var blurRadius: CGFloat { get }
    
    // Animation Properties
    var animationDuration: Double { get }
    var animationCurve: Animation { get }
    
    // Application Methods
    func applyToContainer<Content: View>(_ content: Content, look: Look) -> some View
    func applyToButton<Content: View>(_ content: Content, look: Look, isPressed: Bool) -> some View
    func applyToInteractive<Content: View>(_ content: Content, look: Look, isActive: Bool) -> some View
}
```

### The Theme Structure

Combines Look and Feel into a complete theming solution:

```swift
struct Theme {
    let look: any Look
    let feel: any Feel
    
    init(look: any Look, feel: any Feel) {
        self.look = look
        self.feel = feel
    }
}
```

## Built-in Themes

AudioUITheme includes professionally designed themes for common audio application types:

### audioUIMinimal

Clean, geometric design with high contrast - perfect for professional applications:

```swift
.theme(.audioUIMinimal)
```

**Characteristics:**
- High contrast colors for studio visibility
- Sharp, geometric shapes
- Minimal animations to reduce distraction
- Optimized for long work sessions

**Best For:** DAWs, mixing consoles, broadcast equipment, technical analysis tools

### audioUINeumorphic

Soft, tactile surfaces with realistic depth - ideal for creative applications:

```swift
.theme(.audioUINeumorphic)
```

**Characteristics:**
- Soft shadows and realistic depth
- Tactile, touchable appearance
- Rich gradients and lighting effects
- Inviting, exploratory feel

**Best For:** Virtual instruments, creative apps, consumer music tools, experimental interfaces

### darkPro

Professional dark theme optimized for studio environments:

```swift
.theme(.darkPro)
```

**Characteristics:**
- Deep, neutral backgrounds
- Reduced blue light for eye comfort
- Professional color accuracy
- Industry-standard appearance

**Best For:** Professional studios, late-night sessions, broadcast environments

### sunset

Warm gradient theme inspired by golden hour:

```swift
.theme(.sunset)
```

**Characteristics:**
- Warm, inspiring color palette
- Golden hour gradients
- Creative, uplifting atmosphere
- Emotionally engaging appearance

**Best For:** Creative workflows, inspiration-focused apps, artistic applications

### ocean

Cool blue tones promoting focus and calm:

```swift
.theme(.ocean)
```

**Characteristics:**
- Calming blue palette
- Flowing, organic gradients
- Peaceful, focused atmosphere
- Stress-reducing colors

**Best For:** Meditation apps, ambient music tools, relaxation-focused applications

### ultraClean

Ultra-minimal design for maximum clarity:

```swift
.theme(.ultraClean)
```

**Characteristics:**
- Maximum simplicity
- Accessibility-focused design
- Crystal clear hierarchy
- Distraction-free interface

**Best For:** Accessibility applications, educational tools, clarity-critical interfaces

## Creating Custom Themes

### Custom Look Implementation

Create your own visual styling by implementing the Look protocol:

```swift
struct CustomLook: Look {
    // Brand Colors
    let brandPrimary = Color.purple
    let brandSecondary = Color.pink
    
    // Surface Colors  
    var surface: Color { Color(hex: "#2A2A2A") }
    var surfacePressed: Color { Color(hex: "#1A1A1A") }
    var surfaceElevated: Color { Color(hex: "#3A3A3A") }
    
    // Interactive States
    var interactiveIdle: Color { brandPrimary.opacity(0.6) }
    var interactiveHover: Color { brandPrimary.opacity(0.8) }
    var interactivePressed: Color { brandPrimary }
    var interactiveDisabled: Color { Color.gray.opacity(0.3) }
    
    // Text Colors
    var textPrimary: Color { Color.white }
    var textSecondary: Color { Color.white.opacity(0.8) }
    var textTertiary: Color { Color.white.opacity(0.6) }
    
    // Accent Colors
    var accent: Color { brandSecondary }
    var accentSecondary: Color { Color.orange }
    
    // Effect Colors
    var shadowDark: Color { Color.black.opacity(0.8) }
    var shadowLight: Color { Color.white.opacity(0.1) }
    var glassBorder: Color { Color.white.opacity(0.2) }
    var glowPrimary: Color { brandPrimary }
}
```

### Custom Feel Implementation

Define interaction behavior by implementing the Feel protocol:

```swift
struct CustomFeel: Feel {
    let cornerRadius: CGFloat = 12
    let borderWidth: CGFloat = 1.5
    let shadowRadius: CGFloat = 8
    let shadowOpacity: Double = 0.4
    let glowIntensity: Double = 0.7
    let blurRadius: CGFloat = 6
    let animationDuration: Double = 0.25
    let animationCurve = Animation.spring(response: 0.3, dampingFraction: 0.8)
    
    func applyToContainer<Content: View>(_ content: Content, look: Look) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(look.surface)
                    .shadow(
                        color: look.shadowDark.opacity(shadowOpacity),
                        radius: shadowRadius,
                        x: 2, y: 2
                    )
            )
    }
    
    func applyToButton<Content: View>(_ content: Content, look: Look, isPressed: Bool) -> some View {
        content
            .scaleEffect(isPressed ? 0.96 : 1.0)
            .brightness(isPressed ? -0.1 : 0)
            .animation(animationCurve, value: isPressed)
    }
}
```

### Combining Custom Look and Feel

Create a complete custom theme:

```swift
let myCustomTheme = Theme(
    look: CustomLook(),
    feel: CustomFeel()
)

struct MyThemedInterface: View {
    var body: some View {
        VStack {
            InsetNeumorphicKnob(value: $frequency)
            InsetToggleButton(label: "MUTE", isOn: $isMuted)
        }
        .theme(myCustomTheme)
    }
}
```

## Theme Application

### Environment-Based Theming

Themes are applied through SwiftUI's environment system:

```swift
struct AudioApp: View {
    var body: some View {
        ContentView()
            .theme(.darkPro) // Applied to entire view hierarchy
    }
}
```

### Conditional Theming

Switch themes based on context:

```swift
struct AdaptiveInterface: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("userTheme") var selectedTheme = "darkPro"
    
    var body: some View {
        AudioInterface()
            .theme(themeForContext())
    }
    
    private func themeForContext() -> Theme {
        switch (selectedTheme, colorScheme) {
        case ("auto", .dark):
            return .darkPro
        case ("auto", .light):
            return .ultraClean
        case ("creative", _):
            return .audioUINeumorphic
        default:
            return Theme.allThemes[selectedTheme] ?? .darkPro
        }
    }
}
```

### Component-Specific Theming

Override themes for specific components:

```swift
struct MixedThemeInterface: View {
    var body: some View {
        VStack {
            // Creative controls use neumorphic theme
            HStack {
                InsetNeumorphicKnob(value: $creativity)
                    .theme(.audioUINeumorphic)
            }
            
            Divider()
            
            // Technical controls use minimal theme
            HStack {
                KnobMinimal1(value: $gain)
                KnobMinimal1(value: $frequency)
                    .theme(.audioUIMinimal)
            }
        }
        .theme(.darkPro) // Default for the container
    }
}
```

## Theme Development Best Practices

### Color Accessibility

Ensure your themes meet accessibility standards:

```swift
struct AccessibleLook: Look {
    // High contrast ratios (4.5:1 minimum for normal text)
    var textPrimary: Color { Color.white }
    var surface: Color { Color(hex: "#1A1A1A") } // Contrast ratio: 8.2:1
    
    // Clear state differentiation
    var interactiveIdle: Color { Color(hex: "#007AFF") }
    var interactivePressed: Color { Color(hex: "#0051D5") }
    
    // Colorblind-friendly palette
    var accent: Color { Color(hex: "#34C759") } // Green
    var accentSecondary: Color { Color(hex: "#FF9500") } // Orange
}
```

### Performance Optimization

Design themes for optimal rendering performance:

```swift
struct PerformantFeel: Feel {
    // Prefer simple shapes over complex gradients
    let cornerRadius: CGFloat = 8
    
    // Minimize shadow usage for better performance
    let shadowRadius: CGFloat = 2
    let shadowOpacity: Double = 0.2
    
    // Use shorter animations for real-time controls
    let animationDuration: Double = 0.15
    let animationCurve = Animation.easeOut(duration: 0.15)
}
```

### Semantic Color Usage

Use colors semantically for better user understanding:

```swift
struct SemanticLook: Look {
    // Functional color mapping
    var accent: Color { Color.blue }        // Navigation and selection
    var accentSecondary: Color { Color.green } // Success and positive feedback
    
    // Status colors
    var warningColor: Color { Color.orange }
    var errorColor: Color { Color.red }
    var successColor: Color { Color.green }
    
    // Audio-specific semantics
    var recordColor: Color { Color.red }     // Recording indicators
    var playColor: Color { Color.green }     // Playback indicators
    var muteColor: Color { Color.orange }    // Muted state
}
```

## Theme Testing and Validation

### Multi-Theme Testing

Test your interface with different themes:

```swift
struct ThemeTestView: View {
    @State private var currentTheme = 0
    let themes: [Theme] = [
        .audioUIMinimal,
        .audioUINeumorphic,
        .darkPro,
        .sunset,
        .ocean,
        .ultraClean
    ]
    
    var body: some View {
        VStack {
            Picker("Theme", selection: $currentTheme) {
                ForEach(0..<themes.count, id: \.self) { index in
                    Text("Theme \(index)")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            YourAudioInterface()
                .theme(themes[currentTheme])
        }
        .padding()
    }
}
```

### Accessibility Testing

Validate theme accessibility:

```swift
struct AccessibilityTestView: View {
    var body: some View {
        VStack {
            YourAudioInterface()
                .theme(.ultraClean) // High contrast theme
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
                .preferredColorScheme(.dark)
        }
    }
}
```

## Integration with System Themes

### Dynamic Color Support

Support system-wide dark/light mode:

```swift
struct SystemAdaptiveLook: Look {
    @Environment(\.colorScheme) var colorScheme
    
    var surface: Color {
        colorScheme == .dark 
            ? Color(hex: "#2A2A2A")
            : Color(hex: "#F5F5F5")
    }
    
    var textPrimary: Color {
        colorScheme == .dark
            ? Color.white
            : Color.black
    }
}
```

### Platform-Specific Adaptations

Adapt themes for different platforms:

```swift
struct PlatformAdaptiveFeel: Feel {
    var cornerRadius: CGFloat {
        #if os(iOS)
        return 12 // iOS rounded corners
        #elseif os(macOS)
        return 6  // macOS sharper corners
        #else
        return 8  // Other platforms
        #endif
    }
    
    var animationCurve: Animation {
        #if os(iOS)
        return Animation.spring(response: 0.4, dampingFraction: 0.8)
        #else
        return Animation.easeInOut(duration: 0.2)
        #endif
    }
}
```

## Advanced Theming Techniques

### Gradient-Based Looks

Create rich visual experiences with gradients:

```swift
struct GradientLook: Look {
    var surfaceGradient: LinearGradient {
        LinearGradient(
            colors: [surface, surfacePressed],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    var accentGradient: LinearGradient {
        LinearGradient(
            colors: [accent, accentSecondary],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}
```

### Material-Based Feels

Implement realistic material behaviors:

```swift
struct MaterialFeel: Feel {
    func applyToContainer<Content: View>(_ content: Content, look: Look) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(look.glassBorder, lineWidth: 0.5)
                    )
            )
    }
}
```

## Theme Migration and Versioning

### Theme Version Compatibility

Handle theme evolution gracefully:

```swift
struct VersionedTheme {
    let version: String
    let theme: Theme
    
    static func migrate(from oldTheme: Theme, version: String) -> Theme {
        switch version {
        case "1.0":
            return Theme(look: MigratedLook(from: oldTheme.look), feel: oldTheme.feel)
        default:
            return oldTheme
        }
    }
}
```

## Conclusion

AudioUITheme provides the foundation for creating professional, consistent, and beautiful audio interfaces. By separating visual design from interaction behavior, it enables unprecedented flexibility while maintaining the precision and performance requirements of audio applications.

Key benefits:
- **Consistency**: Unified visual language across your application
- **Flexibility**: Easy switching between different visual styles
- **Maintainability**: Centralized styling makes updates simple
- **Accessibility**: Built-in support for accessibility requirements
- **Performance**: Optimized for real-time audio applications

Whether you use the built-in themes or create custom ones, AudioUITheme ensures your audio interface looks professional and feels responsive to your users.
