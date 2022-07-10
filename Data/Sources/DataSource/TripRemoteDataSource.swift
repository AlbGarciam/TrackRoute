import Combine
import DependencyInjection
import Domain

protocol TripRemoteDataSourceContract: Injectable {
    func getTrips() -> AnyPublisher<[TripModel], Error>
    func getStopDetails(_ identifier: String) -> AnyPublisher<StopModel, Error>
}

final class TripRemoteDataSource: TripRemoteDataSourceContract {
    init() {
        #if DEBUG
        MockManager.configureMocks()
        #endif
    }
    
    func getTrips() -> AnyPublisher<[TripModel], Error> {
        GetTripsRequest().makeRequest()
            .tryMap { trips in try trips.map { try $0.toDomain() } }
            .eraseToAnyPublisher()
    }

    func getStopDetails(_ identifier: String) -> AnyPublisher<StopModel, Error> {
        GetStopDetailsRequest(identifier).makeRequest()
            .tryMap { stop in try stop.toDomain() }
            .eraseToAnyPublisher()
    }
}
