import SwiftUI

struct RoleBasedProjectView: View {
    let userRole: Role
    let project: ProjectContainer
    
    var body: some View {
        switch userRole {
        case .inspector:
            InspectorDashboardView()
        case .foreman:
            ForemanDashboardView(project: project)
        default:
            // Можно добавить дашборды для других ролей
            // или заглушку
            Text("Дашборд для вашей роли в разработке")
        }
    }
}
