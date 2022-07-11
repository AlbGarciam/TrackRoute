import DependencyInjection
import Domain
import Foundation

final class TripDetailViewModel: ObservableObject {
    @Injected private var coordinator: CoordinatorContract
    @Published var trip: TripModel
    @Published var highlightedLocations: [PointModel]

    init(_ trip: TripModel) {
        self.trip = trip
        self.highlightedLocations = [trip.origin.point, trip.destination.point] + trip.stops.map(\.point)
    }

    func didTapOnStopAt(_ position: Int) {
        coordinator.navigateToStop(trip.stops[position].identifier)
    }
}
