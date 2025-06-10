import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct SliderMinimal3: View {
    @Binding var value: Double
    @State private var isDragging = false
    @Environment(\.theme) private var theme
    
    // Enhanced theme-based colors - utilizing rich palette
    private var primaryColor: Color { theme.look.textPrimary }
    private var backgroundColor: Color { theme.look.surfacePrimary }
    private var accentColor: Color { theme.look.surfaceSecondary }
    
    // Additional rich color palette utilization
    private var brandPrimary: Color { theme.look.brandPrimary }
    private var brandSecondary: Color { theme.look.brandSecondary }
    private var accent: Color { theme.look.accent }
    private var sliderTrack: Color { theme.look.sliderTrack }
    private var sliderThumb: Color { theme.look.sliderThumb }
    private var interactiveActive: Color { theme.look.interactiveActive }
    private var neutralHighlight: Color { theme.look.neutralHighlight }
    private var glowPrimary: Color { theme.look.glowPrimary }
    
    public init(value: Binding<Double>) {
        self._value = value
    }
    
    public var body: some View {
        HStack(spacing: 60) {
            // Vertical slider
            ZStack(alignment: .bottom) {
                // Track
                RoundedRectangle(cornerRadius: 2)
                    .fill(accentColor)
                    .frame(width: 60, height: 280)
                
                // Fill
                RoundedRectangle(cornerRadius: 2)
                    .fill(primaryColor)
                    .frame(width: isDragging ? 64 : 60, height: 280 * value)
                
                // Notches
                VStack(spacing: 0) {
                    ForEach(0..<5) { i in
                        Spacer()
                        Rectangle()
                            .fill(backgroundColor)
                            .frame(width: 80, height: 1)
                        if i < 4 { Spacer() }
                    }
                }
                .frame(height: 280)
                
                // Handle line
                Rectangle()
                    .fill(backgroundColor)
                    .frame(width: 100, height: 3)
                    .offset(y: -280 * value + 1.5)
            }
            .animation(.smooth(duration: 0.15), value: isDragging)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { drag in
                        isDragging = true
                        let height: CGFloat = 280
                        let location = height - drag.location.y
                        value = max(0, min(1, location / height))
                    }
                    .onEnded { _ in
                        isDragging = false
                    }
            )
            
            // Side indicators
            VStack(alignment: .leading, spacing: 20) {
                Text("\(Int(value * 100))")
                    .font(.system(size: 36, weight: .ultraLight, design: .default))
                    .foregroundColor(primaryColor)
                
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(["MAX", "HIGH", "MID", "LOW", "MIN"], id: \.self) { label in
                        Text(label)
                            .font(.system(size: 9, weight: .medium, design: .default))
                            .foregroundColor(brandPrimary.opacity(0.6))
                            .tracking(1)
                    }
                }
            }
        }
        .padding(40)
        .frame(width: 280, height: 360)
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct SliderMinimal3_Previews: PreviewProvider {
    @State static var value: Double = 0.5
    
    public static var previews: some View {
        SliderMinimal3(value: $value)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
