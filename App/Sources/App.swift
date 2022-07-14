import Combine
import IQKeyboardManagerSwift
import Presentation
import SwiftUI
import UIKit

@main
struct Application: App {
    init() {
        IQKeyboardManager.shared.enable = true
    }

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
