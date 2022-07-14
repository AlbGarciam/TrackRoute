import Combine
import DependencyInjection
import Domain

final class FeedbackRepositoryMock: FeedbackRepositoryContract, Mock {
    var feedbackModel: FeedbackModel?

    func send(_ model: FeedbackModel) -> AnyPublisher<Void, Error> {
        self.feedbackModel = model
        return Result.Publisher(.success(())).eraseToAnyPublisher()
    }
}
