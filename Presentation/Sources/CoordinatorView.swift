import Components
import SwiftUI

struct CoordinatorView: BaseCoordinatorView {
    @ObservedObject var coordinator: Coordinator
    @Environment(\.colorScheme) var colorScheme

    init(_ coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            getNavigationHierarchy()
                .zIndex(1)
        }
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    func getNavigationHierarchy() -> some View {
        NavigationView(color: Color.background) {
            HistoryView(coordinator.initialStep.viewModel as! HistoryViewModel)
                .navigate(PresentationFlowIdentifier.detail, coordinator) {
                    $0.navigationBarTitleDisplayMode(.inline)
                }
                .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
    }
}
