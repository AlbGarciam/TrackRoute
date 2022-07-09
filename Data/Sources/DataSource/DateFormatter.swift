import Foundation

enum APIDateFormat: String {
    case extended = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
}

final class APIDateFormatter {
    static let dateFormatter = DateFormatter()

    static func format(_ string: String, _ format: APIDateFormat) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.date(from: string)
    }
}
