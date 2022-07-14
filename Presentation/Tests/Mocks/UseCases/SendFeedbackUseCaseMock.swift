import Combine
import DependencyInjection
import Domain

final class SendFeedbackUseCaseMock: SendFeedbackUseCaseContract, Mock {
    var result: Result<Void, Error>?
    var model: FeedbackModel?

    func run(_ model: FeedbackModel) -> AnyPublisher<Void, Error> {
        guard let result = result else {
            fatalError("Provide result before using it")
        }
        self.model = model
        return Result.Publisher(result).eraseToAnyPublisher()
    }
}
