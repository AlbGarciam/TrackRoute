import DependencyInjection
import Combine

public protocol TripRepositoryContract: Injectable {
    func getTrips() -> AnyPublisher<[TripModel], Error>
    func getStopDetails(_ identifier: String) -> AnyPublisher<StopModel, Error>
}
