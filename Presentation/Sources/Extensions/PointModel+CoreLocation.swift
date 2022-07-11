import CoreLocation
import Domain

extension PointModel {
    func toCoordinates() -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
