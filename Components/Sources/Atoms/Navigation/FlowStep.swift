import SwiftUI

public protocol FlowStepIdentifier {
    var rawValue: String { get }
}

public extension FlowStepIdentifier {
    func isEqual(to: FlowStepIdentifier) -> Bool {
        self.identifier == to.identifier
    }
}

private extension FlowStepIdentifier {
    var identifier: String {
        "\(String(reflecting: self)).\(rawValue)"
    }
}

public final class FlowStep: Equatable {
    public let parent: FlowStep?
    public let identifier: FlowStepIdentifier
    public let viewModel: Any

    public init(identifier: FlowStepIdentifier, viewModel: Any, parent: FlowStep? = nil) {
        (self.parent, self.identifier, self.viewModel) = (parent, identifier, viewModel)
    }

    public func getViewModel(_ navigation: FlowStepIdentifier) -> Any? {
        return navigation.isEqual(to: identifier) ? self.viewModel : parent?.getViewModel(navigation)
    }

    public static func == (lhs: FlowStep, rhs: FlowStep) -> Bool {
        return lhs.identifier.isEqual(to: rhs.identifier)
    }
}
