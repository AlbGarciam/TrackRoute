import Combine
import DependencyInjection
import Domain
import Foundation

final class StopDetailViewModel: ObservableObject {
    @Injected private var coordinator: CoordinatorContract
    @Injected private var stopDetailsUseCase: StopDetailsUseCaseContract
    @Published var state: State = .loading

    private let identifier: String
    private var stopDetailsCancellable: AnyCancellable?

    init(_ identifier: String) {
        self.identifier = identifier
        loadStopDetails()
    }

    func didTapClose() {
        coordinator.goBack()
    }

    func refresh() {
        if case .loading = state { return }
        loadStopDetails()
    }

    private func loadStopDetails() {
        state = .loading
        stopDetailsCancellable?.cancel()
        stopDetailsCancellable = stopDetailsUseCase.run(identifier)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                guard case .failure = result else { return }
                self?.state = .error
            } receiveValue: { [weak self] stop in
                self?.state = .displaying(stop)
            }
    }
}

extension StopDetailViewModel {
    enum State {
        case loading
        case error
        case displaying(_ stop: StopModel)
        // case partialLoading if we want to add pagination
    }
}
