import SwiftUI

public struct StopCard: View {
    private var title = ""
    private var badgeText = ""

    public init() { /* Just to be able to initialize it */ }

    public var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.background)
                .zIndex(0)
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.cardBorder, lineWidth: 1)
                .zIndex(1)
            HStack(alignment: .center, spacing: 12) {
                Text(title)
                    .lineLimit(1)
                    .font(.semibold(16))
                    .foregroundColor(.primaryText)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.primaryText)

            }
            .padding(16)
        }
        .frame(width: 150, height: 90)
    }

    public func setTitle(_ value: String) -> Self {
        var copy = self
        copy.title = value
        return copy
    }
}

#if DEBUG
struct StopCard_Previews: PreviewProvider {
    static var previews: some View {
        StopCard()
            .setTitle("1st stop")
    }
}
#endif
