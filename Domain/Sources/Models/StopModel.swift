import Foundation

public struct StopModel: Equatable {
    public let paymentStatus: PaymentStatus
    public let price: Decimal
    public let date: Date
    public let identifier, username: String
    public let address: AddressModel

    public init(_ paymentStatus: PaymentStatus,
                _ price: Decimal,
                _ date: Date,
                _ identifier: String,
                _ address: AddressModel,
                _ username: String) {
        self.paymentStatus = paymentStatus
        self.price = price
        self.date = date
        self.identifier = identifier
        self.address = address
        self.username = username
    }
}

public extension StopModel {
    enum PaymentStatus {
        case paid, pending
    }
}
