import Combine
import DependencyInjection
import Domain
@testable import Presentation
import XCTest

class HistoryViewModelTests: XCTestCase {
    private var sut: HistoryViewModel!

    @Injected private var useCase: GetTripsUseCaseContract
    private var useCaseMock: GetTripsUseCaseMock! { useCase as? GetTripsUseCaseMock }

    @Injected private var coordinator: CoordinatorContract
    private var coordinatorMock: CoordinatorMock! { coordinator as? CoordinatorMock }

    private let tripModel = TripModel(AddressModel(PointModel(0, 0), "Madrid"),
                                      AddressModel(PointModel(0, 0), "Zaragoza"),
                                      Date(timeIntervalSinceNow: -3000),
                                      Date(),
                                      "Madrid - Zaragoza",
                                      "Juan Carlos",
                                      .ongoing,
                                      [],
                                      [PointModel(0,0), PointModel(1,1), PointModel(0,0)])

    func testLoadingInitialization() {
        useCaseMock.result = nil
        self.sut = HistoryViewModel()
        guard case .loading = sut.state else { return XCTFail("Invalid state") }
    }

    func testErrorInitialization() {
        useCaseMock.result = .failure(DummyError.sample)
        self.sut = HistoryViewModel()
        let expectation = self.expectation(description: "success")
        DispatchQueue.main.async {
            guard case .error = self.sut.state else { return XCTFail("Invalid state") }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testSuccessInitialization() {
        useCaseMock.result = .success([tripModel])
        self.sut = HistoryViewModel()
        let expectation = self.expectation(description: "success")
        DispatchQueue.main.async {
            guard case .displaying(let trips) = self.sut.state else { return XCTFail("Invalid state") }
            XCTAssertEqual([self.tripModel], trips)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testTapOnCoordinatorWhenStateIsNotDisplaying() {
        useCaseMock.result = nil
        coordinatorMock.tripModel = nil
        sut = HistoryViewModel()
        sut.didTapOnTripAt(0)
        XCTAssertNil(coordinatorMock.tripModel)
    }

    func testTapOnCoordinatorWhenStateIsDisplaying() {
        coordinatorMock.tripModel = nil
        useCaseMock.result = .success([tripModel])
        sut = HistoryViewModel()
        let expectation = self.expectation(description: "success")
        DispatchQueue.main.async {
            self.sut.didTapOnTripAt(0)
            XCTAssertEqual(self.coordinatorMock.tripModel, self.tripModel)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
