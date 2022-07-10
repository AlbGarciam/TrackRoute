import Combine
import Presentation
import SwiftUI

@main
struct Application: App {
    var body: some Scene {
        WindowGroup {
            PresentationCoordinator().start()
        }
    }
}
