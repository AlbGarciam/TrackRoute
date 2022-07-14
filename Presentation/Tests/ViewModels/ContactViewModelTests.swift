import Combine
import DependencyInjection
import Domain
@testable import Presentation
import XCTest

class ContactViewModelTests: XCTestCase {
    private var sut: ContactViewModel!

    @Injected private var useCase: SendFeedbackUseCaseContract
    private var useCaseMock: SendFeedbackUseCaseMock! { useCase as? SendFeedbackUseCaseMock }

    @Injected private var coordinator: CoordinatorContract
    private var coordinatorMock: CoordinatorMock! { coordinator as? CoordinatorMock }

    override func setUp() {
        super.setUp()
        sut = ContactViewModel()
    }

    func testGoBack() {
        coordinatorMock.goBackCalled = false
        sut.didTapClose()
        XCTAssertTrue(coordinatorMock.goBackCalled)
    }

    func testSuccess() {
        let date = Date(timeIntervalSinceNow: -30)
        let description = String(repeating: "*", count: 200)
        let expectedModel = FeedbackModel("alb", "perez", "sam@ple.com", "", date, description)
        useCaseMock.result = .success(())
        sut.name = "alb"
        sut.surname = "perez"
        sut.email = "sam@ple.com"
        sut.dateTime = date
        sut.description = description
        sut.send()
        XCTAssertEqual(expectedModel, useCaseMock.model)
    }


    func testMoreThan200() {
        let date = Date(timeIntervalSinceNow: -30)
        let description = String(repeating: "*", count: 220)
        let expectedModel = FeedbackModel("alb", "perez", "sam@ple.com", "", date, "")
        useCaseMock.result = .success(())
        sut.name = "alb"
        sut.surname = "perez"
        sut.email = "sam@ple.com"
        sut.dateTime = date
        sut.description = description
        sut.send()
        XCTAssertEqual(expectedModel, useCaseMock.model)
    }

}
