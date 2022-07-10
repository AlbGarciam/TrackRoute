import SwiftUI

public func NavigationView<Content: View>(color: Color, @ViewBuilder content: () -> Content) -> some View {
    NavigationView {
        ZStack {
            color
                .ignoresSafeArea()
                .zIndex(1)
            content()
                .zIndex(2)
        }
    }
}
