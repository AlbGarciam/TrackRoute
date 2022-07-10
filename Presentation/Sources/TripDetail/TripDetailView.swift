import Components
import Combine
import DependencyInjection
import Domain
import SwiftUI

struct TripDetailView: View {
    @ObservedObject private var viewModel: TripDetailViewModel

    init(_ viewModel: TripDetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Text("sample")
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
