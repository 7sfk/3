import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""

    var body: some View {
        VStack {
            Text("Вход")
                .font(.largeTitle)
                .padding()

            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .border(Color.gray, width: 0.5)
                .padding([.leading, .trailing])


            SecureField("Пароль", text: $password)
                .padding()
                .border(Color.gray, width: 0.5)
                .padding([.leading, .trailing])
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Button("Войти") {
                login()
            }
            .padding()
        }
        .padding()
    }

    private func login() {
        // Согласно README.md, пароль может быть любым.
        // Проверяем только email.
        let userRole: Role?
        
        switch email.lowercased() {
        case "admin@example.com":
            userRole = .admin
        case "foreman1@example.com":
            userRole = .foreman
        case "worker@example.com":
            userRole = .worker
        case "supplier1@example.com":
            userRole = .supplier
        case "inspector1@example.com":
            userRole = .inspector
        default:
            errorMessage = "Неверный email"
            return
        }
        
        if let role = userRole {
            errorMessage = ""
            appState.isLoggedIn = true
            appState.userRole = role
            // Для примера, мы просто создаем тестовый проект
            appState.currentProject = ProjectContainer(id: "proj-123", name: "Тестовый проект", budget: 500000, timeline: DateInterval(start: Date(), duration: 60*60*24*30))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AppState())
    }
}
