import SwiftUI
import Combine

final class AppState: ObservableObject {
    @Published var currentUser: String?
    @Published var currentUserRole: UserRole = .worker
    
    init() {
        // Для тестирования можно установить тестового пользователя
        // self.currentUser = "test_user"
        // self.currentUserRole = .admin
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
