
import SwiftUI
import Combine

class NotificationService: ObservableObject {
    @Published var alertMessage: String? = nil
    @Published var showAlert: Bool = false

    func showNotification(title: String, message: String) {
        // In a real app, you might log this or handle different types of notifications.
        // For now, we'll just use the message for the alert.
        self.alertMessage = message
        self.showAlert = true
    }
}
