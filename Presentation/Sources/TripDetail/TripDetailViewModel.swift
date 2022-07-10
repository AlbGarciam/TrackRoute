import DependencyInjection
import Domain
import MapKit

final class TripDetailViewModel: ObservableObject {
    @Injected private var coordinator: CoordinatorContract
    @Published var region: MKCoordinateRegion
    @Published var routeStops: [TripModel.StopModel]
    @Published var routePoints: [PointModel]
    @Published var routeStart: PointModel
    @Published var routeEnd: PointModel
    @Published var date: Date
    @Published var origin: String
    @Published var destination: String
    @Published var status: TripModel.Status

    init(_ trip: TripModel) {
        let center = trip.origin.point.middle(between: trip.destination.point)
        let span = 1.5 * trip.origin.point.distance(between: trip.destination.point)
        let mkSpan = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let mkCenter = CLLocationCoordinate2D(latitude: center.latitude, longitude: center.longitude)
        region = MKCoordinateRegion(center: mkCenter, span: mkSpan)
        routePoints = trip.route
        routeStart = trip.origin.point
        routeEnd = trip.destination.point
        routeStops = trip.stops
        date = trip.startDate
        origin = trip.origin.address
        destination = trip.destination.address
        status = trip.status
    }
}
