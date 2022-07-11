import Domain
import MapKit

extension StopModel {
    var mkRegion: MKCoordinateRegion {
        let mkSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let mkCenter = CLLocationCoordinate2D(latitude: address.point.latitude, longitude: address.point.longitude)
        return MKCoordinateRegion(center: mkCenter, span: mkSpan)
    }
}
