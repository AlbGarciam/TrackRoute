import Combine
import DependencyInjection
import Foundation
import PacerComponents
import PacerDomain

struct SetPaceModel: Hashable {
    let minutes, seconds, overall: String
}

final class SetPaceViewModel: ObservableObject {
    @Injected private var coordinator: CoordinatorContract
    @Injected private var createWorkoutUseCase: CreateWorkoutUseCaseContract
    @Injected private var getLiveWorkoutUseCase: GetLiveWorkoutUseCaseContract
    @Published var setPaceModel = SetPaceModel(minutes: "", seconds: "", overall: "")
    let initialSeconds: Int = 223
    private var createWorkoutCancellable: AnyCancellable?
    private var getLiveWorkoutCancellable: AnyCancellable?
    private var pace: PaceModel! {
        didSet {
            updatePaceModel(pace)
        }
    }

    required init() {
        self.pace = PaceModel(seconds: initialSeconds)
        self.updatePaceModel(pace)
    }

    func setPace() {
        createWorkoutCancellable = createWorkoutUseCase.run(pace)
            .receive(on: DispatchQueue.main, options: nil)
            .sink(receiveCompletion: { [weak self] completion in
                guard case .failure = completion else { return }
                self?.coordinator.showError()
            }, receiveValue: { [weak self] _ in
                self?.createWorkoutCancellable = nil
            })
        getLiveWorkoutCancellable = getLiveWorkoutUseCase.run()
            .receive(on: DispatchQueue.main, options: nil)
            .sink { [weak self] workout in
                guard workout != nil, workout?.state == .prepared else { return }
                self?.coordinator.startCountdown()
                self?.getLiveWorkoutCancellable = nil
            }
    }

    func onPaceChanged(_ seconds: Int) {
        self.pace = PaceModel(seconds: seconds)
    }

    private func updatePaceModel(_ model: PaceModel) {
        let averageTime = (model.asOnlySeconds * 10) / 60
        setPaceModel = SetPaceModel(minutes: "\(model.minutes)",
                                    seconds: SecondFormatter.shared.format(model.seconds),
                                    overall: "10km ~ \(averageTime)min")
    }
}
