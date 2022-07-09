import Combine
@testable import Data
import Domain
import OHHTTPStubs
import XCTest
@_implementationOnly import OHHTTPStubsSwift

class TripRemoteDataDourceTests: XCTestCase {
    private var sut: TripRemoteDataSource!
    private var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        sut = TripRemoteDataSource()
    }

    override func tearDown() {
        super.tearDown()
        HTTPStubs.removeAllStubs()
    }

    func testGetTripsResult() {
        stub(condition: isPath("/api/trips")) { _ in
            let stubPath = OHPathForFile("GetTrips.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
        let expectation = self.expectation(description: "success")
        sut.getTrips()
            .sink { _ in } receiveValue: {
                XCTAssertEqual(1, $0.count)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testGetTripsFailure() {
        stub(condition: isPath("/api/trips")) { _ in
            return fixture(filePath: "", status: 500, headers: nil)
        }
        let expectation = self.expectation(description: "success")
        sut.getTrips()
            .sink {
                guard case .failure = $0 else { return }
                expectation.fulfill()
            } receiveValue: { _ in }
            .store(in: &cancellables)
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testStopDetailsResult() {
        stub(condition: isPath("/api/stops/1234")) { _ in
            let stubPath = OHPathForFile("StopDetails.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
        let expectation = self.expectation(description: "success")
        sut.getStopDetails("1234")
            .sink { _ in } receiveValue: { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testStopDetailsFailure() {
        stub(condition: isPath("/api/stops/1234")) { _ in
            return fixture(filePath: "", status: 500, headers: nil)
        }
        let expectation = self.expectation(description: "success")
        sut.getStopDetails("1234")
            .sink {
                guard case .failure = $0 else { return }
                expectation.fulfill()
            } receiveValue: { _ in }
            .store(in: &cancellables)
        waitForExpectations(timeout: 1, handler: nil)
    }
}
