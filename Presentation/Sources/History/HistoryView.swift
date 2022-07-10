import Components
import Combine
import DependencyInjection
import Domain
import SwiftUI

struct HistoryView: View {
    @ObservedObject private var viewModel: HistoryViewModel

    init(_ viewModel: HistoryViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            PullToRefresh("pullToRefresh") { self.viewModel.refresh() }
            VStack(spacing: 40) {
                Text("history_screen_title")
                    .font(.boldItalic(32))
                    .foregroundColor(.primaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                if case .loading = viewModel.state {
                    getLoadingState()
                }
                if case .error = viewModel.state {
                    getErrorState()
                }
                if case .displaying(let trips) = viewModel.state {
                    getDisplayingState(trips)
                }
            }
        }
        .coordinateSpace(name: "pullToRefresh")
        .padding(.top, 24)
        .padding(.horizontal, 24)
        .edgesIgnoringSafeArea(.bottom)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func getLoadingState() -> some View {
        VStack(alignment: .center, spacing: 24) {
            Text("history_screen_fetching_title")
                .font(.regular(14))
                .foregroundColor(.primaryText)
            ProgressView()
                .progressViewStyle(.circular)
        }
    }

    private func getErrorState() -> some View {
        VStack(alignment: .center, spacing: 16) {
            Text("history_screen_error_title")
                .font(.semibold(18))
                .foregroundColor(.primaryText)
            Text("history_screen_error_subtitle")
                .font(.regular(14))
                .foregroundColor(.primaryText)
        }
    }

    private func getDisplayingState(_ trips: [TripModel]) -> some View {
        LazyVStack(alignment: .center, spacing: 12) {
            ForEach(Array(zip(trips.indices, trips)), id: \.0) { index, trip in
                TripCard()
                    .setDate(trip.startDate)
                    .setTitle(trip.destination.address)
                    .setBadgeText("trip_state_\(trip.status.rawValue)")
                    .setStopsText("\(trip.stops.count) \(NSLocalizedString("trip_stops", comment: ""))")
                    .frame(maxWidth: .infinity)
                    .onTapGesture { viewModel.didTapOnTripAt(index) }
            }
        }
    }
}

#if DEBUG
final class GetTripsUseCaseMock: GetTripsUseCaseContract, Mock {
    static var result: Result<[TripModel], Error>?

    func run() -> AnyPublisher<[TripModel], Error> {
        Future { promise in
            guard let result = Self.result else { fatalError("Provide result") }
            promise(result)
        }.eraseToAnyPublisher()
    }
}

struct HistoryView_Previews: PreviewProvider {
    static let tripModel = TripModel(AddressModel(PointModel(0, 0), "Madrid"),
                                     AddressModel(PointModel(0, 0), "Zaragoza"),
                                     Date(timeIntervalSinceNow: -3000),
                                     Date(),
                                     "Madrid - Zaragoza",
                                     "Juan Carlos",
                                     .ongoing,
                                     [],
                                     [PointModel(0,0), PointModel(1,1), PointModel(0,0)])
    static var previews: some View {
        GetTripsUseCaseMock.result = .success([tripModel, tripModel, tripModel, tripModel, tripModel])
        return HistoryView(HistoryViewModel())
    }
}
#endif
