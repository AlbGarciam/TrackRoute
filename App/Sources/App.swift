import Combine
import Presentation
import SwiftUI
import UIKit

@main
struct Application: App {
    var body: some Scene {
        WindowGroup {
            PresentationCoordinator().start()
        }
    }
}

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
