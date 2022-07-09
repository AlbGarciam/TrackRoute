public struct AddressModel: Equatable {
    public let point: PointModel
    public let address: String

    public init(_ point: PointModel, _ address: String) {
        (self.point, self.address) = (point, address)
    }
}
