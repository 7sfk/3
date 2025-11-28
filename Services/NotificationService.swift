import SwiftUI
import Combine

// This class is responsible for showing in-app alerts.
// It's an ObservableObject so that views can subscribe to its changes.
class NotificationService: ObservableObject {
    // The title of the alert
    @Published var alertTitle: String? = nil
    // The main message of the alert
    @Published var alertMessage: String? = nil
    // A boolean to control the visibility of the alert
    @Published var showAlert: Bool = false

    // Call this method to trigger an alert from anywhere in the app.
    func showNotification(title: String, message: String) {
        // In a real app, you might log this or handle different types of notifications.
        // For now, we'll just set the properties to trigger the alert in the UI.
        self.alertTitle = title
        self.alertMessage = message
        self.showAlert = true
    }
}
