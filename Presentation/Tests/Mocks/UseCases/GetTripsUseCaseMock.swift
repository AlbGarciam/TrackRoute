import Combine
import DependencyInjection
import Domain

final class GetTripsUseCaseMock: GetTripsUseCaseContract, Mock {
    var result: Result<[TripModel], Error>?

    func run() -> AnyPublisher<[TripModel], Error> {
        Future { promise in
            guard let result = self.result else { return }
            promise(result)
        }.eraseToAnyPublisher()
    }
}
