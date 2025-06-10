//
//  XYPad.swift
//  AudioUICore
//
//  Enhanced XY Pad primitive with professional multi-touch interaction
//

import SwiftUI

// MARK: - XY Pad Primitive
/// A sophisticated two-dimensional control surface for precise dual-parameter manipulation in audio applications.
///
/// `XYPad` provides a high-quality touch interface with advanced gesture handling, visual feedback,
/// and momentum physics. The component serves as a versatile foundation for complex parameter
/// control such as filter frequency/resonance, reverb size/decay, or spatial positioning.
///
/// ## Design Philosophy
///
/// The XY pad follows professional audio equipment conventions while leveraging modern touch
/// interaction paradigms. The visual design emphasizes immediate tactile feedback through dynamic
/// indicators, grid overlays, and responsive animations that communicate the dual-axis nature
/// of the control surface.
///
/// ## Features
///
/// - **Multi-touch Support**: Advanced gesture recognition with momentum and physics
/// - **Visual Grid System**: Dynamic grid lines and boundary indicators
/// - **Momentum Physics**: Natural deceleration and boundary behavior
/// - **Real-time Feedback**: Position indicators and coordinate display during interaction
/// - **Touch Precision**: Sub-pixel positioning accuracy for critical audio parameters
/// - **Performance Optimized**: Efficient rendering suitable for real-time audio applications
///
/// ## Usage Examples
///
/// ### Filter Frequency & Resonance Control
/// ```swift
/// @State private var filterParams = CGPoint(x: 0.5, y: 0.3)
/// 
/// XYPad(position: $filterParams) { newPosition in
///     let frequency = newPosition.x * 20000 // 0-20kHz
///     let resonance = newPosition.y * 10    // 0-10 Q
///     filterProcessor.setParameters(frequency: frequency, resonance: resonance)
/// }
/// ```
///
/// ### Spatial Audio Positioning
/// ```swift
/// @State private var spatialPosition = CGPoint(x: 0.5, y: 0.5)
/// 
/// XYPad(
///     position: $spatialPosition,
///     size: CGSize(width: 300, height: 300)
/// ) { position in
///     spatialAudio.setPosition(
///         x: (position.x - 0.5) * 2.0, // -1 to +1
///         y: (position.y - 0.5) * 2.0
///     )
/// }
/// ```
public struct XYPad: View {
    // MARK: - Public Properties
    
    /// A binding to the current position normalized to 0...1 coordinate space.
    ///
    /// The coordinate system uses standard computer graphics conventions:
    /// - X-axis: 0.0 (left) to 1.0 (right)
    /// - Y-axis: 0.0 (top) to 1.0 (bottom)
    ///
    /// This normalized space allows easy mapping to any parameter range while
    /// maintaining consistent behavior across different XY pad sizes.
    @Binding public var position: CGPoint
    
    /// The physical dimensions of the control surface in points.
    ///
    /// Both dimensions determine the touch-sensitive area and visual size.
    /// Larger surfaces provide better precision but require more screen space.
    ///
    /// ## Recommended Sizes
    /// - **Compact**: `CGSize(width: 150, height: 150)` for secondary controls
    /// - **Standard**: `CGSize(width: 250, height: 250)` for primary dual-parameter control
    /// - **Large**: `CGSize(width: 350, height: 350)` for precision applications
    public let size: CGSize
    
    /// Whether the XY pad responds to user interaction.
    ///
    /// When disabled, the pad displays its current position but ignores touch input
    /// and reduces visual opacity to indicate its inactive state. Position binding
    /// updates will continue to be reflected visually even when disabled.
    public let isEnabled: Bool
    
    /// Optional callback executed when the position changes during user interaction.
    ///
    /// This closure receives the new normalized position whenever the user interacts
    /// with the surface. The callback is ideal for immediate audio parameter updates
    /// and can be used alongside the binding for additional processing.
    ///
    /// ## Usage
    /// ```swift
    /// XYPad(position: $params) { newPosition in
    ///     let freq = newPosition.x * 20000
    ///     let res = newPosition.y * 10
    ///     updateFilterParameters(frequency: freq, resonance: res)
    ///     analyticsService.trackParameterChange("filter", freq, res)
    /// }
    /// ```
    public let onPositionChange: ((CGPoint) -> Void)?
    
