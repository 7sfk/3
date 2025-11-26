import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        Group {
            if let _ = appState.currentUser {
                DashboardView()
            } else {
                LoginView(viewModel: LoginViewModel(appState: appState))
            }
        }
    }
}
