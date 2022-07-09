public struct PointModel: Equatable {
    public let latitude, longitude: Double

    public init(_ latitude: Double, _ longitude: Double) {
        (self.latitude, self.longitude) = (latitude, longitude)
    }
}
