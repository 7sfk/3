import SwiftUI

struct RoleBasedProjectView: View {
    @EnvironmentObject var appState: AppState
    let project: ProjectContainer

    var body: some View {
        VStack {
            switch appState.currentUserRole {
            case .worker, .supplier:
                WorkerDashboardView(project: project)
            case .foreman:
                ForemanDashboardView(project: project)
            case .admin:
                AdminDashboardView()
            case .inspector:
                InspectorDashboardView(project: project)
            }
        }
        .navigationTitle(project.name)
    }
}
