import Combine
import DependencyInjection
import Domain
import Foundation

final class HistoryViewModel: ObservableObject {
    @Injected private var coordinator: CoordinatorContract
    @Injected private var getTripsUseCase: GetTripsUseCaseContract
    @Published var state: State = .loading

    var getTripsCancellable: AnyCancellable?

    init() {
        loadTrips()
    }

    func didTapOnTripAt(_ position: Int) {
        guard case .displaying(let trips) = state else { return }
        coordinator.navigateToDetail(trips[position])
    }

    func refresh() {
        if case .loading = state { return }
        loadTrips()
    }

    func didTapHelp() {
        coordinator.navigateToContact()
    }

    private func loadTrips() {
        state = .loading
        getTripsCancellable?.cancel()
        getTripsCancellable = getTripsUseCase.run()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                guard case .failure = result else { return }
                self?.state = .error
            } receiveValue: { [weak self] trips in
                self?.state = .displaying(trips)
            }
    }
}

extension HistoryViewModel {
    enum State {
        case loading
        case error
        case displaying(_ trips: [TripModel])
        // case partialLoading if we want to add pagination
    }
}
