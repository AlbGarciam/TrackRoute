import Combine
import DependencyInjection
import Foundation
import PacerComponents
import PacerDomain


final class ErrorViewModel: ObservableObject {
    // MARK: - ViewModel logic
    @Injected private var coordinator: CoordinatorContract

    func understood() {
        coordinator.finishWorkout()
    }
}
