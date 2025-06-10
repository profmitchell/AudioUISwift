# Custom Themes

Create and implement custom visual themes that define the complete appearance and behavior of AudioUI components across your application.

## Overview

AudioUI's custom theme system allows you to create cohesive design languages that span your entire audio application. Custom themes combine colors, typography, spacing, animations, and interaction patterns into unified design systems that can transform the look and feel of all AudioUI components.

## Theme Architecture

### Complete Theme Definition

A custom theme encompasses all visual and interactive aspects of your interface:

```swift
import AudioUI

struct StudioProTheme: AudioUITheme {
    // Theme identification
    let name = "Studio Pro"
    let version = "1.0"
    let author = "Your Studio"
    
    // Core visual system
    let colorScheme = StudioProColorScheme()
    let typography = StudioProTypography()
    let spacing = StudioProSpacing()
    let animations = StudioProAnimations()
    let shapes = StudioProShapes()
    
    // Component-specific styling
    let componentStyles = StudioProComponentStyles()
    
    // Interaction patterns
    let haptics = StudioProHaptics()
    let sounds = StudioProSounds()
}
```

### Color System Definition

Define a comprehensive color palette that covers all component states:

```swift
struct StudioProColorScheme: AudioUIColorScheme {
    // Primary colors
    let background = Color(red: 0.12, green: 0.12, blue: 0.14)
    let surface = Color(red: 0.16, green: 0.16, blue: 0.18)
    let primary = Color(red: 0.2, green: 0.4, blue: 0.8)
    let secondary = Color(red: 0.8, green: 0.4, blue: 0.2)
    
    // Text colors
    let textPrimary = Color.white
    let textSecondary = Color.white.opacity(0.7)
    let textDisabled = Color.white.opacity(0.4)
    
    // Component states
    let componentDefault = Color(red: 0.2, green: 0.2, blue: 0.22)
    let componentHover = Color(red: 0.24, green: 0.24, blue: 0.26)
    let componentActive = Color(red: 0.18, green: 0.18, blue: 0.20)
    let componentDisabled = Color(red: 0.14, green: 0.14, blue: 0.16)
    
    // Accent colors for different component types
    let knobTrack = Color(red: 0.3, green: 0.3, blue: 0.32)
    let knobThumb = primary
    let sliderTrack = Color(red: 0.25, green: 0.25, blue: 0.27)
    let sliderFill = primary
    
    // Status colors
    let success = Color.green
    let warning = Color.orange
    let error = Color.red
    let info = Color.blue
    
    // Meter colors
    let meterGreen = Color(red: 0.2, green: 0.8, blue: 0.2)
    let meterYellow = Color(red: 0.9, green: 0.8, blue: 0.1)
    let meterRed = Color(red: 0.9, green: 0.2, blue: 0.2)
    
    // Shadows and highlights
    let shadowDark = Color.black.opacity(0.6)
    let shadowLight = Color.white.opacity(0.1)
    let highlight = Color.white.opacity(0.2)
}
```

### Typography System

Define text styles that work across all interface scales:

```swift
struct StudioProTypography: AudioUITypography {
    let fontFamily = "SF Pro"
    
    // Component labels
    let knobLabel = TextStyle(
        font: .custom("SF Pro", size: 10),
        weight: .medium,
        color: .textSecondary,
        lineHeight: 12,
        letterSpacing: 0.5
    )
    
    let buttonLabel = TextStyle(
        font: .custom("SF Pro", size: 12),
        weight: .semibold,
        color: .textPrimary,
        lineHeight: 14,
        letterSpacing: 0.3
    )
    
    let groupTitle = TextStyle(
        font: .custom("SF Pro", size: 14),
        weight: .bold,
        color: .textPrimary,
        lineHeight: 18,
        letterSpacing: 0.2
    )
    
    // Meter labels
    let meterLabel = TextStyle(
        font: .custom("SF Pro Mono", size: 8),
        weight: .regular,
        color: .textSecondary,
        lineHeight: 10,
        letterSpacing: 0.1
    )
    
    // Status text
    let statusText = TextStyle(
        font: .custom("SF Pro", size: 11),
        weight: .medium,
        color: .textSecondary,
        lineHeight: 13,
        letterSpacing: 0.2
    )
}
```

