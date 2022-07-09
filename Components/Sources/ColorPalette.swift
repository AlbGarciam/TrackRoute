import SwiftUI

public enum ColorPalette: UInt {
    case highlight = 0xc6ec15
    case primaryText = 0xffffff
    case secondaryText = 0x439384
    case tertiaryText = 0xf1f3de
    case invertedPrimaryText = 0x000000
    case card = 0x1f201f
}

public extension Color {
    static var highlight: Color { Color(.highlight) }
    static var primaryText: Color { Color(.primaryText) }
    static var secondaryText: Color { Color(.secondaryText) }
    static var tertiaryText: Color { Color(.tertiaryText) }
    static var invertedPrimaryText: Color { Color(.invertedPrimaryText) }
    static var card: Color { Color(.card) }

    internal init(_ palette: ColorPalette, alpha: Double = 1) {
        self.init(hex: palette.rawValue, alpha: alpha)
    }

    internal init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
