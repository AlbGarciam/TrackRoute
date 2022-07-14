import DependencyInjection

final class Module: ModuleContract {
    static func get() {
        shared(GetTripsUseCaseContract.self, GetTripsUseCase.self)
        shared(StopDetailsUseCaseContract.self, StopDetailsUseCase.self)
        shared(SendFeedbackUseCaseContract.self, SendFeedbackUseCase.self)
    }
}
