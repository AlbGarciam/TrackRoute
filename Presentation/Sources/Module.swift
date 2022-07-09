import DependencyInjection
import Foundation

extension Bundle {
    var landing: Bundle { Bundle(for: Module.self) }
}

final class Module: ModuleContract {
    static func get() {
        shared(BeeperContract.self, Beeper.self)
        shared(CoordinatorContract.self, Coordinator.self)
    }
}
