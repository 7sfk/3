import SwiftUI
import Combine

final class LoginViewModel: ObservableObject {
    @Published var username: String = "worker@example.com"
    @Published var password: String = "123"
    @Published var selectedRole: UserRole = .worker
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    private let appState: AppState
    private let firebaseService = FirebaseService.shared
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    func login() {
        errorMessage = ""
        isLoading = true
        
        firebaseService.login(email: username, password: password) { [weak self] success, role, userId in
            DispatchQueue.main.async {
                self?.isLoading = false
                if success, let role = role, let userId = userId {
                    self?.appState.currentUser = userId
                    self?.appState.currentUserRole = role
                    print("Успешный вход: \(userId) как \(role.displayName)")
                } else {
                    self?.errorMessage = "Неверные учетные данные"
                }
            }
        }
    }
}
