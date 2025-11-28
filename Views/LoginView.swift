import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            Text("Вход")
                .font(.largeTitle)
                .padding()
            
            Button("Войти как Инспектор") {
                login(as: .inspector)
            }
            .padding()
            
            Button("Войти как Прораб") {
                login(as: .foreman)
            }
            .padding()
        }
    }
    
    private func login(as role: Role) {
        appState.isLoggedIn = true
        appState.userRole = role
        // Для примера, мы просто создаем тестовый проект
        appState.currentProject = ProjectContainer(id: "proj-123", name: "Тестовый проект", budget: 500000, timeline: DateInterval(start: Date(), duration: 60*60*24*30))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AppState())
    }
}
