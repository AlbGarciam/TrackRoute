import Foundation

enum TrackRouteDateFormat: String {
    case slashes = "dd/MM/yyyy"
    case trip = "dd MMM • HH:MM"
    case graph = "dd/MM"
}

final class TrackRouteDateFormatter {
    static let dateFormatter = DateFormatter()

    static func format(_ date: Date, _ format: TrackRouteDateFormat) -> String {
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: date)
    }
}