### Spacing and Layout

Define consistent spacing rules for all components:

```swift
struct StudioProSpacing: AudioUISpacing {
    // Base spacing unit
    let unit: CGFloat = 4
    
    // Component spacing
    let componentPadding = CGFloat(12)
    let componentSpacing = CGFloat(16)
    let groupSpacing = CGFloat(24)
    let sectionSpacing = CGFloat(32)
    
    // Control dimensions
    let knobSize = CGSize(width: 48, height: 48)
    let buttonSize = CGSize(width: 44, height: 32)
    let sliderThickness = CGFloat(24)
    
    // Touch targets
    let minimumTouchTarget = CGFloat(44)
    let comfortableTouchTarget = CGFloat(52)
    
    // Layout margins
    let screenMargin = CGFloat(20)
    let panelMargin = CGFloat(16)
    let cardMargin = CGFloat(12)
}
```

### Animation System

Define consistent motion design across all interactions:

```swift
struct StudioProAnimations: AudioUIAnimations {
    // Timing functions
    let easeOut = Animation.timingCurve(0.25, 0.1, 0.25, 1.0)
    let easeInOut = Animation.timingCurve(0.42, 0, 0.58, 1.0)
    let bounce = Animation.spring(
        response: 0.6,
        dampingFraction: 0.7,
        blendDuration: 0.1
    )
    
    // Component-specific animations
    let knobRotation = Animation.timingCurve(0.4, 0.0, 0.2, 1.0, duration: 0.2)
    let buttonPress = Animation.timingCurve(0.25, 0.46, 0.45, 0.94, duration: 0.15)
    let sliderMove = Animation.timingCurve(0.4, 0.0, 0.2, 1.0, duration: 0.25)
    
    // State transitions
    let hoverTransition = Animation.easeOut(duration: 0.1)
    let focusTransition = Animation.easeInOut(duration: 0.2)
    let disabledTransition = Animation.easeOut(duration: 0.3)
    
    // Layout animations
    let layoutChange = Animation.spring(
        response: 0.5,
        dampingFraction: 0.8
    )
    
    // Value changes
    let valueChange = Animation.easeOut(duration: 0.1)
    let meterUpdate = Animation.linear(duration: 0.05)
}
```

### Shape System

Define the geometric language of your theme:

```swift
struct StudioProShapes: AudioUIShapes {
    // Corner radii
    let buttonCornerRadius: CGFloat = 6
    let knobCornerRadius: CGFloat = 24
    let panelCornerRadius: CGFloat = 8
    let cardCornerRadius: CGFloat = 12
    
    // Border widths
    let hairlineBorder: CGFloat = 0.5
    let standardBorder: CGFloat = 1
    let emphasizedBorder: CGFloat = 2
    
    // Shadow configurations
    let subtleShadow = ShadowStyle(
        color: .shadowDark,
        radius: 2,
        offset: CGPoint(x: 0, y: 1)
    )
    
    let prominentShadow = ShadowStyle(
        color: .shadowDark,
        radius: 8,
        offset: CGPoint(x: 0, y: 4)
    )
    
    let insetShadow = ShadowStyle(
        color: .shadowDark,
        radius: 4,
        offset: CGPoint(x: 0, y: -2),
        isInset: true
    )
}
```

## Component-Specific Styling

### Knob Customization

Define how knobs should appear and behave in your theme:

```swift
extension StudioProTheme {
    var knobStyle: KnobStyle {
        KnobStyle(
            trackColor: colorScheme.knobTrack,
            fillColor: colorScheme.knobThumb,
            thumbColor: colorScheme.primary,
            labelStyle: typography.knobLabel,
            
            // Visual properties
            trackWidth: 3,
            fillWidth: 4,
            thumbSize: 6,
            
            // Interaction
            rotationRange: .degrees(270),
            sensitivity: .standard,
            hapticFeedback: .enabled,
            
            // Animation
            rotationAnimation: animations.knobRotation,
            hoverAnimation: animations.hoverTransition,
            
            // Shadows
            shadowStyle: shapes.subtleShadow,
            
            // Special effects
            glowEffect: GlowEffect(
                color: colorScheme.primary,
                radius: 8,
                intensity: 0.3
            )
        )
    }
}
```

