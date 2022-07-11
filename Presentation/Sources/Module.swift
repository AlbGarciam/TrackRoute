import DependencyInjection
import Domain
import Foundation

final class Module: ModuleContract {
    static func get() {
        shared(CoordinatorContract.self, Coordinator.self)
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            shared(GetTripsUseCaseContract.self, GetTripsUseCaseMock.self)
            shared(StopDetailsUseCaseContract.self, StopDetailsUseCaseMock.self)
        }
    }
}
