import Networking

struct GetTripsRequest: APIRequest {
    typealias Response = [TripAPIEntity]
    let method: Methods = .GET
    let path = "/api/trips"
}
