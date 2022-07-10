import SwiftUI

public protocol BaseCoordinatorContract: AnyObject {
    var currentStep: FlowStep { get set }
    func viewFor(_ identifier: FlowStepIdentifier) -> AnyView
    func stepRemoved(_ identifier: FlowStepIdentifier)
}

public extension BaseCoordinatorContract {
    func stepRemoved(_ identifier: FlowStepIdentifier) {
        if currentStep.identifier.isEqual(to: identifier),
           let parent = currentStep.parent {
            currentStep = parent
        }
    }
}
