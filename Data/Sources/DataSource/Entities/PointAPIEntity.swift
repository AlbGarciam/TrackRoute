import Domain

struct PointAPIEntity: Codable {
    let latitude, longitude: Double

    enum CodingKeys: String, CodingKey {
        case latitude = "_latitude"
        case longitude = "_longitude"
    }

    func toDomain() -> PointModel {
        PointModel(latitude, longitude)
    }
}
