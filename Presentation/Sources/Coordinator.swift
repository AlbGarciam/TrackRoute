import Components
import DependencyInjection
import Domain
import SwiftUI

protocol CoordinatorContract: BaseCoordinatorContract, Injectable {
    func navigateToDetail(_ trip: TripModel)
}

final class Coordinator: CoordinatorContract, ObservableObject {
    @Injected static var shared: CoordinatorContract

    @Published var currentStep: FlowStep
    @Published var initialStep: FlowStep

    init() {
        let initialStep = FlowStep(viewModel: HistoryViewModel(), identifier: .history)
        self.initialStep = initialStep
        self.currentStep = initialStep
    }

    func viewFor(_ identifier: FlowStepIdentifier) -> AnyView {
        switch (identifier as? PresentationFlowIdentifier, currentStep.getViewModel(identifier)) {
        case (.history, let viewModel as HistoryViewModel):
            return AnyView(HistoryView(viewModel))
        case (.detail, let viewModel as TripDetailViewModel):
            return AnyView(TripDetailView(viewModel))
        default:
            fatalError("Invalid navigation")
        }
    }

    // MARK: - Protocol methods
    func navigateToDetail(_ trip: TripModel) {
        let viewModel = TripDetailViewModel(trip)
        currentStep = FlowStep(viewModel: viewModel, identifier: .detail, parent: currentStep)
    }
}
