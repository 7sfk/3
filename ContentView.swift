import SwiftUI

struct ContentView: View {
    @StateObject private var appState = AppState()
    @StateObject private var projectAccessService = ProjectAccessService()

    var body: some View {
        Group {
            if appState.isLoggedIn, let userRole = appState.userRole, let project = appState.currentProject {
                RoleBasedProjectView(userRole: userRole, project: project)
            } else {
                LoginView()
            }
        }
        .environmentObject(appState)
        .environmentObject(projectAccessService)
        .onAppear {
            // Для демонстрации можно загрузить тестовые данные
            // чтобы сразу видеть проекты без входа в систему.
            #if DEBUG
            projectAccessService.loadSampleData() 
            #endif
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
