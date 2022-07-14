import Combine
import DependencyInjection
@testable import Domain
import XCTest

// This is a sample test of how I'll test my use cases models
class SendFeedbackUseCaseTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    private var sut: SendFeedbackUseCase!
    @Injected private var repository: FeedbackRepositoryContract
    private var repositoryMock: FeedbackRepositoryMock! {
        repository as? FeedbackRepositoryMock
    }

    override func setUp() {
        super.setUp()
        sut = SendFeedbackUseCase()
    }

    func testSuccess() {
        let expectedModel = generateFeedbackModel()
        let expectation = self.expectation(description: "success")
        sut.run(expectedModel)
            .sink { _ in } receiveValue: { _ in
                XCTAssertEqual(expectedModel, self.repositoryMock.feedbackModel)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testEmptyPhone() {
        let expectedModel = generateFeedbackModel(phone: "")
        let expectation = self.expectation(description: "success")
        sut.run(expectedModel)
            .sink { _ in } receiveValue: { _ in
                XCTAssertEqual(expectedModel, self.repositoryMock.feedbackModel)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testEmptyName() {
        let expectedModel = generateFeedbackModel(name: "")
        let expectation = self.expectation(description: "success")
        sut.run(expectedModel)
            .sink {
                if case .failure(let error) = $0 {
                    XCTAssertEqual(error as? FeedbackErrorModel, .missingName)
                } else {
                    XCTFail("Invalid error")
                }
                expectation.fulfill()
            } receiveValue: { _ in }
            .store(in: &cancellables)
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testEmptySurname() {
        let expectedModel = generateFeedbackModel(surname: "")
        let expectation = self.expectation(description: "success")
        sut.run(expectedModel)
            .sink {
                if case .failure(let error) = $0 {
                    XCTAssertEqual(error as? FeedbackErrorModel, .missingSurname)
                } else {
                    XCTFail("Invalid error")
                }
                expectation.fulfill()
            } receiveValue: { _ in }
            .store(in: &cancellables)
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testInvalidPhone() {
        let expectedModel = generateFeedbackModel(phone: "1")
        let expectation = self.expectation(description: "success")
        sut.run(expectedModel)
            .sink {
                if case .failure(let error) = $0 {
                    XCTAssertEqual(error as? FeedbackErrorModel, .invalidPhone)
                } else {
                    XCTFail("Invalid error")
                }
                expectation.fulfill()
            } receiveValue: { _ in }
            .store(in: &cancellables)
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testEmptyDescription() {
        let expectedModel = generateFeedbackModel(description: "")
        let expectation = self.expectation(description: "success")
        sut.run(expectedModel)
            .sink {
                if case .failure(let error) = $0 {
                    XCTAssertEqual(error as? FeedbackErrorModel, .missingDescription)
                } else {
                    XCTFail("Invalid error")
                }
                expectation.fulfill()
            } receiveValue: { _ in }
            .store(in: &cancellables)
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testInvalidDate() {
        let expectedModel = generateFeedbackModel(dateTime: Date(timeIntervalSinceNow: 10000))
        let expectation = self.expectation(description: "success")
        sut.run(expectedModel)
            .sink {
                if case .failure(let error) = $0 {
                    XCTAssertEqual(error as? FeedbackErrorModel, .invalidDate)
                } else {
                    XCTFail("Invalid error")
                }
                expectation.fulfill()
            } receiveValue: { _ in }
            .store(in: &cancellables)
        waitForExpectations(timeout: 5, handler: nil)
    }

    private func generateFeedbackModel(name: String = "Juan",
                                       surname: String = "Perez",
                                       email: String = "test@email.com",
                                       phone: String = "666666666",
                                       dateTime: Date = .init(timeIntervalSinceNow: -500),
                                       description: String = "Lorem ipsum") -> FeedbackModel {
        return FeedbackModel(name, surname, email, phone, dateTime, description)
    }
}
