import Combine
import PacerComponents
import SwiftUI

struct SetPaceView: View {
    @State private var scroll = 0.0
    @FocusState private var focusedOnPace: Bool
    @ObservedObject var viewModel: SetPaceViewModel

    var body: some View {
        VStack {
            VStack {
                Spacer()
                PaceOverall()
                    .minutes(viewModel.setPaceModel.minutes)
                    .seconds(viewModel.setPaceModel.seconds)
                    .overall(viewModel.setPaceModel.overall)
                    .focusable(true)
                    .focused($focusedOnPace)
                    .digitalCrownRotation($scroll,
                                          from: 1.5*60,
                                          through: 20 * 60,
                                          by: 1,
                                          sensitivity: .low,
                                          isContinuous: true,
                                          isHapticFeedbackEnabled: true)
                    .onChange(of: scroll) { scroll in
                        viewModel.onPaceChanged(Int(scroll))
                    }
                Spacer()
            }
            PrimaryButton()
                .title("set_pace_button_title")
                .action { self.viewModel.setPace() }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 8)
        .padding(.vertical, 14)
        .ignoresSafeArea()
        .onAppear {
            self.focusedOnPace = true
            self.scroll = CGFloat(self.viewModel.initialSeconds)
        }
        .onDisappear {
            self.focusedOnPace = false
        }
    }
}

#if DEBUG
struct SetPaceView_Previews: PreviewProvider {
    static let viewModel = SetPaceViewModel()

    static var previews: some View {
        SetPaceView(viewModel: viewModel)
    }
}
#endif
