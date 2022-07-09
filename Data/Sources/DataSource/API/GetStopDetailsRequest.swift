import Networking

struct GetStopDetailsRequest: APIRequest {
    typealias Response = StopAPIEntity
    let method: Methods = .GET
    let path: String

    init(_ stopIdentifier: String) {
        self.path = "api/stops/\(stopIdentifier)"
    }
}
