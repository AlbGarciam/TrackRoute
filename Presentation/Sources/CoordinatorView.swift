import PacerComponents
import SwiftUI
import WatchKit

struct CoordinatorView: View {
    @ObservedObject var coordinator: Coordinator
    @State private var selectedElement = 1

    var body: some View {
        ZStack(alignment: .bottom) {
            if coordinator.countdownViewModel == nil &&
                coordinator.errorViewModel == nil {
                TabView(selection: $selectedElement) {
                    coordinator.controlsViewModel.map { ControlsView(viewModel: $0).tag(0) }
                    if coordinator.controlsViewModel == nil {
                        coordinator.historyViewModel.map { HistoryView(viewModel: $0).tag(0) }
                    }
                    coordinator.workoutViewModel.map { WorkoutView(viewModel: $0).tag(1) }
                    if coordinator.workoutViewModel == nil {
                        coordinator.setPaceViewModel.map { SetPaceView(viewModel: $0).tag(1) }
                    }
                    NowPlayingView()
                        .tag(2)
                }
                .tabViewStyle(.page)
            }
            coordinator.countdownViewModel.map {
                CountdownView(viewModel: $0)
                    .zIndex(2)
                    .transition(.move(edge: .top))
            }
            coordinator.errorViewModel.map {
                ErrorView(viewModel: $0)
                    .zIndex(2)
                    .transition(.move(edge: .top))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
