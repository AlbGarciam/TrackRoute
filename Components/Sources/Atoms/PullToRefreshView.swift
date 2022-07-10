import SwiftUI

public struct PullToRefresh: View {
    private var coordinateSpaceName: String
    private var onRefresh: () -> Void
    @State private var needRefresh: Bool = false

    public init(_ coordinateSpaceName: String, _ onRefresh: @escaping () -> Void) {
        self.coordinateSpaceName = coordinateSpaceName
        self.onRefresh = onRefresh
    }

    public var body: some View {
        GeometryReader { geo in
            if (geo.frame(in: .named(coordinateSpaceName)).midY > 50) {
                Spacer()
                    .onAppear {
                        needRefresh = true
                    }
            } else if (geo.frame(in: .named(coordinateSpaceName)).maxY < 10) {
                Spacer()
                    .onAppear {
                        if needRefresh {
                            needRefresh = false
                            onRefresh()
                        }
                    }
            }
            HStack {
                Spacer()
                if needRefresh {
                    ProgressView()
                } else {
                    Image(systemName: "chevron.down")
                        .foregroundColor(.primaryText)
                }
                Spacer()
            }
        }.padding(.top, -50)
    }
}
