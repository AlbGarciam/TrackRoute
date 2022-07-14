import Combine
import DependencyInjection
import Domain
import UserNotifications
import UIKit

final class FeedbackRepository: FeedbackRepositoryContract {
    @Injected private var dataSource: FeedbackDataSourceContract

    func send(_ model: FeedbackModel) -> AnyPublisher<Void, Error> {
        Future { promise in
            Task {
                if await Self.checkPermission() {
                    Self.updateBadge(self.dataSource.feedbacks.count)
                }
            }
            self.dataSource.storeFeedback(model)
            promise(.success(()))
        }.eraseToAnyPublisher()
    }

    private static func checkPermission() async -> Bool {
        await withCheckedContinuation { continuation in
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.getNotificationSettings { settings in
                if settings.authorizationStatus == .notDetermined {
                    notificationCenter.requestAuthorization(options: [.badge]) { (granted, _) in
                        continuation.resume(with: .success(granted))
                    }
                } else {
                    continuation.resume(with: .success(settings.authorizationStatus == .authorized))
                }
            }
        }
    }

    private static func updateBadge(_ count: Int) {
        DispatchQueue.main.async {
            UIApplication.shared.applicationIconBadgeNumber = count
        }
    }
}
