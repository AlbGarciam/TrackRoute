import DependencyInjection

final class Module: ModuleContract {
    static func get() {
        shared(GetTripsUseCaseContract.self, GetTripsUseCase.self)
    }
}
