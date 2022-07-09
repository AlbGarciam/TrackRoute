import SwiftUI

public enum FontPalette: String, CaseIterable {
    case boldItalic = "MyriadPro-BoldIt"
    case semibold = "MyriadPro-Semibold"
    case semiboldItalic = "MyriadPro-SemiboldIt"
    case regular = "MyriadPro-Regular"
}

public extension Font {
    static func boldItalic(_ size: CGFloat) -> Font {
        if !FontLoader.fontsLoaded { FontLoader.loadFonts() }
        return Font.custom(FontPalette.boldItalic.rawValue, size: size)
    }

    static func semibold(_ size: CGFloat) -> Font {
        if !FontLoader.fontsLoaded { FontLoader.loadFonts() }
        return Font.custom(FontPalette.semibold.rawValue, size: size)
    }

    static func semiboldItalic(_ size: CGFloat) -> Font {
        if !FontLoader.fontsLoaded { FontLoader.loadFonts() }
        return Font.custom(FontPalette.semiboldItalic.rawValue, size: size)
    }

    static func regular(_ size: CGFloat) -> Font {
        if !FontLoader.fontsLoaded { FontLoader.loadFonts() }
        return Font.custom(FontPalette.regular.rawValue, size: size)
    }

}

public class FontLoader {
    static var fontsLoaded = false
    static public func loadFonts() {
        FontPalette.allCases.forEach { loadFont(name: $0.rawValue) }
        fontsLoaded = true
    }

    private static func loadFont(name: String) {
        if let fontUrl = Bundle(for: FontLoader.self).url(forResource: name, withExtension: "otf"),
           let dataProvider = CGDataProvider(url: fontUrl as CFURL),
           let newFont = CGFont(dataProvider) {
            var error: Unmanaged<CFError>?
            if !CTFontManagerRegisterGraphicsFont(newFont, &error) {
                print("Error loading font named: \(name)")
            }
        }
    }
}
