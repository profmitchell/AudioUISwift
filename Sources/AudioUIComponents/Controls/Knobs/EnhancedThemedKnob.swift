//
//  EnhancedThemedKnob.swift
//  AudioUIComponents
//
//  A beautiful, theme-integrated knob component with professional aesthetics
//

import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct EnhancedThemedKnob: View {
    @Binding public var value: Double
    public let label: String
    public let size: CGFloat
    public let showValue: Bool
    public let onValueChange: ((Double) -> Void)?
    
    @State private var isDragging = false
    @State private var dragStartValue: Double = 0
    @Environment(\.theme) var theme
    
    public init(
        value: Binding<Double>,
        label: String = "",
        size: CGFloat = 120,
        showValue: Bool = true,
        onValueChange: ((Double) -> Void)? = nil
    ) {
        self._value = value
        self.label = label
        self.size = size
        self.showValue = showValue
        self.onValueChange = onValueChange
    }
    
    public var body: some View {
        VStack(spacing: size * 0.15) {
            // Label
            if !label.isEmpty {
                Text(label.uppercased())
                    .font(.caption)
                    .fontWeight(.medium)
                    .themedText(.secondary)
                    .tracking(1.2)
            }
            
            // Value display
            if showValue {
                Text("\(Int(value * 100))%")
                    .font(.system(size: size * 0.15, weight: .bold, design: .monospaced))
                    .themedText(.primary)
            }
            
            // Knob body
            ZStack {
                // Hover/active glow effect - positioned underneath
                if isDragging {
                    Circle()
                        .fill(theme.look.glowPrimary)
                        .frame(width: size * 1.1, height: size * 1.1)
                        .blur(radius: size * 0.08)
                        .opacity(0.6)
                        .animation(.easeInOut(duration: 0.2), value: isDragging)
                }
                
                // Main knob body with neumorphic shadows
                Circle()
                    .fill(theme.look.surface)
                    .frame(width: size, height: size)
                    .shadow(color: theme.look.shadowLight, radius: size * 0.125, x: -size * 0.08, y: -size * 0.08)
                    .shadow(color: theme.look.shadowDark, radius: size * 0.125, x: size * 0.08, y: size * 0.08)
                
                // Value progress ring
                Circle()
                    .trim(from: 0.125, to: 0.125 + (value * 0.75))
                    .stroke(
                        theme.look.accent.opacity(0.3),
                        style: StrokeStyle(lineWidth: size * 0.08, lineCap: .round)
                    )
                    .frame(width: size * 0.75, height: size * 0.75)
                    .rotationEffect(.degrees(90))
                    .animation(.spring(response: 0.5, dampingFraction: 0.8), value: value)
                
                // Center indicator well
                Circle()
                    .fill(theme.look.surface)
                    .frame(width: size * 0.5, height: size * 0.5)
                    .shadow(color: theme.look.shadowLight, radius: isDragging ? size * 0.05 : size * 0.07, x: isDragging ? -size * 0.03 : -size * 0.05, y: isDragging ? -size * 0.03 : -size * 0.05)
                    .shadow(color: theme.look.shadowDark, radius: isDragging ? size * 0.05 : size * 0.07, x: isDragging ? size * 0.03 : size * 0.05, y: isDragging ? size * 0.03 : size * 0.05)
                    .overlay(
                        // Position indicator dot
                        Circle()
                            .fill(theme.look.accent)
                            .frame(width: size * 0.03, height: size * 0.03)
                            .offset(y: -size * 0.17)
                            .rotationEffect(.degrees(value * 270 - 135))
                            .animation(.spring(response: 0.3, dampingFraction: 0.8), value: value)
                    )
            }
            .scaleEffect(isDragging ? 0.98 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.9), value: isDragging)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { drag in
                        if !isDragging {
                            isDragging = true
                            dragStartValue = value
                        }
                        let delta = -drag.translation.height * 0.005
                        let newValue = min(max(dragStartValue + delta, 0), 1)
                        value = newValue
                        onValueChange?(newValue)
                    }
                    .onEnded { _ in 
                        isDragging = false 
                    }
            )
        }
    }
}

// MARK: - Professional Variants

@available(iOS 18.0, macOS 15.0, *)
public extension EnhancedThemedKnob {
    /// Professional minimal variant
    static func minimal(
        value: Binding<Double>,
        label: String = "",
        size: CGFloat = 80
    ) -> some View {
        EnhancedThemedKnob(value: value, label: label, size: size, showValue: false)
            .audioUIVariant(.minimal)
    }
    
    /// Enhanced variant with full features
    static func enhanced(
        value: Binding<Double>,
        label: String = "",
        size: CGFloat = 120,
        onValueChange: ((Double) -> Void)? = nil
    ) -> some View {
        EnhancedThemedKnob(value: value, label: label, size: size, showValue: true, onValueChange: onValueChange)
            .audioUIVariant(.enhanced)
    }
    
    /// Large studio variant
    static func studio(
        value: Binding<Double>,
        label: String = "",
        size: CGFloat = 150,
        onValueChange: ((Double) -> Void)? = nil
    ) -> some View {
        EnhancedThemedKnob(value: value, label: label, size: size, showValue: true, onValueChange: onValueChange)
            .audioUIVariant(.neumorphic)
    }
}

// MARK: - Preview
@available(iOS 18.0, macOS 15.0, *)
public struct EnhancedThemedKnob_Previews: PreviewProvider {
    @State static var value1: Double = 0.5
    @State static var value2: Double = 0.3
    @State static var value3: Double = 0.7
    
    public static var previews: some View {
        VStack(spacing: 40) {
            HStack(spacing: 30) {
                EnhancedThemedKnob.minimal(value: $value1, label: "Volume")
                EnhancedThemedKnob.enhanced(value: $value2, label: "Filter")
                EnhancedThemedKnob.studio(value: $value3, label: "Master")
            }
            
            HStack(spacing: 30) {
                EnhancedThemedKnob(value: $value1, label: "Dark Pro", size: 100)
                    .theme(.darkPro)
                
                EnhancedThemedKnob(value: $value2, label: "Sunset", size: 100)
                    .theme(.ocean)
                
                EnhancedThemedKnob(value: $value3, label: "Ocean", size: 100)
                    .theme(.ocean)
            }
        }
        .padding(40)
       
    }
} 