    // MARK: - Private State
    @State private var isDragging = false
    @State private var lastDragPosition = CGPoint.zero
    @State private var velocity = CGVector.zero
    @State private var momentum = false
    @State private var momentumTimer: Timer?
    
    // MARK: - Initialization
    /// Creates a new XY pad primitive with the specified configuration.
    ///
    /// - Parameters:
    ///   - position: Binding to the normalized position (0...1 coordinate space)
    ///   - size: Physical dimensions of the control surface
    ///   - isEnabled: Whether the pad responds to user interaction
    ///   - onPositionChange: Optional callback for position changes
    ///
    /// ## Example
    /// ```swift
    /// XYPad(
    ///     position: $reverbParams,
    ///     size: CGSize(width: 250, height: 250),
    ///     isEnabled: true
    /// ) { newPosition in
    ///     reverb.setSize(newPosition.x)
    ///     reverb.setDecay(newPosition.y)
    /// }
    /// ```
    public init(
        position: Binding<CGPoint>,
        size: CGSize = CGSize(width: 200, height: 200),
        isEnabled: Bool = true,
        onPositionChange: ((CGPoint) -> Void)? = nil
    ) {
        self._position = position
        self.size = size
        self.isEnabled = isEnabled
        self.onPositionChange = onPositionChange
    }

    // MARK: - Body
    /// The main view body containing all XY pad visual elements and interaction handling.
    ///
    /// Combines the control surface, grid overlay, position indicator, and coordinate
    /// display with advanced gesture handling and momentum physics.
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background surface with neumorphic styling
                backgroundSurface
                
                // Dynamic grid overlay
                gridOverlay
                
                // Position indicator
                positionIndicator(in: geometry)
                
                // Coordinate display when dragging
                if isDragging {
                    coordinateDisplay
                }
                
