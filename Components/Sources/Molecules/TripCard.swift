import SwiftUI

public struct TripCard: View {
    private var title = ""
    private var badgeText = ""
    private var dateText = ""
    private var stopsText = ""

    public init() { /* Just to be able to initialize it */ }

    public var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.background)
                .zIndex(0)
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.cardBorder, lineWidth: 1)
                .zIndex(1)
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(title)
                        .lineLimit(1)
                        .font(.semibold(16))
                        .foregroundColor(.primaryText)
                    Spacer()
                    Badge().setTitle(LocalizedStringKey(badgeText))
                }
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(dateText)
                            .lineLimit(1)
                            .font(.regular(14))
                            .foregroundColor(.primaryText)
                        Text(stopsText)
                            .lineLimit(1)
                            .font(.regular(14))
                            .foregroundColor(.primaryText)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.primaryText)
                        .padding(.horizontal, 16)
                }

            }
            .padding(16)
        }
        .frame(height: 110)
    }

    public func setTitle(_ value: String) -> Self {
        var copy = self
        copy.title = value
        return copy
    }

    public func setBadgeText(_ value: String) -> Self {
        var copy = self
        copy.badgeText = value
        return copy
    }

    public func setDate(_ value: Date) -> Self {
        var copy = self
        copy.dateText = TrackRouteDateFormatter.format(value, .trip)
        return copy
    }

    public func setStopsText(_ value: String) -> Self {
        var copy = self
        copy.stopsText = value
        return copy
    }
}

#if DEBUG
struct TripCard_Previews: PreviewProvider {
    static var previews: some View {
        TripCard()
            .setTitle("Seat HQ - Martorell")
            .setBadgeText("Ongoing")
            .setStopsText("3 Stops")
            .setDate(Date())
    }
}
#endif
