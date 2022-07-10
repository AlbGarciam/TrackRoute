import SwiftUI

public protocol BaseCoordinatorView: View {
    associatedtype Content: View
    func getNavigationHierarchy() -> Content
}

public extension BaseCoordinatorView {
    var body: some View {
        return getNavigationHierarchy()
            .edgesIgnoringSafeArea(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
