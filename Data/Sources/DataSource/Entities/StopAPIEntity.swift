import Foundation
import Domain

struct StopAPIEntity: Codable {
    let stopTime, address, userName: String
    let tripId: Int
    let price: Decimal
    let paid: Bool
    let point: PointAPIEntity

    func toDomain() throws -> StopModel {
        let addressModel = AddressModel(point.toDomain(), address)
        guard let date = APIDateFormatter.format(stopTime, .extended) else {
            throw DataError.parsing
        }
        return StopModel(paid ? .paid : .pending,
                         price,
                         date,
                         "\(tripId)",
                         addressModel,
                         userName)
    }
}
