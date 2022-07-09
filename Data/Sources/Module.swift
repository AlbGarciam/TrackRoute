import DependencyInjection
import Domain

final class Module: ModuleContract {
    static func get() {
        shared(TripRepositoryContract.self, TripRepository.self)
        shared(TripRemoteDataSourceContract.self, TripRemoteDataSource.self)
    }
}
