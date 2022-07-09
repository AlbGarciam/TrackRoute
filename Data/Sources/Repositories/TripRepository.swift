import Combine
import DependencyInjection
import Domain

final class TripRepository: TripRepositoryContract {
    // In case we have a local persistence, we'll inject it here
    @Injected private var remoteDataSource: TripRemoteDataSourceContract

    func getTrips() -> AnyPublisher<[TripModel], Error> {
        remoteDataSource.getTrips()
    }

    func getStopDetails(_ identifier: String) -> AnyPublisher<StopModel, Error> {
        remoteDataSource.getStopDetails(identifier)
    }
}
