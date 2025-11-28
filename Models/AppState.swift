
import SwiftUI
import Combine

final class AppState: ObservableObject {
    @Published var currentUser: String?
    @Published var currentUserRole: UserRole = .worker
    
    // The single source of truth for notification alerts
    let notificationService = NotificationService()
    
    init() {
        // For testing purposes, you can set a default user.
        // self.currentUser = "test_user"
        // self.currentUserRole = .admin
        self.currentUser = "test_user" // Active for easier debugging
        self.currentUserRole = .admin
    }
    
    func logout() {
        currentUser = nil
        currentUserRole = .worker
    }
    
    func loginAs(role: UserRole) {
        currentUser = "user_\(UUID().uuidString.prefix(8))"
        currentUserRole = role
    }
}
