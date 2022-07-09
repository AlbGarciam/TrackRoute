import Combine
import DependencyInjection
@testable import Domain
import XCTest

private enum DummyError: Error {
    case sampleValue
}

// This is a sample test of how I'll test my use cases models
class StopDetailsUseCaseTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    private var sut: StopDetailsUseCase!
    @Injected private var repository: TripRepositoryContract
    private var repositoryMock: TripRepositoryMock! {
        repository as? TripRepositoryMock
    }

    override func setUp() {
        super.setUp()
        sut = StopDetailsUseCase()
    }

    func testSuccess() {
        let addressModel = AddressModel(PointModel(0, 0), "here")
        let stopModel = StopModel(.paid, 1.1, Date(), "1", addressModel, "alice")
        repositoryMock.getStopDetailsResult = .success(stopModel)
        let expectation = self.expectation(description: "success")
        sut.run("1234")
            .sink { _ in } receiveValue: {
                XCTAssertEqual(stopModel, $0)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFailure() {
        repositoryMock.getStopDetailsResult = .failure(DummyError.sampleValue)
        let expectation = self.expectation(description: "success")
        sut.run("1234")
            .sink {
                guard case .failure(DummyError.sampleValue) = $0 else { return }
                expectation.fulfill()
            } receiveValue: { _ in }
            .store(in: &cancellables)
        waitForExpectations(timeout: 1, handler: nil)
    }
}
