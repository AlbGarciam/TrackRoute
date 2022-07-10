import DependencyInjection
import Domain
@testable import Presentation

final class CoordinatorMock: CoordinatorContract, Mock {
    var tripModel: TripModel?

    func navigateToDetail(_ trip: TripModel) {
        tripModel = trip
    }
}
