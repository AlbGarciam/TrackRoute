import Components
import Combine
import DependencyInjection
import Domain
import SwiftUI

struct StopDetailView: View {
    @ObservedObject private var viewModel: StopDetailViewModel

    init(_ viewModel: StopDetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            PullToRefresh("pullToRefresh") { self.viewModel.refresh() }
            VStack(spacing: 40) {
                HStack(alignment: .center) {
                    Text("stop_screen_title")
                        .font(.boldItalic(32))
                        .foregroundColor(.primaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.primaryText)
                        .padding(.vertical, 12)
                        .padding(.leading, 24) // Keep it aligned to the right
                        .frame(width: 44, height: 44, alignment: .center)
                        .onTapGesture { self.viewModel.didTapClose() }
                }

                if case .loading = viewModel.state {
                    getLoadingState()
                }
                if case .error = viewModel.state {
                    getErrorState()
                }
                if case .displaying(let stop) = viewModel.state {
                    getDisplayingState(stop)
                }
            }
            .padding(.horizontal, 24)
        }
        .coordinateSpace(name: "pullToRefresh")
        .padding(.top, 24)
        .edgesIgnoringSafeArea(.bottom)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func getLoadingState() -> some View {
        VStack(alignment: .center, spacing: 24) {
            Text("stop_screen_fetching_title")
                .font(.regular(14))
                .foregroundColor(.primaryText)
            ProgressView()
                .progressViewStyle(.circular)
        }
    }

    private func getErrorState() -> some View {
        VStack(alignment: .center, spacing: 16) {
            Text("stop_screen_error_title")
                .font(.semibold(18))
                .foregroundColor(.primaryText)
            Text("stop_screen_error_subtitle")
                .font(.regular(14))
                .foregroundColor(.primaryText)
        }
    }

    private func getDisplayingState(_ stop: StopModel) -> some View {
        let price = "\(stop.price) €"
        return VStack(alignment: .leading, spacing: 8) {
            MapView(stop.mkRegion, [], [stop.address.point.toCoordinates()])
                .frame(maxWidth: .infinity)
                .frame(height: 250, alignment: .center)
                .cornerRadius(24)
                .padding(.bottom, 24)
            Text("stop_screen_passenger_title").font(.boldItalic(16)) +
            Text(stop.username).font(.regular(16))
            Text("stop_screen_address_title").font(.boldItalic(16)) +
            Text(stop.address.address).font(.regular(16))
            Text("stop_screen_date_title").font(.boldItalic(16)) +
            Text(TrackRouteDateFormatter.format(stop.date, .trip)).font(.regular(16))
            Text("stop_screen_price_title").font(.boldItalic(16)) +
            Text(price).font(.regular(16))
        }
    }
}

#if DEBUG
final class StopDetailsUseCaseMock: StopDetailsUseCaseContract, Mock {
    static var result: Result<StopModel, Error>?

    func run(_ identifier: String) -> AnyPublisher<StopModel, Error> {
        Future { promise in
            guard let result = Self.result else { fatalError("Provide result") }
            promise(result)
        }.eraseToAnyPublisher()
    }
}

struct StopDetailView_Previews: PreviewProvider {
    static let stopModel = StopModel(.paid, 3.25, Date(), "1", AddressModel(PointModel(0, 0), "Madrid"), "John wayne")
    static var previews: some View {
        StopDetailsUseCaseMock.result = .success(stopModel)
        return StopDetailView(StopDetailViewModel("1"))
    }
}
#endif
