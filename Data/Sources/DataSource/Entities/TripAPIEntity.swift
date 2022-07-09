import CoreLocation
import Domain
@_implementationOnly import Polyline

struct TripAPIEntity: Codable {
    let description, driverName, route, status, endTime, startTime: String
    let origin, destination: AddressAPIEntity
    let stops: [TripAPIEntity.StopAPIEntity]

    func toDomain() throws -> TripModel {
        guard let startDate = APIDateFormatter.format(startTime, .extended),
              let endDate = APIDateFormatter.format(endTime, .extended),
              let status = TripModel.Status(rawValue: status),
              let coordinates: [CLLocationCoordinate2D] = decodePolyline(route) else {
                  throw DataError.parsing
              }
        return TripModel(origin.toDomain(),
                         destination.toDomain(),
                         startDate,
                         endDate,
                         description,
                         driverName,
                         status,
                         stops.map{$0.toDomain()},
                         coordinates.map { PointModel($0.latitude, $0.longitude) })
    }
}

extension TripAPIEntity {
    struct StopAPIEntity: Codable {
        let id: Int
        let point: PointAPIEntity

        func toDomain() -> TripModel.StopModel {
            TripModel.StopModel("\(id)", point.toDomain())
        }
    }
}
