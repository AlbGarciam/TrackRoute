import Combine
import DependencyInjection
import Foundation

public protocol GetTripsUseCaseContract: Injectable {
    func run() -> AnyPublisher<[TripModel], Error>
}

final class GetTripsUseCase: GetTripsUseCaseContract {
    @Injected private var repository: TripRepositoryContract

    func run() -> AnyPublisher<[TripModel], Error> {
        return repository.getTrips()
    }
}
