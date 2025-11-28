import SwiftUI

// Helper View to correctly initialize LoginViewModel
struct LoginViewHolder: View {
    @StateObject private var viewModel: LoginViewModel

    init(appState: AppState, projectAccessService: ProjectAccessService) {
        _viewModel = StateObject(wrappedValue: LoginViewModel(appState: appState, projectAccessService: projectAccessService))
    }

    var body: some View {
        LoginView(viewModel: viewModel)
    }
}

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var projectAccessService = ProjectAccessService()
    @State private var showWelcome = false
    @State private var showMainApp = false

    var body: some View {
        Group {
            if let currentUser = appState.currentUser {
                if showWelcome && !showMainApp {
                    WelcomeView(
                        user: currentUser,
                        role: appState.currentUserRole,
                        onContinue: {
                            withAnimation(.easeInOut) {
                                showMainApp = true
                                // Загружаем данные после приветствия
                                projectAccessService.loadSampleData(for: appState.currentUserRole, user: currentUser)
                            }
                        }
                    )
                } else if showMainApp {
                    if projectAccessService.availableProjects.isEmpty {
                        LoadingView(user: currentUser, role: appState.currentUserRole)
                    } else {
                        EnhancedProjectSelectionView()
                            .environmentObject(projectAccessService)
                    }
                } else {
                    Color.clear.onAppear {
                        withAnimation(.easeInOut) {
                            showWelcome = true
                        }
                    }
                }
            } else {
                // Use the new ViewHolder to ensure correct ViewModel lifecycle
                LoginViewHolder(appState: appState, projectAccessService: projectAccessService)
            }
        }
        .animation(.easeInOut, value: appState.currentUser)
        .animation(.easeInOut, value: showWelcome)
        .animation(.easeInOut, value: showMainApp)
    }
}

struct LoadingView: View {
    let user: String
    let role: UserRole
    
    var body: some View {
        VStack(spacing: 20) {
            ProgressView()
                .scaleEffect(1.5)
                .padding()
                .tint(roleColor)
            
            VStack(spacing: 8) {
                Text("ИЗМЕНЕНИЯ ПРИМЕНЕНЫ! ПРАВИЛЬНАЯ ПАПКА!")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text("для \(role.displayName)")
                    .font(.subheadline)
                    .foregroundColor(roleColor)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
    
    private var roleColor: Color {
        switch role {
        case .admin: return .red
        case .foreman: return .orange
        case .supplier: return .blue
        case .worker: return .green
        case .inspector: return .purple
        }
    }
}
