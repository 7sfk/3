import SwiftUI

// This view acts as a router, displaying the appropriate dashboard
// based on the user's role, which is retrieved from the app's environment.
struct RoleBasedProjectView: View {
    // Access to the global app state, including the current user's role.
    @EnvironmentObject var appState: AppState
    
    // The project to be displayed.
    let project: ProjectContainer

    var body: some View {
        VStack {
            // The switch statement determines which view to show.
            switch appState.userRole {
            case .worker, .supplier:
                // Workers and suppliers need to know their own user ID
                // to see their specific tasks or materials.
                if let userId = appState.currentUserId {
                    WorkerDashboardView(project: project, userId: userId)
                } else {
                    // Show an error or a placeholder if the user ID is missing.
                    Text("Ошибка: Не удалось определить ID пользователя.")
                }
                
            case .foreman:
                // The foreman's dashboard shows an overview of the project.
                ForemanDashboardView(project: project)
                
            case .admin:
                // The admin dashboard has its own separate functionality.
                AdminDashboardView()
                
            case .inspector:
                // The inspector's dashboard shows project details for inspection.
                InspectorDashboardView(project: project)

            default:
                // A fallback for any unhandled roles.
                Text("Для вашей роли (\(appState.userRole.rawValue)) дашборд не найден.")
            }
        }
        .navigationTitle(project.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
