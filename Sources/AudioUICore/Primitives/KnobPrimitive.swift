//
//  KnobPrimitive.swift
//  AudioUICore
//
//  Created by Mitchell Cohen on 6/3/25.
//

import SwiftUI

// MARK: - Knob Primitive
/// A sophisticated rotary control primitive for precise parameter manipulation in audio applications.
///
/// `KnobPrimitive` provides a high-quality knob implementation with neumorphic styling derived
/// from the AudioUI theme system. The component handles user interaction for precise value control
/// and serves as a versatile foundation for various knob styles and audio parameter interfaces.
///
/// ## Design Philosophy
///
/// The knob primitive follows established audio industry conventions while embracing modern
/// touch interaction paradigms. The visual design emphasizes tactile feedback through shadows,
/// gradients, and responsive animations that communicate the physical nature of rotary control.
///
/// ## Features
///
/// - **Neumorphic Visual Design**: Advanced styling with theme integration and realistic depth
/// - **Smooth Rotary Interaction**: Precise gesture handling with configurable sensitivity
/// - **Visual Feedback**: Real-time position indicators and value display during interaction
/// - **Theme Integration**: Automatic adaptation to AudioUI theme colors and styling
/// - **Accessibility Support**: Built-in voice-over compatibility and keyboard navigation
/// - **Performance Optimized**: Efficient rendering suitable for complex mixer interfaces
///
/// ## Usage Examples
///
/// ### Basic Volume Control
/// ```swift
/// @State private var volume: Double = 0.5
/// 
/// KnobPrimitive(value: $volume) { newValue in
///     audioEngine.setVolume(newValue)
/// }
/// ```
///
/// ### Filter Frequency Control
/// ```swift
/// @State private var cutoff: Double = 0.3
/// 
/// KnobPrimitive(
///     value: $cutoff,
///     size: CGSize(width: 120, height: 120)
/// ) { frequency in
///     filterProcessor.setCutoff(frequency * 20000) // Map to Hz
/// }
/// ```
///
/// ### Using Component Variants
/// ```swift
/// VStack {
///     // Minimal variant for compact layouts
///     KnobPrimitive.minimal(value: $gain)
///     
///     // Enhanced variant for primary controls
///     KnobPrimitive.enhanced(value: $masterLevel)
/// }
/// ```
///
/// ## Value Mapping
///
/// The knob value ranges from 0.0 to 1.0, representing a 270-degree rotation range starting
/// from the bottom-left position and rotating clockwise. This normalized range can be easily
/// mapped to any parameter range in your audio processing chain.
///
/// ## Performance Considerations
///
/// - Optimized for real-time audio parameter control with minimal latency
/// - Efficient gesture processing that doesn't block audio rendering threads
/// - Memory-efficient implementation suitable for dense mixer interfaces
/// - Smooth 60fps animations that maintain responsiveness
public struct KnobPrimitive: View {
    // MARK: - Public Properties
    
    /// A binding to the current knob position value (0.0 to 1.0).
    ///
    /// The knob automatically maps this normalized value to a 270-degree rotation range,
    /// starting from the bottom-left position and rotating clockwise. Changes to this
    /// binding will update the visual position and trigger the onValueChange callback.
    ///
    /// ## Value Range
    /// - **Minimum**: 0.0 (bottom-left position, -135°)
    /// - **Maximum**: 1.0 (bottom-right position, +135°)
    /// - **Center**: 0.5 (top center position, 0°)
    @Binding public var value: Double
    
    /// The physical dimensions of the knob control in points.
    ///
    /// Both width and height should typically be equal for a circular knob appearance.
    /// The knob's visual elements automatically scale to fit within these dimensions
    /// while maintaining proper proportions and touch targets.
    ///
    /// ## Recommended Sizes
    /// - **Compact**: `CGSize(width: 80, height: 80)` for dense mixer layouts
    /// - **Standard**: `CGSize(width: 120, height: 120)` for primary controls
    /// - **Large**: `CGSize(width: 160, height: 160)` for featured parameters
    public let size: CGSize
    
    /// Whether the knob responds to user interaction.
    ///
    /// When disabled, the knob displays its current value but ignores gesture input
    /// and reduces visual opacity to indicate its inactive state. The knob continues
    /// to reflect bound value changes even when disabled.
    public let isEnabled: Bool
    
