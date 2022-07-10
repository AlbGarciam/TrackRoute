import SwiftUI

public struct Badge: View {
    private var title = ""

    public var body: some View {
        Text(title)
            .font(.semibold(12))
            .foregroundColor(.primaryText)
            .padding(6)
            .background(RoundedRectangle(cornerRadius: 12)
                            .fill(Color.highlight))
    }

    public func setTitle(_ value: String) -> Self {
        var copy = self
        copy.title = value
        return copy
    }
}

#if DEBUG
struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        Badge()
            .setTitle("hello world")
    }
}
#endif
