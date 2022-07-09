import Combine
import PacerComponents
import SwiftUI

struct ControlsView: View {
    @ObservedObject var viewModel: ControlsViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                if viewModel.state == .paused {
                    ControlAction()
                        .title("controls_resume_title")
                        .subtitle("controls_resume_subtitle")
                        .variant(.pause)
                        .onTapGesture { viewModel.resume() }
                }

                if viewModel.state == .inProgress {
                    ControlAction()
                        .title("controls_pause_title")
                        .subtitle("controls_pause_subtitle")
                        .variant(.play)
                        .onTapGesture { viewModel.pause() }
                }

                ControlAction()
                    .title("controls_finish_title")
                    .subtitle("controls_finish_subtitle")
                    .variant(.finish)
                    .onTapGesture { viewModel.finish() }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 8)
        .edgesIgnoringSafeArea(.bottom)
    }
}

#if DEBUG
struct ControlsView_Previews: PreviewProvider {
    static let viewModel = ControlsViewModel()

    static var previews: some View {
        ControlsView(viewModel: viewModel)
    }
}
#endif
