import SwiftUI

@available(iOS 18.0, macOS 15.0, *)
public struct Theme: Sendable {
    public let look: any Look
    public let feel: any Feel
    
    public init(look: any Look, feel: any Feel) {
        self.look = look
        self.feel = feel
    }
}

@available(iOS 18.0, macOS 15.0, *)
public extension Theme {
    // MARK: - Core Themes
    
    /// The default AudioUI theme with elegant light blue tones
    static let audioUI = Theme(look: AudioUILook(), feel: MinimalFeel())
    
    /// A professional dark theme with electric blue accents
    static let darkPro = Theme(look: DarkProLook(), feel: NeumorphicFeel())
    
    /// A vibrant ocean theme with cyan and deep blue colors
    static let ocean = Theme(look: OceanLook(), feel: NeumorphicFeel())
    
    /// A warm sunset theme with orange and purple gradients
    static let sunset = Theme(look: SunsetLook(), feel: NeumorphicFeel())
    
    /// A natural forest theme with rich green tones
    static let forest = Theme(look: ForestLook(), feel: MinimalFeel())
    
    /// A cyberpunk neon theme with electric colors
    static let neon = Theme(look: NeonLook(), feel: NeumorphicFeel())
    
    /// A warm retro vintage theme with classic tones
    static let retro = Theme(look: RetroLook(), feel: MinimalFeel())
    
    /// An elegant monochrome theme with black and white
    static let monochrome = Theme(look: MonochromeLook(), feel: NeumorphicFeel())
    
    /// A cosmic deep space theme with purple and blue
    static let cosmic = Theme(look: CosmicLook(), feel: NeumorphicFeel())
    
    // MARK: - New Vibrant Themes
    
    /// A desert theme with spice reds and sandy oranges (Dune inspired)
    static let duneDesert = Theme(look: DuneDesertLook(), feel: NeumorphicFeel())
    
    /// An arctic theme with ice blues and crystalline whites
    static let arcticIce = Theme(look: ArcticIceLook(), feel: MinimalFeel())
    
    /// A volcanic theme with molten reds and lava oranges
    static let magmaFire = Theme(look: MagmaFireLook(), feel: NeumorphicFeel())
    
    /// A gentle theme with soft pinks and rose tones
    static let softPink = Theme(look: SoftPinkLook(), feel: MinimalFeel())
    
    /// A natural theme with sage greens and earthy tones
    static let sageGreen = Theme(look: SageGreenLook(), feel: MinimalFeel())
    
    /// A sophisticated theme with deep navy and sapphire blues
    static let midnightBlue = Theme(look: MidnightBlueLook(), feel: NeumorphicFeel())
    
    /// A luxurious theme with warm golds and amber tones
    static let goldenHour = Theme(look: GoldenHourLook(), feel: MinimalFeel())
    
    /// An elegant theme with rich violets and royal purples
    static let royalPurple = Theme(look: RoyalPurpleLook(), feel: NeumorphicFeel())
    
    /// A mystical theme with aurora borealis colors
    static let aurora = Theme(look: AuroraLook(), feel: NeumorphicFeel())
    
    /// A delicate theme with sakura pink and cherry blossom tones
    static let cherryBlossom = Theme(look: CherryBlossomLook(), feel: MinimalFeel())
    
    /// A dreamy theme with soft clouds and pastel sky colors
    static let cloudDream = Theme(look: CloudDreamLook(), feel: MinimalFeel())
    
    /// A profound theme with deep ocean blues and aquatic tones
    static let deepOcean = Theme(look: DeepOceanLook(), feel: NeumorphicFeel())
    
    /// An intense theme with electric neon cyberpunk colors
    static let neonCyberpunk = Theme(look: NeonCyberpunkLook(), feel: NeumorphicFeel())
    
    /// A warm theme with peachy cream and soft coral tones
    static let peachyCream = Theme(look: PeachyCreamLook(), feel: MinimalFeel())
    
    // MARK: - Simple Themes (2-3 colors only)
    
    /// A clean monochromatic theme using only light gray and dark gray
    static let simpleMono = Theme(look: SimpleMonoLook(), feel: MinimalFeel())
    
    /// A minimal blue and orange theme with neutral background
    static let simpleBlueOrange = Theme(look: SimpleBlueOrangeLook(), feel: MinimalFeel())
    
    /// A minimal green and purple theme with light background
    static let simpleGreenPurple = Theme(look: SimpleGreenPurpleLook(), feel: MinimalFeel())
    
    // MARK: - Backwards Compatibility
    
    /// Legacy support for old theme name
    static let audioUINeumorphic = Theme(look: AudioUILook(), feel: NeumorphicFeel())
    
    // MARK: - Theme Collection Helper
    
    /// Array of all available themes for easy iteration
    static let allThemes: [Theme] = [
        .audioUI,
        .darkPro,
        .ocean,
        .sunset,
        .forest,
        .neon,
        .retro,
        .monochrome,
        .cosmic,
        .duneDesert,
        .arcticIce,
        .magmaFire,
        .softPink,
        .sageGreen,
        .midnightBlue,
        .goldenHour,
        .royalPurple,
        .aurora,
        .cherryBlossom,
        .cloudDream,
        .deepOcean,
        .neonCyberpunk,
        .peachyCream,
        .simpleMono,
        .simpleBlueOrange,
        .simpleGreenPurple
    ]
}

// MARK: - Theme Environment Extension
@available(iOS 18.0, macOS 15.0, *)
extension EnvironmentValues {
    public var theme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

@available(iOS 18.0, macOS 15.0, *)
private struct ThemeKey: EnvironmentKey {
    static let defaultValue = Theme.audioUI
}

@available(iOS 18.0, macOS 15.0, *)
extension View {
    public func theme(_ theme: Theme) -> some View {
        environment(\.theme, theme)
    }
}

// MARK: - Component Variants
public enum AudioUIVariant: String, CaseIterable, Sendable {
    case minimal
    case enhanced
    case neumorphic
}

// MARK: - AudioUI View Modifiers
@available(iOS 18.0, macOS 15.0, *)
public struct AudioUIVariantModifier: ViewModifier {
    let variant: AudioUIVariant
    @Environment(\.theme) private var theme
    
    public func body(content: Content) -> some View {
        switch variant {
        case .minimal:
            content
                .environment(\.theme, Theme.audioUI)
        case .enhanced:
            content
                .environment(\.theme, Theme.darkPro)
        case .neumorphic:
            content
                .environment(\.theme, Theme.audioUINeumorphic)
        }
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct AudioUIOnChangeModifier<T: Equatable>: ViewModifier {
    let value: T
    let action: (T) -> Void
    
    public func body(content: Content) -> some View {
        content
            .onChange(of: value) { newValue in
                action(newValue)
            }
    }
}

public extension View {
    @available(iOS 18.0, macOS 15.0, *)
    func audioUIVariant(_ variant: AudioUIVariant) -> some View {
        modifier(AudioUIVariantModifier(variant: variant))
    }
    
    @available(iOS 18.0, macOS 15.0, *)
    func audioUIOnChange<T: Equatable>(of value: T, perform action: @escaping (T) -> Void) -> some View {
        modifier(AudioUIOnChangeModifier(value: value, action: action))
    }
}
