import SwiftUI
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *)
public struct SliderMinimal2: View {
    @Binding var value: Double
    @State private var hoveredIndex: Int? = nil
    @Environment(\.theme) private var theme
    
    private let steps = 10
    
    // Enhanced theme-based colors - utilizing rich palette
    private var primaryColor: Color { theme.look.textPrimary }
    private var backgroundColor: Color { theme.look.surfacePrimary }
    private var accentColor: Color { theme.look.surfaceSecondary }
    
    // Additional rich color palette utilization
    private var brandPrimary: Color { theme.look.brandPrimary }
    private var brandSecondary: Color { theme.look.brandSecondary }
    private var accent: Color { theme.look.accent }
    private var accentSecondary: Color { theme.look.accentSecondary }
    private var glowPrimary: Color { theme.look.glowPrimary }
    private var interactiveActive: Color { theme.look.interactiveActive }
    private var neutralHighlight: Color { theme.look.neutralHighlight }
    private var shadowLight: Color { theme.look.shadowLight }
    private var shadowMedium: Color { theme.look.shadowMedium }
    
    public init(value: Binding<Double>) {
        self._value = value
    }
    
    public var body: some View {
        VStack(spacing: 30) {
            Text("INTENSITY")
                .font(.system(size: 11, weight: .medium, design: .default))
                .tracking(3)
                .foregroundColor(primaryColor.opacity(0.6))
            
            // Stepped blocks
            HStack(spacing: 8) {
                ForEach(0..<steps, id: \.self) { index in
                    Rectangle()
                        .fill(fillColor(for: index))
                        .frame(width: 20, height: blockHeight(for: index))
                        .overlay(
                            Rectangle()
                                .stroke(
                                    primaryColor,
                                    lineWidth: isActive(index) ? 1.5 : 0.5
                                )
                        )
                        .scaleEffect(hoveredIndex == index ? 1.1 : 1.0)
                        .animation(.spring(response: 0.3), value: hoveredIndex)
                        .onTapGesture {
                            value = Double(index + 1) / Double(steps)
                        }
                        .onHover { isHovered in
                            hoveredIndex = isHovered ? index : nil
                        }
                }
            }
            
            // Value line
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(accentColor)
                        .frame(height: 1)
                    
                    Rectangle()
                        .fill(primaryColor)
                        .frame(width: geometry.size.width * value, height: 2)
                }
            }
            .frame(height: 2)
        }
        .padding(40)
        .frame(width: 320, height: 200)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { gesture in
                    // Calculate which step based on x position
                    let totalWidth: CGFloat = 320 - 80 // minus padding
                    let stepWidth = totalWidth / CGFloat(steps)
                    let tappedStep = Int(gesture.location.x / stepWidth)
                    
                    if tappedStep >= 0 && tappedStep < steps {
                        value = Double(tappedStep + 1) / Double(steps)
                    }
                }
        )
    }
    
    private func blockHeight(for index: Int) -> CGFloat {
        let baseHeight: CGFloat = 40
        let maxHeight: CGFloat = 80
        let activeSteps = Int(value * Double(steps))
        
        if index < activeSteps {
            let progress = CGFloat(index) / CGFloat(steps - 1)
            return baseHeight + (maxHeight - baseHeight) * progress
        }
        return baseHeight
    }
    
    private func fillColor(for index: Int) -> Color {
        let activeSteps = Int(value * Double(steps))
        return index < activeSteps ? primaryColor : backgroundColor
    }
    
    private func isActive(_ index: Int) -> Bool {
        Int(value * Double(steps)) > index
    }
}

@available(iOS 18.0, macOS 15.0, *)
public struct SliderMinimal2_Previews: PreviewProvider {
    public static var previews: some View {
        SliderMinimal2(value: .constant(0.5))
            .theme(.audioUI)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