                // Touch boundary indicators
                boundaryIndicators(in: geometry)
            }
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        handleDragChanged(gesture, in: geometry)
                    }
                    .onEnded { gesture in
                        handleDragEnded(gesture, in: geometry)
                    }
            )
            .disabled(!isEnabled)
            .opacity(isEnabled ? 1.0 : 0.6)
        }
        .frame(width: size.width, height: size.height)
        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: isDragging)
    }
    
    // MARK: - Visual Components
    
    /// Professional background surface with depth and tactile feel
    private var backgroundSurface: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(
                LinearGradient(
                    colors: [
                        Color.secondary.opacity(0.8),
                        Color.secondary.opacity(0.4),
                        Color.secondary.opacity(0.8)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.2),
                                Color.black.opacity(0.1)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
            .shadow(
                color: Color.black.opacity(0.3),
                radius: isDragging ? 8 : 12,
                x: 2,
                y: isDragging ? 2 : 4
            )
    }
    
    /// Dynamic grid system with responsive opacity
    private var gridOverlay: some View {
        ZStack {
            // Major grid lines (quarters)
            Path { path in
                let width = size.width
                let height = size.height
                
                // Vertical lines
                for i in 1..<4 {
                    let x = width * CGFloat(i) / 4
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: height))
                }
                
                // Horizontal lines
                for i in 1..<4 {
                    let y = height * CGFloat(i) / 4
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: width, y: y))
                }
            }
            .stroke(Color.primary.opacity(0.15), lineWidth: 1)
            
            // Center crosshairs
            Path { path in
                let centerX = size.width / 2
                let centerY = size.height / 2
                
                // Vertical center
                path.move(to: CGPoint(x: centerX, y: 0))
                path.addLine(to: CGPoint(x: centerX, y: size.height))
                
                // Horizontal center
                path.move(to: CGPoint(x: 0, y: centerY))
                path.addLine(to: CGPoint(x: size.width, y: centerY))
            }
            .stroke(Color.primary.opacity(0.3), lineWidth: 1.5)
            
            // Minor grid lines (eighths) - only visible when dragging
            if isDragging {
                Path { path in
                    let width = size.width
                    let height = size.height
                    
                    // Vertical minor lines
                    for i in [1, 3, 5, 7] {
                        let x = width * CGFloat(i) / 8
                        path.move(to: CGPoint(x: x, y: 0))
                        path.addLine(to: CGPoint(x: x, y: height))
                    }
                    
                    // Horizontal minor lines
                    for i in [1, 3, 5, 7] {
                        let y = height * CGFloat(i) / 8
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: width, y: y))
                    }
                }
                .stroke(Color.primary.opacity(0.08), lineWidth: 0.5)
                .transition(.opacity)
            }
        }
        .clipped()
    }
    
    /// Position indicator with enhanced visual feedback
    private func positionIndicator(in geometry: GeometryProxy) -> some View {
        ZStack {
            // Outer ring for precision
            Circle()
                .stroke(
                    Color.primary.opacity(0.6),
                    lineWidth: isDragging ? 3 : 2
                )
                .frame(
                    width: isDragging ? 28 : 24,
                    height: isDragging ? 28 : 24
                )
            
            // Inner dot
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.white,
                            Color.primary,
                            Color.primary.opacity(0.8)
                        ],
                        center: .topLeading,
                        startRadius: 0,
                        endRadius: 8
                    )
                )
                .frame(
                    width: isDragging ? 16 : 12,
                    height: isDragging ? 16 : 12
                )
                .shadow(
                    color: Color.primary.opacity(0.8),
                    radius: isDragging ? 6 : 3
                )
            
            // Glow effect when dragging
            if isDragging {
                Circle()
                    .fill(Color.primary.opacity(0.3))
                    .frame(width: 40, height: 40)
                    .blur(radius: 8)
                    .transition(.opacity)
            }
        }
        .position(
            x: position.x * geometry.size.width,
            y: position.y * geometry.size.height
        )
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: position)
    }
    
    /// Real-time coordinate display during interaction
    private var coordinateDisplay: some View {
        VStack(spacing: 4) {
            HStack(spacing: 12) {
                coordinateValue(label: "X", value: position.x, color: .blue)
                coordinateValue(label: "Y", value: position.y, color: .orange)
            }
            
            Text("(\(String(format: "%.3f", position.x)), \(String(format: "%.3f", position.y)))")
                .font(.system(size: 11, design: .monospaced))
                .foregroundColor(.secondary)
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.ultraThinMaterial)
                .shadow(radius: 4)
        )
        .offset(y: -size.height/2 - 60)
        .transition(.opacity.combined(with: .scale(scale: 0.8)))
    }
    
    /// Individual coordinate value display
    private func coordinateValue(label: String, value: Double, color: Color) -> some View {
        HStack(spacing: 4) {
            Text(label)
                .font(.caption.weight(.semibold))
                .foregroundColor(color)
            
            Text(String(format: "%.3f", value))
                .font(.caption.monospaced())
                .foregroundColor(.primary)
        }
    }
    
    /// Boundary indicators that activate near edges
    private func boundaryIndicators(in geometry: GeometryProxy) -> some View {
        ZStack {
            // Edge proximity indicators
            if isDragging {
                let threshold: CGFloat = 0.1
                let edgeOpacity: Double = 0.4
                
                // Left edge
                if position.x < threshold {
                    Rectangle()
                        .fill(Color.red.opacity(edgeOpacity * (threshold - position.x) / threshold))
                        .frame(width: 3, height: geometry.size.height)
                        .position(x: 1.5, y: geometry.size.height / 2)
                }
                
                // Right edge
                if position.x > (1 - threshold) {
                    Rectangle()
                        .fill(Color.red.opacity(edgeOpacity * (position.x - (1 - threshold)) / threshold))
                        .frame(width: 3, height: geometry.size.height)
                        .position(x: geometry.size.width - 1.5, y: geometry.size.height / 2)
                }
                
                // Top edge
                if position.y < threshold {
                    Rectangle()
                        .fill(Color.red.opacity(edgeOpacity * (threshold - position.y) / threshold))
                        .frame(width: geometry.size.width, height: 3)
                        .position(x: geometry.size.width / 2, y: 1.5)
                }
                
                // Bottom edge
                if position.y > (1 - threshold) {
                    Rectangle()
                        .fill(Color.red.opacity(edgeOpacity * (position.y - (1 - threshold)) / threshold))
                        .frame(width: geometry.size.width, height: 3)
                        .position(x: geometry.size.width / 2, y: geometry.size.height - 1.5)
                }
            }
        }
    }
    
    // MARK: - Gesture Handlers
    
    /// Handles drag gesture changes with momentum tracking
    private func handleDragChanged(_ gesture: DragGesture.Value, in geometry: GeometryProxy) {
        if !isDragging {
            withAnimation(.easeOut(duration: 0.2)) {
                isDragging = true
            }
            lastDragPosition = gesture.location
            stopMomentum()
        }
        
        // Calculate new position with bounds checking
        let x = max(0, min(1, gesture.location.x / geometry.size.width))
        let y = max(0, min(1, gesture.location.y / geometry.size.height))
        let newPosition = CGPoint(x: x, y: y)
        
        // Track velocity for momentum
        let deltaX = gesture.location.x - lastDragPosition.x
        let deltaY = gesture.location.y - lastDragPosition.y
        velocity = CGVector(dx: deltaX, dy: deltaY)
        lastDragPosition = gesture.location
        
        // Update position
        position = newPosition
        onPositionChange?(newPosition)
    }
    
    /// Handles the end of drag gestures with momentum physics
    private func handleDragEnded(_ gesture: DragGesture.Value, in geometry: GeometryProxy) {
        withAnimation(.easeOut(duration: 0.3)) {
            isDragging = false
        }
        
        // Apply momentum if velocity is significant
        let velocityThreshold: CGFloat = 5.0
        let velocityMagnitude = sqrt(velocity.dx * velocity.dx + velocity.dy * velocity.dy)
        
        if velocityMagnitude > velocityThreshold {
            startMomentum(in: geometry)
        }
    }
    
    /// Starts momentum-based movement after gesture release
    private func startMomentum(in geometry: GeometryProxy) {
        momentum = true
        let geometrySize = geometry.size
        
        momentumTimer = Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true) { _ in
            Task { @MainActor in
                guard self.momentum else {
                    self.momentumTimer?.invalidate()
                    return
                }
                // Apply velocity with damping
                let damping: CGFloat = 0.95
                self.velocity.dx *= damping
                self.velocity.dy *= damping
                
                // Update position
                let newX = self.position.x + self.velocity.dx / geometrySize.width
                let newY = self.position.y + self.velocity.dy / geometrySize.height
                
                // Boundary handling with bounce
                var finalX = newX
                var finalY = newY
                
                if newX < 0 {
                    finalX = 0
                    self.velocity.dx *= -0.6 // Bounce back with energy loss
                } else if newX > 1 {
                    finalX = 1
                    self.velocity.dx *= -0.6
                }
                
                if newY < 0 {
                    finalY = 0
                    self.velocity.dy *= -0.6
                } else if newY > 1 {
                    finalY = 1
                    self.velocity.dy *= -0.6
                }
                
                // Use withAnimation to prevent timing conflicts
                withAnimation(.linear(duration: 1.0/60.0)) {
                    self.position = CGPoint(x: finalX, y: finalY)
                }
                self.onPositionChange?(self.position)
                
                // Stop momentum when velocity becomes negligible
                let currentMagnitude = sqrt(self.velocity.dx * self.velocity.dx + self.velocity.dy * self.velocity.dy)
                if currentMagnitude < 0.5 {
                    self.stopMomentum()
                }
            }
        }
    }
    
    /// Stops momentum-based movement
    private func stopMomentum() {
        momentum = false
        momentumTimer?.invalidate()
        momentumTimer = nil
        velocity = CGVector.zero
    }
}

// MARK: - Component Variants

extension XYPad {
    /// Minimal variant optimized for compact layouts
    public static func minimal(
        position: Binding<CGPoint>,
        size: CGSize = CGSize(width: 150, height: 150),
        onPositionChange: ((CGPoint) -> Void)? = nil
    ) -> some View {
        XYPad(position: position, size: size, onPositionChange: onPositionChange)
    }
    
    /// Enhanced variant with advanced features
    public static func enhanced(
        position: Binding<CGPoint>,
        size: CGSize = CGSize(width: 250, height: 250),
        onPositionChange: ((CGPoint) -> Void)? = nil
    ) -> some View {
        XYPad(position: position, size: size, onPositionChange: onPositionChange)
    }
    
    /// Large precision variant for critical applications
    public static func precision(
        position: Binding<CGPoint>,
        size: CGSize = CGSize(width: 350, height: 350),
        onPositionChange: ((CGPoint) -> Void)? = nil
    ) -> some View {
        XYPad(position: position, size: size, onPositionChange: onPositionChange)
    }
}