### Button Customization

Define comprehensive button appearance and behavior:

```swift
extension StudioProTheme {
    var buttonStyle: ButtonStyle {
        ButtonStyle(
            // Colors
            backgroundColor: colorScheme.componentDefault,
            foregroundColor: colorScheme.textPrimary,
            hoverBackgroundColor: colorScheme.componentHover,
            activeBackgroundColor: colorScheme.componentActive,
            disabledBackgroundColor: colorScheme.componentDisabled,
            
            // Typography
            labelStyle: typography.buttonLabel,
            
            // Geometry
            cornerRadius: shapes.buttonCornerRadius,
            borderWidth: shapes.standardBorder,
            borderColor: colorScheme.primary.opacity(0.3),
            
            // Sizing
            minimumSize: spacing.buttonSize,
            contentPadding: EdgeInsets(
                top: 8, leading: 16, bottom: 8, trailing: 16
            ),
            
            // Effects
            shadowStyle: shapes.subtleShadow,
            pressAnimation: animations.buttonPress,
            
            // Interaction
            hapticFeedback: haptics.buttonPress,
            soundFeedback: sounds.buttonClick
        )
    }
}
```

### Level Meter Customization

Create themed level meters with professional appearance:

```swift
extension StudioProTheme {
    var levelMeterStyle: LevelMeterStyle {
        LevelMeterStyle(
            // Segment colors
            segmentColors: [
                LevelRange(min: 0.0, max: 0.7): colorScheme.meterGreen,
                LevelRange(min: 0.7, max: 0.9): colorScheme.meterYellow,
                LevelRange(min: 0.9, max: 1.0): colorScheme.meterRed
            ],
            
            // Background
            backgroundColor: colorScheme.componentDefault,
            trackColor: colorScheme.knobTrack,
            
            // Geometry
            segmentSpacing: 1,
            cornerRadius: 2,
            borderWidth: 1,
            borderColor: colorScheme.primary.opacity(0.2),
            
            // Peak indicators
            peakHoldColor: colorScheme.warning,
            peakHoldDuration: 2.0,
            peakDecayAnimation: animations.valueChange,
            
            // Scale markings
            scaleColor: colorScheme.textSecondary,
            scaleFont: typography.meterLabel.font,
            showScale: true,
            
            // Update behavior
            updateAnimation: animations.meterUpdate,
            smoothing: 0.8
        )
    }
}
```

## Advanced Theme Features

### Conditional Styling

Adapt your theme based on context and device capabilities:

```swift
extension StudioProTheme {
    func adaptedStyle(for context: StyleContext) -> AudioUITheme {
        var adaptedTheme = self
        
        // Adjust for device type
        switch context.deviceType {
        case .phone:
            adaptedTheme.spacing = spacing.scaled(by: 1.2)
            adaptedTheme.componentStyles.minimumTouchTarget = 50
            
        case .pad:
            adaptedTheme.spacing = spacing.scaled(by: 1.1)
            
        case .mac:
            adaptedTheme.spacing = spacing.scaled(by: 1.0)
            adaptedTheme.componentStyles.showHoverStates = true
        }
        
        // Adjust for accessibility
        if context.accessibilitySettings.preferLargerText {
            adaptedTheme.typography = typography.scaled(by: 1.3)
        }
        
        if context.accessibilitySettings.reduceMotion {
            adaptedTheme.animations = animations.withReducedMotion()
        }
        
        // Adjust for performance
        if context.performanceProfile == .battery {
            adaptedTheme.animations = animations.withReducedComplexity()
            adaptedTheme.componentStyles.disableRealTimeEffects = true
        }
        
        return adaptedTheme
    }
}
```

