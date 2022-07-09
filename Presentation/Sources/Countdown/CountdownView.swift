import Combine
import PacerComponents
import SwiftUI

struct CountdownView: View {
    @ObservedObject var viewModel: CountdownViewModel
    @State private var numberOfTimes = 4
    @State private var highlighted: Bool = true

    var body: some View {
        VStack {
            Spacer()
            Text("\(numberOfTimes)")
                .font(.boldItalic(65))
                .padding([.top], 8)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(highlighted ? Color.highlight : Color.invertedPrimaryText)
        .foregroundColor(Color.invertedPrimaryText)
        .onAppear { self.animate() }
    }

    private func animate() {
        guard numberOfTimes > 0 else { return }
        numberOfTimes -= 1
        let duration = 1.25
        highlighted = true
        viewModel.onStepChanged(numberOfTimes)
        if numberOfTimes != 0 {
            withAnimation(.easeInOut(duration: duration)) {
                highlighted = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.animate()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.viewModel.countdownFinished()
            }
        }
    }
}

#if DEBUG
struct CountdownView_Previews: PreviewProvider {
    static let viewModel = CountdownViewModel()

    static var previews: some View {
        CountdownView(viewModel: viewModel)
    }
}
#endif
