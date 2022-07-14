import Combine
import DependencyInjection
import Domain

protocol FeedbackDataSourceContract: Injectable {
    var feedbacks: [FeedbackModel] { get }

    func storeFeedback(_ model: FeedbackModel)
}

final class FeedbackDataSource: FeedbackDataSourceContract {
    private(set) var feedbacks: [FeedbackModel] = []

    func storeFeedback(_ model: FeedbackModel) {
        feedbacks.append(model)
    }
}
