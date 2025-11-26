import Foundation
import Combine

final class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var selectedRole: UserRole = .foreman
    @Published var errorMessage: String = ""

    private var appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }

    func login() {
        // Простейшая логика для прототипа (замени на реальную аутентификацию)
        guard !username.isEmpty, !password.isEmpty else {
            errorMessage = "Заполните имя и пароль"
            return
        }

        // Тестовый пользователь: username "pro" password "1234" — роль выбранная
        if username == "pro" && password == "1234" {
            let user = UserSession(id: UUID().uuidString, name: username, role: selectedRole)
            appState.currentUser = user
        } else {
            // Для удобства: любой пользователь с паролем "1234" допускается
            if password == "1234" {
                let user = UserSession(id: UUID().uuidString, name: username, role: selectedRole)
                appState.currentUser = user
            } else {
                errorMessage = "Неверные данные"
            }
        }
    }

    func logout() {
        appState.currentUser = nil
    }
}
