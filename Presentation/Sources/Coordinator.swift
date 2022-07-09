import DependencyInjection
import PacerComponents
import PacerDomain
import SwiftUI

protocol CoordinatorContract: Injectable {
    func showError()
    func startWorkout()
    func startCountdown()
    func finishWorkout()
}

final class Coordinator: CoordinatorContract, ObservableObject {
    @Injected static var shared: CoordinatorContract

    @Published var countdownViewModel: CountdownViewModel?
    @Published var errorViewModel: ErrorViewModel?
    @Published var controlsViewModel: ControlsViewModel?
    @Published var historyViewModel: HistoryViewModel?
    @Published var setPaceViewModel: SetPaceViewModel?
    @Published var workoutViewModel: WorkoutViewModel?

    init() {
        historyViewModel = HistoryViewModel()
        setPaceViewModel = SetPaceViewModel()
    }

    // MARK: - Internal methods
    func showError() {
        withAnimation {
            self.errorViewModel = ErrorViewModel()
        }
    }

    func startCountdown() {
        countdownViewModel = CountdownViewModel()
    }

    func startWorkout() {
        countdownViewModel = nil
        controlsViewModel = ControlsViewModel()
        workoutViewModel = WorkoutViewModel()
    }

    func finishWorkout() {
        withAnimation {
            self.errorViewModel = nil
            self.controlsViewModel = nil
            self.workoutViewModel = nil
        }
    }
}