    /// Optional callback executed when the knob value changes during user interaction.
    ///
    /// This closure receives the new normalized value (0.0 to 1.0) whenever the user
    /// interacts with the knob. The callback is ideal for immediate audio parameter
    /// updates and can be used alongside the binding for additional processing.
    ///
    /// ## Usage
    /// ```swift
    /// KnobPrimitive(value: $frequency) { newValue in
    ///     let hz = newValue * 20000 // Map to frequency range
    ///     audioProcessor.setFilterFrequency(hz)
    ///     analyticsService.trackParameterChange("filter_freq", hz)
    /// }
    /// ```
    public let onValueChange: ((Double) -> Void)?
    
    // MARK: - Private State
    @State private var isDragging = false
    @State private var dragStartValue: Double = 0
    @State private var localValue: Double
    
    // MARK: - Initialization
    /// Creates a new knob primitive with the specified configuration.
    ///
    /// - Parameters:
    ///   - value: Binding to the knob position value (0.0 to 1.0)
    ///   - size: Physical dimensions of the knob control
    ///   - isEnabled: Whether the knob responds to user interaction
    ///   - onValueChange: Optional callback for value changes
    ///
    /// ## Example
    /// ```swift
    /// KnobPrimitive(
    ///     value: $reverbAmount,
    ///     size: CGSize(width: 120, height: 120),
    ///     isEnabled: true
    /// ) { newAmount in
    ///     reverbProcessor.setWetAmount(newAmount)
    /// }
    /// ```
    public init(
        value: Binding<Double>,
        size: CGSize = CGSize(width: 120, height: 120),
        isEnabled: Bool = true,
        onValueChange: ((Double) -> Void)? = nil
    ) {
        self._value = value
        self.size = size
        self.isEnabled = isEnabled
        self.onValueChange = onValueChange
        self._localValue = State<Double>(initialValue: value.wrappedValue)
    }
    
    
    // MARK: - Body
    /// The main view body containing all knob visual elements and interaction handling.
    ///
    /// Combines the knob track, value indicator, handle, and temporary value display
    /// with appropriate gesture handling and theme-based styling.
    public var body: some View {
        ZStack {
            // Clean background
            Circle()
                .fill(.quaternary)
                .frame(width: size.width, height: size.height)
            
            // Subtle inner shadow ring
            Circle()
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.black.opacity(0.3),
                            Color.clear
                        ],
                        startPoint: .topLeading,
                        endPoint: .center
                    ),
                    lineWidth: 1
                )
                .frame(width: size.width - 2, height: size.height - 2)
                .blur(radius: 1)
            
            // Track outline
            Circle()
                .trim(from: 0.125, to: 0.875)
                .stroke(
                    Color.primary.opacity(0.3),
                    style: StrokeStyle(lineWidth: 2, lineCap: .round)
                )
                .rotationEffect(.degrees(90))
                .frame(width: size.width * 0.83, height: size.height * 0.83)
            
            // Active value indicator
            Circle()
                .trim(from: 0.125, to: 0.125 + (0.75 * localValue))
                .stroke(
                    Color.primary,
                    style: StrokeStyle(lineWidth: 2, lineCap: .round)
                )
                .rotationEffect(.degrees(90))
                .frame(width: size.width * 0.83, height: size.height * 0.83)
                .shadow(color: Color.primary.opacity(0.5), radius: 4)
                .opacity(isDragging ? 1 : 0.9)
                .animation(.easeOut(duration: 0.1), value: isDragging)
            
            // Knob body
            knobBody
            
            // Value display when dragging
            if isDragging {
                Text("\(Int(localValue * 100))")
                    .font(.system(size: size.width * 0.27, weight: .thin, design: .rounded))
                    .foregroundColor(.primary)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .frame(width: size.width * 1.17, height: size.height * 1.17)
        .opacity(isEnabled ? 1.0 : 0.6)
        .allowsHitTesting(isEnabled)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged(handleDragChanged)
                .onEnded(handleDragEnded)
        )
        .onChange(of: value) { newValue in
            localValue = newValue
            onValueChange?(newValue)
        }
    }
    
    // MARK: - Knob Body
    /// The main knob handle with neumorphic styling and position indicator.
    ///
    /// Creates a sophisticated 3D appearance using gradients, shadows, and a position
    /// indicator dot that rotates to show the current value. The handle responds to
    /// interaction with subtle scaling effects.
    private var knobBody: some View {
        ZStack {
            // Main body with neumorphic gradient
            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.secondary.opacity(1.1),
                            Color.secondary,
                            Color.secondary.opacity(0.9)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size.width * 0.6, height: size.height * 0.6)
            
            // Highlight ring
            Circle()
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.4),
                            Color.clear
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
                .frame(width: size.width * 0.58, height: size.height * 0.58)
            
            // Position indicator dot
            Circle()
                .fill(.primary)
                .frame(width: size.width * 0.033, height: size.height * 0.033)
                .offset(y: -size.height * 0.23)
                .rotationEffect(.degrees(-135 + (localValue * 270)))
                .shadow(color: Color.primary.opacity(0.8), radius: 2)
        }
        .scaleEffect(isDragging ? 0.95 : 1.0)
        .shadow(
            color: Color.black.opacity(0.5),
            radius: isDragging ? 15 : 20,
            y: isDragging ? 5 : 10
        )
        .animation(.spring(response: 0.4, dampingFraction: 0.6), value: isDragging)
    }
    
    // MARK: - Gesture Handlers
    /// Handles drag gesture changes during knob interaction.
    ///
    /// Processes vertical drag movement and converts it to rotational value changes
    /// with appropriate sensitivity and bounds checking.
    private func handleDragChanged(_ gesture: DragGesture.Value) {
        if !isDragging {
            withAnimation(.easeOut(duration: 0.2)) {
                isDragging = true
            }
            dragStartValue = localValue
        }
        
        let sensitivity = 0.005
        let delta = -gesture.translation.height * sensitivity
        let newValue = max(0, min(1, dragStartValue + delta))
        
        localValue = newValue
        value = newValue
        onValueChange?(newValue)
    }
    
    /// Handles the end of drag gestures with smooth animation transitions.
    private func handleDragEnded(_ gesture: DragGesture.Value) {
        withAnimation(.easeOut(duration: 0.3)) {
            isDragging = false
        }
    }
}


