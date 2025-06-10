# Built-in Themes

Explore AudioUI's collection of professionally designed themes that provide instant visual coherence for different audio application types and user preferences.

## Overview

AudioUI includes a curated collection of built-in themes designed for different audio application contexts. Each theme represents a complete design system with carefully chosen colors, typography, spacing, and interaction patterns optimized for specific use cases.

## Professional Themes

### Studio Pro Theme

A sophisticated theme designed for professional recording and mixing environments.

```swift
import AudioUI

// Apply the Studio Pro theme
ContentView()
    .audioUITheme(.studioPro)
```

**Design Characteristics:**
- Dark color scheme optimized for long studio sessions
- High contrast for precise visual feedback
- Neumorphic elements with subtle depth
- Professional typography with excellent readability
- Precise haptic feedback for critical adjustments

**Color Palette:**
```swift
// Studio Pro color scheme
background: #1C1C1E (Dark gray)
surface: #2C2C2E (Medium gray)  
primary: #007AFF (System blue)
secondary: #FF9500 (Orange accent)
success: #30D158 (Green)
warning: #FF9F0A (Amber)
error: #FF3B30 (Red)
```

**Best For:**
- Professional recording studios
- Mixing and mastering applications
- Audio post-production suites
- Critical listening environments

### Vintage Console Theme

Inspired by classic analog mixing consoles and vintage hardware.

```swift
ContentView()
    .audioUITheme(.vintageConsole)
```

**Design Characteristics:**
- Warm, analog-inspired color palette
- Textured surfaces with subtle gradients
- Classic VU meter styling
- Vintage-style typography
- Mechanical-feeling interactions with appropriate resistance

**Color Palette:**
```swift
// Vintage Console colors
background: #2B1810 (Dark brown)
surface: #3D2317 (Medium brown)
primary: #D4A574 (Gold)
secondary: #8B4513 (Saddle brown)
accent: #FF6B35 (Vintage orange)
```

**Best For:**
- Vintage equipment emulations
- Classic synthesizer interfaces
- Retro-styled music production tools
- Analog hardware control surfaces

### Minimal Studio Theme

Clean, modern design focused on functionality and clarity.

```swift
ContentView()
    .audioUITheme(.minimalStudio)
```

**Design Characteristics:**
- Light, airy color scheme
- Flat design with subtle shadows
- Clean typography with generous spacing
- Smooth, fluid animations
- Gentle haptic feedback

**Color Palette:**
```swift
// Minimal Studio colors
background: #FFFFFF (Pure white)
surface: #F2F2F7 (Light gray)
primary: #007AFF (System blue)
secondary: #5856D6 (Purple)
neutral: #8E8E93 (Medium gray)
```

**Best For:**
- Consumer audio applications
- Podcast recording software
- Simple music creation tools
- Educational audio software

### Dark Analog Theme

Deep, rich theme emphasizing analog warmth and professional aesthetics.

```swift
ContentView()
    .audioUITheme(.darkAnalog)
```

**Design Characteristics:**
- Very dark background for reduced eye strain
- Amber and orange accents reminiscent of analog displays
- Deep shadows and subtle highlights
- Monospace typography for technical displays
- Precise, mechanical interactions

**Color Palette:**
```swift
// Dark Analog colors
background: #0A0A0A (Near black)
surface: #1A1A1A (Dark charcoal)
primary: #FF8C00 (Dark orange)
secondary: #FFD700 (Gold)
accent: #00CED1 (Dark turquoise)
```

**Best For:**
- Electronic music production
- DJ software interfaces
- Live performance applications
- Hardware emulation plugins

## Specialized Themes

### Live Performance Theme

Optimized for stage use with high visibility and quick recognition.

```swift
ContentView()
    .audioUITheme(.livePerformance)
```

**Features:**
- Extra-large touch targets for stage use
- High contrast colors visible under stage lighting
- Bold, easily readable typography
- Simplified visual hierarchy
- Strong haptic feedback for tactile confirmation

**Best For:**
- Live sound mixing consoles
- DJ performance software
- Stage monitoring applications
- Live recording interfaces

### Accessibility First Theme

Designed with accessibility as the primary consideration.

```swift
ContentView()
    .audioUITheme(.accessibilityFirst)
```

**Features:**
- WCAG AAA contrast compliance
- Large text and touch targets
- Clear visual focus indicators
- Reduced motion options
- Comprehensive screen reader support
- Color-blind friendly palette

**Best For:**
- Educational institutions
- Accessibility-compliant applications
- Public access systems
- Inclusive design requirements

### High Contrast Theme

Maximum visual clarity for challenging viewing conditions.

```swift
ContentView()
    .audioUITheme(.highContrast)
```

**Features:**
- Extreme contrast ratios
- Bold borders and outlines
- Simplified color palette
- Large visual elements
- Clear state differentiation

**Best For:**
- Bright ambient lighting conditions
- Users with visual impairments
- Emergency or critical applications
- Outdoor use scenarios

## Theme Customization

### Modifying Built-in Themes

Built-in themes can be customized while preserving their core characteristics:

