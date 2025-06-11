import SwiftUI
import AudioUICore
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *) 
public struct ButtonDotted1: View {
    public let isOn: Binding<Bool>
    public let icon: String?
    public let label: String?
    public let action: () -> Void
    
    @Environment(\.theme) private var theme
    @State private var isPressed = false
    
    public init(
        isOn: Binding<Bool>,
        icon: String? = nil,
        label: String? = nil,
        action: @escaping () -> Void = {}
    ) {
        self.isOn = isOn
        self.icon = icon
        self.label = label
        self.action = action
    }
    
    private var dotSize: CGFloat { 2 }
    private var spacing: CGFloat { 4 }
    
    public var body: some View {
        Button(action: {
            isOn.wrappedValue.toggle()
            action()
        }) {
            ZStack {
                // Dotted background pattern
                Canvas { context, size in
                    let columns = Int(size.width / spacing)
                    let rows = Int(size.height / spacing)
                    
                    for row in 0..<rows {
                        for col in 0..<columns {
                            let x = CGFloat(col) * spacing + dotSize/2
                            let y = CGFloat(row) * spacing + dotSize/2
                            
                            let opacity = isOn.wrappedValue ? 
                                Double.random(in: 0.3...0.8) : 
                                Double.random(in: 0.1...0.3)
                            
                            context.fill(
                                Path(ellipseIn: CGRect(x: x-dotSize/2, y: y-dotSize/2, width: dotSize, height: dotSize)),
                                with: .color(theme.look.brandPrimary.opacity(opacity))
                            )
                        }
                    }
                }
                .background(theme.look.surfaceElevated)
                
                // Content overlay
                HStack(spacing: 6) {
                    if let icon = icon {
                        Image(systemName: icon)
                            .font(.system(size: 14, weight: .medium))
                    }
                    
                    if let label = label {
                        Text(label)
                            .font(.system(size: 12, weight: .semibold))
                    }
                }
                .foregroundColor(isOn.wrappedValue ? theme.look.backgroundPrimary : theme.look.textPrimary)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(isOn.wrappedValue ? 
                             theme.look.brandPrimary.opacity(0.8) : 
                             theme.look.surfaceElevated.opacity(0.9))
                )
            }
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(theme.look.glassBorder, lineWidth: 1)
            )
            .scaleEffect(isPressed ? 0.95 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = pressing
            }
        }, perform: {})
    }
}

// MARK: - Preview
@available(iOS 18.0, macOS 15.0, *)
struct ButtonDotted1_Previews: PreviewProvider {
    static var previews: some View {
        @State var isOn = false
        
        VStack(spacing: 20) {
            ButtonDotted1(
                isOn: $isOn,
                icon: "power",
                label: "POWER"
            )
            .frame(width: 80, height: 40)
            
            ButtonDotted1(
                isOn: $isOn,
                label: "MUTE"
            )
            .frame(width: 60, height: 40)
            
            ButtonDotted1(
                isOn: $isOn,
                icon: "play.fill"
            )
            .frame(width: 40, height: 40)
        }
        .padding()
        .theme(.audioUI)
    }
}
