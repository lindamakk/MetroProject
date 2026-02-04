//
//  Untitled.swift
//  MetroProject
//
//  Created by Linda on 02/02/2026.
//
import SwiftUI
// MARK: - enum for states

enum ActionButtonState {
    case active
    case disabled
    case loading
}
// MARK: - Icon position enum
enum IconPosition {
    case leading  // icon before text
    case trailing // icon after text
}
// MARK: - button we will call to use

struct ActionButton: View {
    var label: String
    var icon: String? = nil // SF Symbol name, nil = no icon
    var iconPosition: IconPosition = .leading // where to put the icon
    var state: ActionButtonState = .active //defult active
    var labelColor: Color? = nil // nil means we will use default based on state witch is active
    var backgroundColor: Color? = nil // nil means we will use default based on state witch is active
    var width: CGFloat? = .infinity
    var height: CGFloat = 56
    

    var action: () -> Void
    
    var body: some View {
        Button {
            if state == .active {
                action()
            }
        } label: {
            content
        }
        .disabled(state != .active)
        .frame(maxWidth: width, minHeight: height)
        .background(finalBackgroundColor)
        .cornerRadius(16)
        .padding()
    }
    // MARK: - return text with it is color

//    @ViewBuilder
//    private var content: some View {
//        switch state {
//        case .active:
//            Text(label)
//                .foregroundColor(finalLabelColor)
//        case .disabled:
//            Text(label)
//                .foregroundColor(finalLabelColor)
//        case .loading:
//            HStack(spacing: 8) {
//                ProgressView()
//                    .tint(finalLabelColor)
//                Text("Loading...")
//                    .foregroundColor(finalLabelColor)
//            }
//        }
//    }
    
    // MARK: - return text with optional icon and color
    @ViewBuilder
    private var content: some View {
        switch state {
        case .active, .disabled:
            labelWithIcon
                .foregroundColor(finalLabelColor)
            //here we ignored the icone
        case .loading:
            HStack(spacing: 8) {
                ProgressView()
                    .tint(finalLabelColor)
                Text("Loading...")
                    .foregroundColor(finalLabelColor)
            }
        }
    }
    // MARK: - Build label with optional icon
    @ViewBuilder
    private var labelWithIcon: some View {
        HStack(spacing: 8) {
            // if there is icon and it is leading show Icon before text (leading)
            if let icon = icon, iconPosition == .leading {
                Image(systemName: icon)
            }
            
            Text(label)
            
            // if there is icon and it is leading show icon after text (trailing)
            if let icon = icon, iconPosition == .trailing {
                Image(systemName: icon)
            }
        }
    }
    
    
    // MARK: - return color if i provide else return color based on state

    private var finalLabelColor: Color {
        if let labelColor = labelColor {
            return labelColor
        }
        
        switch state {
        case .active, .loading:
            return .white
        case .disabled:
            return .white
        }
    }
    // MARK: - return color if i provide else return color based on state
    private var finalBackgroundColor: Color {
        if let backgroundColor = backgroundColor {
            return backgroundColor
        }
        
        switch state {
        case .active, .loading:
            return Color("GreenPrimaryColor")
        case .disabled:
            return Color("GreenPrimaryColor").opacity(0.5)
        }
    }
}


struct ExampleView: View {
    var body: some View {
        VStack {
            // 1 Default green button
            ActionButton(label: "Start Trip") {
                print("Started")
            }

            // 2 Disabled state (uses default gray)
            ActionButton(
                label: "Disabled",
                state: .disabled
            ) {
                print("Won't fire")
            }
            
            // 3 Loading state with custom color
            ActionButton(
                label: "Processing",
                state: .loading,
                backgroundColor: Color("GreenPrimaryColor")
            ) {
                print("Won't fire while loading")
            }
            
                       
            // 4 With icon on the left (leading)
            ActionButton(
                label: "Start Trip",
                icon: "play.fill"
            ) {
                print("Started with icon")
            }
            
            // 5 With icon on the right (trailing)
            ActionButton(
                label: "Next Step",
                icon: "arrow.right",
                iconPosition: .trailing
            ) {
                print("Next")
            }
                       
            // 6 Loading state (no icon shown in loading)
            ActionButton(
                label: "Processing",
                icon: "checkmark", // icon ignored during loading
                state: .loading
            ) {
                print("Won't fire while loading")
            }
            
            // 7 With icon on the left (leading) and custom width
            ActionButton(
                label: "Start Trip",
                icon: "plus",
                width: 228
            ) {
                print("Started with icon")
            }
        }
    }
}
#Preview {

ExampleView()


}
