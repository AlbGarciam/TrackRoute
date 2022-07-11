import Components
import Combine
import Domain
import MapKit
import SwiftUI

struct TripDetailView: View {
    @ObservedObject private var viewModel: TripDetailViewModel
    
    init(_ viewModel: TripDetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                getHeader()
                getTripDetails()
                MapView(viewModel.trip.mkRegion,
                        viewModel.trip.route.map { $0.toCoordinates() },
                        viewModel.highlightedLocations.map { $0.toCoordinates() })
                    .frame(maxWidth: .infinity)
                    .frame(height: 250, alignment: .center)
                    .cornerRadius(24)
                if !viewModel.trip.stops.isEmpty {
                    getStops()
                }
            }
        }
        .padding(.top, 24)
        .padding(.horizontal, 24)
        .edgesIgnoringSafeArea(.bottom)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func getHeader() -> some View {
        HStack {
            VStack {
                Text("detail_screen_title")
                    .font(.boldItalic(32))
                    .foregroundColor(.primaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(TrackRouteDateFormatter.format(viewModel.trip.startDate, .trip))
                    .font(.regular(16))
                    .foregroundColor(.primaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
            Badge().setTitle(viewModel.trip.status.localizedKey)
        }
    }

    private func getTripDetails() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("detail_screen_origin_title")
                .font(.boldItalic(16)) +
            Text(viewModel.trip.origin.address)
                .font(.regular(16))
            Text("detail_screen_destination_title")
                .font(.boldItalic(16)) +
            Text(viewModel.trip.destination.address)
                .font(.regular(16))
        }
        .foregroundColor(.primaryText)
    }

    private func getStops() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("detail_screen_stops_title")
                .font(.boldItalic(24))
                .foregroundColor(.primaryText)
            ScrollView(.horizontal) {
                LazyHStack(spacing: 8) {
                    ForEach(Array(0..<viewModel.trip.stops.count), id: \.self) { index in
                        StopCard()
                            .setTitle("\(NSLocalizedString("detail_screen_stop_text", comment: "")) \(index + 1) ")
                            .onTapGesture { viewModel.didTapOnStopAt(index) }
                    }
                }
            }
        }
    }
}

private extension TripModel.Status {
    var localizedKey: LocalizedStringKey {
        return LocalizedStringKey(stringLiteral: "trip_state_\(rawValue)")
    }
}

#if DEBUG
struct TripDetailView_Previews: PreviewProvider {
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
        return TripDetailView(TripDetailViewModel(tripModel))
    }
}
#endif
