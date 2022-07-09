import Combine
import DependencyInjection
import Foundation

public protocol StopDetailsUseCaseContract: Injectable {
    func run(_ identifier: String) -> AnyPublisher<StopModel, Error>
}

final class StopDetailsUseCase: StopDetailsUseCaseContract {
    @Injected private var repository: TripRepositoryContract

    func run(_ identifier: String) -> AnyPublisher<StopModel, Error> {
        return repository.getStopDetails(identifier)
    }
}
