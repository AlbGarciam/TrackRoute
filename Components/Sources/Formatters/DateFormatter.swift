import Foundation

public enum TrackRouteDateFormat: String {
    case trip = "dd MMM • HH:MM"
}

public final class TrackRouteDateFormatter {
    private static let dateFormatter = DateFormatter()

    public static func format(_ date: Date, _ format: TrackRouteDateFormat) -> String {
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: date)
    }
}
