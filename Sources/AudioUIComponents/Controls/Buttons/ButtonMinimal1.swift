import SwiftUI
import AudioUICore
import AudioUITheme

@available(iOS 18.0, macOS 15.0, *) 
public struct ButtonMinimal1: View {
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
    
    public var body: some View {
        Button(action: {
            isOn.wrappedValue.toggle()
            action()
        }) {
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
                Rectangle()
                    .fill(isOn.wrappedValue ? theme.look.brandPrimary : theme.look.surfaceElevated)
                    .overlay(
                        Rectangle()
                            .stroke(theme.look.glassBorder, lineWidth: 1)
                    )
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
struct ButtonMinimal1_Previews: PreviewProvider {
    static var previews: some View {
        @State var isOn = false
        
        VStack(spacing: 20) {
            ButtonMinimal1(
                isOn: $isOn,
                icon: "power",
                label: "POWER"
            )
            
            ButtonMinimal1(
                isOn: $isOn,
                label: "MUTE"
            )
            
            ButtonMinimal1(
                isOn: $isOn,
                icon: "play.fill"
            )
        }
        .padding()
        .theme(.audioUI)
    }
}
