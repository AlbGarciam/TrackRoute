import Domain

struct AddressAPIEntity: Codable {
    let address: String
    let point: PointAPIEntity

    func toDomain() -> AddressModel {
        AddressModel(point.toDomain(), address)
    }
}
