import Combine
import DependencyInjection
import Foundation
import PacerComponents
import PacerDomain

enum ControlsState {
    case inProgress, paused
}

final class ControlsViewModel: ObservableObject {
    @Published var state = ControlsState.inProgress

    // MARK: - ViewModel logic
    @Injected private var coordinator: CoordinatorContract
    @Injected private var getLiveWorkoutUseCase: GetLiveWorkoutUseCaseContract
    @Injected private var pauseWorkoutUseCase: PauseWorkoutUseCaseContract
    @Injected private var resumeWorkoutUseCase: ResumeWorkoutUseCaseContract
    @Injected private var finishWorkoutUseCase: FinishWorkoutUseCaseContract

    private var cancellables: Set<AnyCancellable> = Set()

    init() {
        getLiveWorkoutUseCase.run()
            .receive(on: DispatchQueue.main, options: nil)
            .sink { [weak self] workout in
                switch workout?.state {
                case .paused, .ended, .notStarted, .prepared:
                    self?.state = .paused
                case .ongoing:
                    self?.state = .inProgress
                case .none:
                    break
                @unknown default:
                    self?.state = .paused
                }
            }
            .store(in: &cancellables)
    }

    func pause() {
        pauseWorkoutUseCase.run()
    }

    func resume() {
        resumeWorkoutUseCase.run()
    }

    func finish() {
        getLiveWorkoutUseCase.run()
            .receive(on: DispatchQueue.main, options: nil)
            .sink { [weak self] workout in
                guard workout == nil else { return }
                self?.coordinator.finishWorkout()
            }
            .store(in: &cancellables)
        finishWorkoutUseCase.run()
    }
}
