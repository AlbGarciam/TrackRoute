import DependencyInjection
import Domain
import UIKit

final class TripDetailViewModel: ObservableObject {
    @Injected private var coordinator: CoordinatorContract
    @Published var center: PointModel

    init(_ trip: TripModel) {
        self.center = trip.origin.point.middle(between: trip.destination.point)
    }
}

extension TripDetailViewModel {
    enum State {
        case loading
        case error
        case displaying(_ trips: [TripModel])
        // case partialLoading if we want to add pagination
    }
}
