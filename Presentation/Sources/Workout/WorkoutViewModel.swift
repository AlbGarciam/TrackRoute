import Combine
import DependencyInjection
import Foundation
import PacerComponents
import PacerDomain

struct WorkoutPaceModel: Equatable {
    let pace, duration, target: TimeModel
    let distance, heartRate, calories: String

    struct TimeModel: Equatable {
        let minutes, seconds: String

        init(seconds: Int) {
            self.minutes = "\(seconds / 60)"
            self.seconds = SecondFormatter.shared.format(seconds % 60)
        }
    }
}

final class WorkoutViewModel: ObservableObject {
    // MARK: - Outputs
    @Published var pace: Int = 0 // seconds
    @Published var duration: Int = 0 // seconds
    @Published var paceTarget: Int = 0 // seconds
    @Published var distance: Double = 0 // kilometers
    @Published var heartRate: Int = 0 // BPM
    @Published var calories: Int = 0 // Calories
    @Published var footLength: Double = 0 // meters
    @Published var crownPaceTarget: Double = 0 // seconds
    @Published var workoutState: LiveWorkoutModel.State = .paused

    // MARK: - ViewModel logic
    @Injected private var coordinator: CoordinatorContract
    @Injected private var getLiveWorkoutUseCase: GetLiveWorkoutUseCaseContract
    @Injected private var getStepLengthUseCase: GetStepLengthUseCaseContract
    @Injected private var updateWorkoutPaceUseCase: UpdateWorkoutPaceUseCaseContract
    @Injected private var beeper: BeeperContract

    // MARK: - Aux variables
    private var cancellables: Set<AnyCancellable> = Set()
    private var timer: Timer?

    init() {
        getStepLengthUseCase.run()
            .receive(on: DispatchQueue.main, options: nil)
            .sink { [weak self] length in self?.footLength = length }
            .store(in: &cancellables)
        getLiveWorkoutUseCase.run()
            .filter { $0 != nil }
            .receive(on: DispatchQueue.main, options: nil)
            .sink { [weak self] workout in
                self?.pace = workout!.currentPace.asOnlySeconds
                self?.crownPaceTarget = Double(workout!.target.asOnlySeconds)
                self?.distance = Double(round(100 * (Double(workout!.distance) / 1000)) / 100)
                self?.heartRate = workout!.heartRate
                self?.calories = workout!.calories
                self?.workoutState = workout!.state
                self?.paceTarget = workout!.target.asOnlySeconds
            }
            .store(in: &cancellables)
        $footLength
            .receive(on: DispatchQueue.main, options: nil)
            .sink { [weak self] _ in self?.updateBeeper() }
            .store(in: &cancellables)
        $paceTarget
            .scan([0, 0]) { return [$0[1], $1] }
            .filter { $0.first != $0.last }
            .filter { PaceModel(seconds: $0.last ?? 0).asOnlySeconds != 0 }
            .receive(on: DispatchQueue.main, options: nil)
            .sink { [weak self] _ in self?.updateBeeper() }
            .store(in: &cancellables)
        $workoutState
            .receive(on: DispatchQueue.main, options: nil)
            .sink { [weak self] state in state == .ongoing ? self?.resumeWorkout() : self?.pauseWorkout() }
            .store(in: &cancellables)
        $crownPaceTarget
            .map{ PaceModel(seconds: Int($0)) }
            .filter { [weak self] newValue in newValue.asOnlySeconds != 0 && newValue.asOnlySeconds != self?.paceTarget}
            .sink { [weak self] pace in self?.updateWorkoutPaceUseCase.run(pace) }
            .store(in: &cancellables)
    }

    //MARK: - Timer management
    private func resumeWorkout() {
        guard timer == nil else { return }
        beeper.playIntervals()
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.duration += 1
        }
    }

    private func pauseWorkout() {
        beeper.stopIntervals()
        timer?.invalidate()
        timer = nil
    }

    private func updateBeeper() {
        guard workoutState == .ongoing else { return }
        let speed = Double(3600) / Double(paceTarget) // km/h
        let steps = (speed * 1000) / footLength // steps/h
        let interval = (2/steps) * 3600 // Just mark one step
        beeper.setInterval(interval)
    }
}
