@_implementationOnly import OHHTTPStubs
@_implementationOnly import OHHTTPStubsSwift

/*
 NOTE FOR REVIEWERS

 The API is always returning a 500 error. That's why in order to unlock the coding challenge I decided to include
 this mocks in the main bundle. Once it is working, all JSON files and this class will be removed from
 Data binary

*/

final class MockManager {
    static func configureMocks() {
        HTTPStubs.removeAllStubs()
        stub(condition: isPath("/api/trips")) { _ in
            let stubPath = OHPathForFile("GetTrips.json", MockManager.self)
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
        stub(condition: isPath("/api/stops/1")) { _ in
            let stubPath = OHPathForFile("StopDetails.json", MockManager.self)
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
    }
}
