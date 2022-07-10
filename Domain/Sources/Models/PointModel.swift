public struct PointModel: Equatable {
    public let latitude, longitude: Double

    public init(_ latitude: Double, _ longitude: Double) {
        (self.latitude, self.longitude) = (latitude, longitude)
    }

    public func middle(between other: PointModel) -> PointModel {
        let newLatitude = (latitude + other.latitude) / 2
        let newLongitude = (longitude + other.longitude) / 2
        return PointModel(newLatitude, newLongitude)
    }
}
