import Combine
import Database
import DependencyInjection
import FirebaseIntegration
import SessionAuthentication
import SessionsDomain
import SessionsPresentation
#if os(iOS) && !targetEnvironment(simulator)
import AMLib
import Spotify
#endif
import SwiftUI

@main
struct App: App {
    @State var displayingSettings: Bool = false
    private let configurator = AppConfigurator()
    init() {
        configurator.configure()
    }

    var body: some Scene {
        WindowGroup {
            SessionsCoordinator($displayingSettings).start { $0 }
        }
        #if os(macOS)
        .windowStyle(HiddenTitleBarWindowStyle())
        #endif
    }
}

private final class AppConfigurator {
    @Injected private var database: DatabaseContract
    @Injected private var authentication: SessionAuthenticationContract
    @Injected private var localRepository: LocalSessionRepositoryContract
    private var authenticationCancellable: AnyCancellable!

    func configure() {
        NaluFirebase.configure()
        #if os(iOS) && !targetEnvironment(simulator)
        AppleMusic.registerPlayer()
        NaluSpotify.registerPlayer()
        #endif

        authenticationCancellable = authentication.currentUserPublisher
            .filter { $0 == nil}
            .sink { [weak self] _ in self?.localRepository.finishLocalSession() }
        database.setup { _ in }
    }
}
