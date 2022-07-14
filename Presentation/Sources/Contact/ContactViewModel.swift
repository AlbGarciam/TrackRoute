import Combine
import DependencyInjection
import Domain
import Foundation

final class ContactViewModel: ObservableObject {
    @Injected private var coordinator: CoordinatorContract
    @Injected private var sendFeedbackUseCase: SendFeedbackUseCaseContract

    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var dateTime: Date = Date()
    @Published var description: String = "" {
        didSet {
            if description.count > 200 && oldValue.count <= 200 {
                description = oldValue
            }
        }
    }

    private var cancellables = Set<AnyCancellable>()

    func didTapClose() {
        coordinator.goBack()
    }

    func send() {
        let model = FeedbackModel(name, surname, email, phone, dateTime, description)
        sendFeedbackUseCase.run(model)
            .sink { _ in
                print("Do something")
            } receiveValue: { _ in
                print("Success")
            }
            .store(in: &cancellables)

    }
}
