import Foundation

public final class SecondFormatter {
    public static let shared: SecondFormatter = SecondFormatter()

    public func format(_ seconds: Int) -> String {
        seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
}
