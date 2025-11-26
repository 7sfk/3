import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var projectAccessService = ProjectAccessService()

    var body: some View {
        Group {
            if let _ = appState.currentUser {
                // Новый улучшенный интерфейс выбора проектов
                EnhancedProjectSelectionView()
                    .environmentObject(projectAccessService)
                    .onAppear {
                        // При входе загружаем данные для текущего пользователя
                        projectAccessService.loadSampleData()
                    }
            } else {
                LoginView(viewModel: LoginViewModel(appState: appState))
            }
        }
    }
}