```swift
struct CustomizedStudioPro: AudioUITheme {
    // Start with Studio Pro as base
    private let baseTheme = AudioUITheme.studioPro
    
    // Override specific properties
    var colorScheme: AudioUIColorScheme {
        var colors = baseTheme.colorScheme
        colors.primary = Color.purple  // Custom accent color
        colors.secondary = Color.teal  // Custom secondary color
        return colors
    }
    
    // Keep other properties from base theme
    var typography: AudioUITypography { baseTheme.typography }
    var spacing: AudioUISpacing { baseTheme.spacing }
    var animations: AudioUIAnimations { baseTheme.animations }
    var componentStyles: ComponentStyles { baseTheme.componentStyles }
}

// Apply customized theme
ContentView()
    .audioUITheme(CustomizedStudioPro())
```

### Theme Variants

Create variants of built-in themes for different contexts:

```swift
extension AudioUITheme {
    static var studioProLight: AudioUITheme {
        var theme = AudioUITheme.studioPro
        theme.colorScheme = StudioProLightColors()
        return theme
    }
    
    static var studioProCompact: AudioUITheme {
        var theme = AudioUITheme.studioPro
        theme.spacing = theme.spacing.scaled(by: 0.8)
        theme.typography = theme.typography.scaled(by: 0.9)
        return theme
    }
}
```

## Theme Selection Guidelines

### Choosing the Right Theme

Consider these factors when selecting a built-in theme:

**Application Type:**
- Professional studio software → Studio Pro or Dark Analog
- Consumer applications → Minimal Studio
- Live performance → Live Performance or Vintage Console
- Educational software → Accessibility First or Minimal Studio

**User Environment:**
- Controlled studio lighting → Studio Pro or Dark Analog
- Variable lighting conditions → High Contrast
- Stage/performance venues → Live Performance
- Public access → Accessibility First

**User Preferences:**
- Analog hardware enthusiasts → Vintage Console
- Modern, clean interfaces → Minimal Studio
- Professional precision → Studio Pro
- Maximum accessibility → Accessibility First

### Theme Comparison

| Theme | Complexity | Contrast | Target Environment | Primary Users |
|-------|------------|----------|-------------------|---------------|
| Studio Pro | High | Medium-High | Professional Studios | Audio Engineers |
| Vintage Console | High | Medium | Creative Studios | Musicians, Producers |
| Minimal Studio | Low | Medium | General Use | Content Creators |
| Dark Analog | Medium | High | Electronic Music | Electronic Musicians |
| Live Performance | Medium | Very High | Live Venues | Live Sound Engineers |
| Accessibility First | Low | Very High | Educational/Public | All Users |
| High Contrast | Low | Maximum | Challenging Lighting | Vision-Impaired Users |

## Implementation Examples

### Theme-Aware Components

Components automatically adapt to the active theme:

```swift
struct MixingConsole: View {
    var body: some View {
        VStack {
            // Components inherit theme styling automatically
            HStack {
                ForEach(channels) { channel in
                    VStack {
                        InsetNeumorphicKnob(
                            value: $channel.gain,
                            label: "GAIN"
                        )
                        // Knob appearance changes with theme
                        
                        VerticalInsetSlider(
                            value: $channel.level,
                            label: "LEVEL"
                        )
                        // Slider styling adapts to theme
                        
                        ThemedLevelMeter(
                            level: channel.meter,
                            peak: channel.peak
                        )
                        // Meter colors match theme palette
                    }
                }
            }
        }
    }
}
```

### Dynamic Theme Switching

Allow users to switch between built-in themes:

```swift
struct ThemeSettings: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    let builtInThemes: [(String, AudioUITheme)] = [
        ("Studio Pro", .studioPro),
        ("Vintage Console", .vintageConsole),
        ("Minimal Studio", .minimalStudio),
        ("Dark Analog", .darkAnalog),
        ("Live Performance", .livePerformance),
        ("Accessibility First", .accessibilityFirst),
        ("High Contrast", .highContrast)
    ]
    
    var body: some View {
        List {
            ForEach(builtInThemes, id: \.0) { name, theme in
                ThemeRow(
                    name: name,
                    theme: theme,
                    isSelected: themeManager.currentTheme.name == name
                ) {
                    themeManager.setTheme(theme)
                }
            }
        }
        .navigationTitle("Themes")
    }
}
```

### Conditional Theme Loading

Load themes based on user preferences or system conditions:

```swift
class ThemeManager: ObservableObject {
    @Published var currentTheme: AudioUITheme = .studioPro
    
    func loadAppropriateTheme() {
        // Load based on time of day
        let hour = Calendar.current.component(.hour, from: Date())
        if hour >= 22 || hour <= 6 {
            currentTheme = .darkAnalog  // Night theme
        } else {
            currentTheme = .studioPro   // Day theme
        }
        
        // Override with user preference if set
        if let savedTheme = UserDefaults.standard.string(forKey: "preferredTheme") {
            currentTheme = themeForName(savedTheme) ?? currentTheme
        }
        
        // Accessibility overrides
        if UIAccessibility.isReduceTransparencyEnabled {
            currentTheme = .highContrast
        }
        
        if UIAccessibility.isDarkerSystemColorsEnabled {
            currentTheme = .darkAnalog
        }
    }
}
```

Built-in themes provide immediate visual coherence and professional appearance for audio applications while offering the flexibility to customize and adapt to specific needs.

## Topics

### Professional Themes
- ``studioPro``
- ``vintageConsole``
- ``darkAnalog``

### User-Friendly Themes
- ``minimalStudio``
- ``livePerformance``

### Accessibility Themes
- ``accessibilityFirst``
- ``highContrast``

### Customization
- Theme variants
- Theme selection guidelines
- Dynamic theme switching
- Conditional theme loading
