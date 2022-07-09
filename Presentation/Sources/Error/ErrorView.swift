import Combine
import PacerComponents
import SwiftUI

struct ErrorView: View {
    @ObservedObject var viewModel: ErrorViewModel

    var body: some View {
        VStack(spacing: 12) {
            Text("error_view_title")
                .font(.semiboldItalic(12))
                .foregroundColor(.primaryText)
                .frame(maxWidth: .infinity, alignment: .center)
            ScrollView {
                Text("error_view_subtitle")
                    .font(.regular(10))
                    .foregroundColor(.primaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            PrimaryButton()
                .title("error_view_button")
                .action { self.viewModel.understood() }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 8)
        .padding(.bottom, 16)
        .edgesIgnoringSafeArea(.bottom)
    }
}

#if DEBUG
struct ErrorView_Previews: PreviewProvider {
    static let viewModel = ErrorViewModel()

    static var previews: some View {
        ErrorView(viewModel: viewModel)
    }
}
#endif
