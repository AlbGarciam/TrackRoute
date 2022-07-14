import DependencyInjection
import Domain
@testable import Presentation

final class Module: ModuleContract {
    static func get() {
        shared(GetTripsUseCaseContract.self, GetTripsUseCaseMock.self)
        shared(SendFeedbackUseCaseContract.self, SendFeedbackUseCaseMock.self)
        shared(CoordinatorContract.self, CoordinatorMock.self)
    }
}
