import Combine
import DependencyInjection
import Domain

final class TripRepositoryMock: TripRepositoryContract, Mock {
    var getTripResult: Result<[TripModel], Error>?
    var getStopDetailsResult: Result<StopModel, Error>?

    func getTrips() -> AnyPublisher<[TripModel], Error> {
        Future { promise in
            guard let result = self.getTripResult else { fatalError("Please provide result before using it") }
            promise(result)
        }
        .eraseToAnyPublisher()
    }

    func getStopDetails(_ identifier: String) -> AnyPublisher<StopModel, Error> {
        Future { promise in
            guard let result = self.getStopDetailsResult else { fatalError("Please provide result before using it") }
            promise(result)
        }
        .eraseToAnyPublisher()
    }
}
