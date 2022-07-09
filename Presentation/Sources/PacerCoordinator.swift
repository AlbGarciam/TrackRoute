import DependencyInjection
import SwiftUI

public final class PacerCoordinator {
    @Injected private var coordinator: CoordinatorContract

    public init() {}

    public func start() -> some View {
        guard let coordinator = coordinator as? Coordinator else {
            fatalError("Invalid coordinator")
        }
        return CoordinatorView(coordinator: coordinator)
    }
}
