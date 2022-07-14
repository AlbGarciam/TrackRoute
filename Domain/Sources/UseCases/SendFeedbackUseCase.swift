import Combine
import DependencyInjection
import Foundation

public protocol SendFeedbackUseCaseContract: Injectable {
    func run(_ model: FeedbackModel) -> AnyPublisher<Void, Error>
}

final class SendFeedbackUseCase: SendFeedbackUseCaseContract {
    @Injected private var repository: FeedbackRepositoryContract

    func run(_ model: FeedbackModel) -> AnyPublisher<Void, Error> {
        do {
            try checkValidName(model.name)
            try checkValidSurname(model.surname)
            try checkValidEmail(model.email)
            try checkValidPhone(model.phone)
            try checkValidDate(model.dateTime)
            try checkValidDescription(model.description)
            return repository.send(model)
        } catch {
            return Result.Publisher(.failure(error)).eraseToAnyPublisher()
        }
    }

    private func checkValidName(_ value: String) throws {
        if value.isEmpty {
            throw FeedbackErrorModel.missingName
        }
    }

    private func checkValidSurname(_ value: String) throws {
        if value.isEmpty {
            throw FeedbackErrorModel.missingSurname
        }
    }

    private func checkValidEmail(_ value: String) throws {
        let pattern = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$"
        let range = NSRange(location: 0, length: value.utf16.count)
        let regex = try NSRegularExpression(pattern: pattern, options: [])
        if regex.matches(in: value, options: [], range: range).isEmpty {
            throw FeedbackErrorModel.invalidEmail
        }
    }

    private func checkValidPhone(_ value: String) throws {
        guard !value.isEmpty else { return }
        let pattern = "^[0-9]{9}$"
        let range = NSRange(location: 0, length: value.utf16.count)
        let regex = try NSRegularExpression(pattern: pattern, options: [])
        if regex.matches(in: value, options: [], range: range).isEmpty {
            throw FeedbackErrorModel.invalidPhone
        }
    }

    private func checkValidDescription(_ value: String) throws {
        if value.isEmpty {
            throw FeedbackErrorModel.missingDescription
        }
    }

    private func checkValidDate(_ value: Date) throws {
        if value > Date() {
            throw FeedbackErrorModel.invalidDate
        }
    }
}
