import Foundation

public struct FeedbackModel: Equatable {
    public let name: String
    public let surname: String
    public let email: String
    public let phone: String
    public let dateTime: Date
    public let description: String

    public init(_ name: String, _ surname: String, _ email: String, _ phone: String, _ dateTime: Date, _ description: String) {
        self.name = name
        self.surname = surname
        self.email = email
        self.phone = phone
        self.dateTime = dateTime
        self.description = description
    }
}
