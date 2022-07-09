import Combine
import PacerComponents
import PacerDomain
import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: HistoryViewModel
    @State private var numberOfTimes = 4
    @State private var highlighted: Bool = true

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 6) {
                Graph()
                    .data(viewModel.history.map(\.graphData))
                    .frame(height: 90)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
                Text("history_list_title")
                    .font(.semiboldItalic(12))
                    .foregroundColor(.primaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ForEach(viewModel.history, id: \.self) { item in
                    PaceCard()
                        .minutes("\(item.pace.minutes)")
                        .seconds(SecondFormatter.shared.format(item.pace.seconds))
                        .date(item.date)
                        .time("\(item.duration / 60) min")
                }
            }
            .padding(.vertical, 36)
        }
        .onAppear { viewModel.onViewAppeared() }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
}

private extension WorkoutModel {
    var graphData: Graph.Item {
        return .init(date, Double(pace.asOnlySeconds))
    }
}

#if DEBUG
struct HistoryView_Previews: PreviewProvider {
    static let viewModel = HistoryViewModel()

    static var previews: some View {
        HistoryView(viewModel: viewModel)
    }
}
#endif