### Dynamic Color Support

Support for system appearance changes and color blindness accessibility:

```swift
extension StudioProColorScheme {
    static func adaptive(for colorScheme: ColorScheme, 
                        accessibility: AccessibilitySettings) -> StudioProColorScheme {
        var colors = StudioProColorScheme()
        
        // Adapt for light/dark mode
        if colorScheme == .light {
            colors.background = Color(red: 0.95, green: 0.95, blue: 0.97)
            colors.surface = Color(red: 0.98, green: 0.98, blue: 0.99)
            colors.textPrimary = Color.black
            colors.textSecondary = Color.black.opacity(0.7)
        }
        
        // Adapt for color blindness
        if accessibility.colorBlindnessType != .none {
            colors = colors.adaptedForColorBlindness(accessibility.colorBlindnessType)
        }
        
        // Increase contrast if needed
        if accessibility.increaseContrast {
            colors = colors.withIncreasedContrast()
        }
        
        return colors
    }
}
```

## Theme Implementation

### Applying Custom Themes

Use your custom theme throughout your application:

```swift
struct AudioApp: App {
    @StateObject private var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .audioUITheme(themeManager.currentTheme)
                .onAppear {
                    themeManager.loadUserPreferences()
                }
        }
    }
}

class ThemeManager: ObservableObject {
    @Published var currentTheme: AudioUITheme = StudioProTheme()
    
    func setTheme(_ theme: AudioUITheme) {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentTheme = theme
        }
        saveUserPreferences()
    }
    
    private func saveUserPreferences() {
        UserDefaults.standard.set(currentTheme.name, forKey: "selectedTheme")
    }
    
    func loadUserPreferences() {
        let savedThemeName = UserDefaults.standard.string(forKey: "selectedTheme")
        if let themeName = savedThemeName {
            currentTheme = ThemeRegistry.theme(named: themeName) ?? StudioProTheme()
        }
    }
}
```

### Theme Switching

Provide users with the ability to switch between themes:

```swift
struct ThemeSelector: View {
    @ObservedObject var themeManager: ThemeManager
    
    let availableThemes: [AudioUITheme] = [
        StudioProTheme(),
        VintageConsoleTheme(),
        MinimalStudioTheme(),
        DarkAnalogTheme()
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(availableThemes, id: \.name) { theme in
                    ThemePreview(theme: theme)
                        .onTapGesture {
                            themeManager.setTheme(theme)
                        }
                        .scaleEffect(
                            themeManager.currentTheme.name == theme.name ? 1.1 : 1.0
                        )
                        .animation(.spring(), value: themeManager.currentTheme.name)
                }
            }
            .padding()
        }
    }
}

struct ThemePreview: View {
    let theme: AudioUITheme
    
    var body: some View {
        VStack {
            // Mini preview of theme components
            HStack {
                Circle()
                    .fill(theme.colorScheme.primary)
                    .frame(width: 20, height: 20)
                
                Rectangle()
                    .fill(theme.colorScheme.componentDefault)
                    .frame(width: 30, height: 8)
                    .cornerRadius(4)
            }
            
            Text(theme.name)
                .font(.caption)
                .foregroundColor(theme.colorScheme.textPrimary)
        }
        .padding()
        .background(theme.colorScheme.background)
        .cornerRadius(8)
    }
}
```

Custom themes enable you to create distinctive, cohesive visual identities for your audio applications while maintaining the professional functionality and interaction patterns that AudioUI provides.

## Topics

### Theme Architecture
- ``AudioUITheme``
- ``AudioUIColorScheme``
- ``AudioUITypography``
- ``AudioUISpacing``
- ``AudioUIAnimations``

### Component Styling
- ``KnobStyle``
- ``ButtonStyle``
- ``SliderStyle``
- ``LevelMeterStyle``

### Advanced Features
- Conditional styling
- Dynamic color support
- Theme switching
- Performance optimization

### Examples
- Studio Pro theme
- Vintage console theme
- Minimal modern theme
- Accessibility-first theme
