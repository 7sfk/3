import SwiftUI
import Combine

final class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var selectedRole: UserRole = .worker
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    private let appState: AppState
    private let projectAccessService: ProjectAccessService
    
    init(appState: AppState, projectAccessService: ProjectAccessService) {
        self.appState = appState
        self.projectAccessService = projectAccessService
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
        
        // Имитация процесса входа
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isLoading = false
            
            if self.password.count >= 3 {
                // Успешный вход
                self.appState.currentUser = self.username
                self.appState.currentUserRole = self.selectedRole
                
                // Загружаем данные для выбранной роли
                self.projectAccessService.loadSampleData(for: self.selectedRole, user: self.username)
                
                print("Успешный вход: \(self.username) как \(self.selectedRole.displayName)")
            } else {
                self.errorMessage = "Неверные учетные данные"
            }
        }
    }
}
