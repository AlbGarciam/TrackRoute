import Combine
import DependencyInjection
import Foundation
import PacerDomain

final class CountdownViewModel: ObservableObject {
    @Injected private var coordinator: CoordinatorContract
    @Injected private var startWorkoutUseCase: StartWorkoutUseCaseContract
    @Injected private var beeper: BeeperContract

    func countdownFinished() {
        startWorkoutUseCase.run()
        coordinator.startWorkout()
    }

    func onStepChanged(_ step: Int) {
        if step != 0 {
            beeper.playBeep()
        } else {
            beeper.playLong()
        }
    }
}
