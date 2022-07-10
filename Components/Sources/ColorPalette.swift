import SwiftUI

enum ColorPalette: UInt {
    case fluorescent = 0xc6ec15
    case primaryDark = 0x000000
    case secondaryDark = 0x439384
    case tertiaryDark = 0xf1f3de
    case primaryLight = 0xffffff
    case secondaryLight = 0xCBCCCB
}

public extension Color {
    static var highlight: Color { Color(.fluorescent) }
    static var primaryText: Color { Color(.primaryDark) }
    static var secondaryText: Color { Color(.secondaryDark) }
    static var tertiaryText: Color { Color(.tertiaryDark) }
    static var invertedPrimaryText: Color { Color(.primaryLight) }
    static var darkHighlight: Color { Color(.secondaryDark) }
    static var cardBorder: Color { Color(.secondaryLight) }
    static var background: Color { Color(.primaryLight) }

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
