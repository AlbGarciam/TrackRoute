import Domain
import XCTest

// This is a sample test of how I'll test my domain models
class PointModelTests: XCTestCase {
    func testEquals() {
        let pointA = PointModel(12.2, 12.2)
        let pointB = PointModel(12.2, 12.2)
        XCTAssertEqual(pointA, pointB)
    }

    func testNonEquals() {
        let pointA = PointModel(12.2, 12.2)
        let pointB = PointModel(12.21, 12.2)
        XCTAssertNotEqual(pointA, pointB)
    }
}
