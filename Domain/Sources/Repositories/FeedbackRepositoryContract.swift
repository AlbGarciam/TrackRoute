import DependencyInjection
import Combine

public protocol FeedbackRepositoryContract: Injectable {
    func send(_ model: FeedbackModel) -> AnyPublisher<Void, Error>
}
