import Combine
import DependencyInjection
import Foundation
import PacerDomain

final class HistoryViewModel: ObservableObject {
    @Injected private var coordinator: CoordinatorContract
    @Injected private var getWorkoutsUseCase: GetWorkoutsUseCaseContract
    @Injected private var getLiveWorkoutUseCase: GetLiveWorkoutUseCaseContract
    @Published var history: [WorkoutModel] = []

    private var cancellables: Set<AnyCancellable> = Set()

    func onViewAppeared() {
        fetchWorkouts()
    }

    private func fetchWorkouts() {
        getWorkoutsUseCase.run()
            .receive(on: DispatchQueue.main, options: nil)
            .sink { [weak self] workouts in
                self?.history = workouts.sorted { $0.date > $1.date }
            }
            .store(in: &cancellables)
    }

}
