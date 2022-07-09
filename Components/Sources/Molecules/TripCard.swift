//
//  TripCard.swift
//  Components
//
//  Created by Alberto García-Muñoz on 9/7/22.
//

import SwiftUI

public struct TripCard: View {
    private var title = ""
    private var badgeText = ""
    private var dateText = ""

    public var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.card)
                .zIndex(0)
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(title)
                        .lineLimit(1)
                        .font(.semibold(16))
                        .foregroundColor(.primaryText)
                    Spacer()
                    Badge().setTitle(badgeText)
                }
                Text(dateText)
                    .lineLimit(1)
                    .font(.regular(14))
                    .foregroundColor(.primaryText)
                Text(dateText)
                    .lineLimit(1)
                    .font(.regular(14))
                    .foregroundColor(.primaryText)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(16)
        }
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
        copy.dateText = TrackRouteDateFormatter.format(value, .slashes)
        return copy
    }
}

#if DEBUG
struct TripCard_Previews: PreviewProvider {
    static var previews: some View {
        TripCard()
            .setTitle("Barcelona a Martorell")
            .setBadgeText("Ongoing")
            .setDate(Date())
    }
}
#endif