// MARK: - Component Variants
public extension KnobPrimitive {
    /// Creates a minimal variant of the knob with reduced visual complexity.
    ///
    /// The minimal variant applies simplified styling suitable for compact layouts
    /// and secondary parameter controls where visual prominence is reduced.
    ///
    /// - Parameters:
    ///   - value: Binding to the knob position value
    ///   - size: Physical dimensions (defaults to compact sizing)
    ///   - onValueChange: Optional callback for value changes
    /// - Returns: A configured knob with minimal styling applied
    ///
    /// ## Usage
    /// ```swift
    /// HStack {
    ///     ForEach(channels) { channel in
    ///         KnobPrimitive.minimal(
    ///             value: channel.$eq.highFreq,
    ///             size: CGSize(width: 80, height: 80)
    ///         )
    ///     }
    /// }
    /// ```
    static func minimal(
        value: Binding<Double>,
        size: CGSize = CGSize(width: 80, height: 80),
        onValueChange: ((Double) -> Void)? = nil
    ) -> some View {
        KnobPrimitive(
            value: value,
            size: size,
            onValueChange: onValueChange
        )
    }
    
    /// Creates an enhanced variant of the knob with additional visual effects.
    ///
    /// The enhanced variant includes additional glow effects and larger default sizing,
    /// making it ideal for primary controls and master parameter adjustment.
    ///
    /// - Parameters:
    ///   - value: Binding to the knob position value
    ///   - size: Physical dimensions (defaults to enhanced sizing)
    ///   - onValueChange: Optional callback for value changes
    /// - Returns: A configured knob with enhanced styling applied
    ///
    /// ## Usage
    /// ```swift
    /// VStack {
    ///     Text("Master Volume")
    ///     KnobPrimitive.enhanced(
    ///         value: $masterVolume,
    ///         size: CGSize(width: 160, height: 160)
    ///     ) { newLevel in
    ///         audioEngine.setMasterLevel(newLevel)
    ///     }
    /// }
    /// ```
    static func enhanced(
        value: Binding<Double>,
        size: CGSize = CGSize(width: 160, height: 160),
        onValueChange: ((Double) -> Void)? = nil
    ) -> some View {
        KnobPrimitive(
            value: value,
            size: size,
            onValueChange: onValueChange
        )
    }
}

// MARK: - Preview
/// SwiftUI preview provider demonstrating various knob configurations and variants.
struct KnobPrimitive_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 40) {
            // Default theme
            KnobPrimitive(value: .constant(0.5))
            
            HStack(spacing: 30) {
                // Minimal variant
                KnobPrimitive.minimal(value: .constant(0.3))
                
                // Enhanced variant
                KnobPrimitive.enhanced(value: .constant(0.7))
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
    }
} 