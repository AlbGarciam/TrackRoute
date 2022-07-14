import Components
import DependencyInjection
import Domain
@testable import Presentation
import SwiftUI

final class CoordinatorMock: CoordinatorContract, Mock {
    var currentStep: FlowStep = FlowStep(identifier: PresentationFlowIdentifier.contact, viewModel: "1", parent: nil)

    func viewFor(_ identifier: FlowStepIdentifier) -> AnyView {
        AnyView(Text("123"))
    }

    var tripModel: TripModel?
    var stopIdentifier: String?
    var navigateToContactCalled = false
    var goBackCalled = false

    func navigateToDetail(_ trip: TripModel) {
        tripModel = trip
    }

    func navigateToContact() {
        navigateToContactCalled = true
    }

    func goBack() {
        goBackCalled = true
    }

    func navigateToStop(_ identifier: String) {
        stopIdentifier = identifier
    }
}
