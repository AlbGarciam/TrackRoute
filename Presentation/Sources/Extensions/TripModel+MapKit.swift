import Domain
import MapKit

extension TripModel {
    var mkRegion: MKCoordinateRegion {
        let center = origin.point.middle(between: destination.point)
        let span = 1.5 * origin.point.distance(between: destination.point)
        let mkSpan = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let mkCenter = CLLocationCoordinate2D(latitude: center.latitude, longitude: center.longitude)
        return MKCoordinateRegion(center: mkCenter, span: mkSpan)
    }
}
