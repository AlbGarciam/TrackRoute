import Combine
import PacerComponents
import SwiftUI

struct WorkoutView: View {
    @FocusState private var focusedOnPace: Bool
    @ObservedObject var viewModel: WorkoutViewModel

    var body: some View {
        VStack(spacing: 8) {
            PaceText()
                .minutes("\(viewModel.pace/60)")
                .seconds(SecondFormatter.shared.format(viewModel.pace%60))
                .focusable(true)
                .focused($focusedOnPace)
                .digitalCrownRotation($viewModel.crownPaceTarget,
                                      from: 1.5*60,
                                      through: 20 * 60,
                                      by: 1,
                                      sensitivity: .low,
                                      isContinuous: true,
                                      isHapticFeedbackEnabled: true)
            WorkoutStat()
                .icon("clock.fill")
                .text(viewModel.duration.timeValue)
            WorkoutStat()
                .icon("target")
                .text(viewModel.paceTarget.timeValue)
            WorkoutStat()
                .icon("point.filled.topleft.down.curvedto.point.bottomright.up")
                .text("\(viewModel.distance) km")
            WorkoutStat()
                .icon("bolt.heart.fill")
                .text("\(viewModel.heartRate) bpm")
            WorkoutStat()
                .icon("flame.fill")
                .text("\(viewModel.calories) kcal")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(8)
        .onAppear {
            self.focusedOnPace = true
        }
        .onDisappear {
            self.focusedOnPace = false
        }
    }
}

private extension Int {
    var timeValue: String {
        return "\(self/60):\(SecondFormatter.shared.format(self % 60))"
    }
}

#if DEBUG
struct WorkoutView_Previews: PreviewProvider {
    static let viewModel = WorkoutViewModel()

    static var previews: some View {
        WorkoutView(viewModel: viewModel)
    }
}
#endif
