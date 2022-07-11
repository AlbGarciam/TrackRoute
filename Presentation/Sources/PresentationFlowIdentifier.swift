import Components

enum PresentationFlowIdentifier: String, FlowStepIdentifier {
    case history, detail, stopDetail
}

extension FlowStep {
    convenience init(viewModel: Any, identifier: PresentationFlowIdentifier, parent: FlowStep? = nil) {
        self.init(identifier: identifier, viewModel: viewModel, parent: parent)
    }
}
