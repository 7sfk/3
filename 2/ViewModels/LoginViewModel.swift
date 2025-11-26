import SwiftUI
import Combine

final class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var selectedRole: UserRole = .worker
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    private let appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    func login() {
        errorMessage = ""
        isLoading = true
        
        guard !username.isEmpty else {
            errorMessage = "Введите имя пользователя"
            isLoading = false
            return
        }
        
        guard !password.isEmpty else {
            errorMessage = "Введите пароль"
            isLoading = false
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isLoading = false
            
            if self.password.count >= 3 {
                self.appState.currentUser = self.username
                self.appState.currentUserRole = self.selectedRole
            } else {
                self.errorMessage = "Неверные учетные данные"
            }
        }
    }
}
