import DependencyInjection
import Domain

final class Module: ModuleContract {
    static func get() {
        shared(TripRepositoryContract.self, TripRepositoryMock.self)
        shared(FeedbackRepositoryContract.self, FeedbackRepositoryMock.self)
    }
}
