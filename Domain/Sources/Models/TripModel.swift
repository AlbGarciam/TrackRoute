import Foundation

public struct TripModel: Equatable {
    public let origin, destination: AddressModel
    public let startDate, endDate: Date
    public let description, driverName: String
    public let status: Status
    public let stops: [TripModel.StopModel]
    public let route: [PointModel]

    public init(_ origin: AddressModel,
                _ destination: AddressModel,
                _ startDate: Date,
                _ endDate: Date,
                _ description: String,
                _ driverName: String,
                _ status: Status,
                _ stops: [TripModel.StopModel],
                _ route: [PointModel]) {
        self.origin = origin
        self.destination = destination
        self.startDate = startDate
        self.endDate = endDate
        self.description = description
        self.driverName = driverName
        self.status = status
        self.stops = stops
        self.route = route
    }
}

public extension TripModel {
    enum Status: String {
        case ongoing, scheduled, finalized, cancelled
    }

    struct StopModel: Equatable {
        public let identifier: String
        public let point: PointModel

        public init(_ identifier: String, _ point: PointModel) {
            (self.identifier, self.point) = (identifier, point)
        }
    }
}
