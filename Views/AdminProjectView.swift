import SwiftUI

struct AdminProjectView: View {
    let project: ProjectContainer

    var body: some View {
        Text("Панель администратора для проекта \(project.name)")
            .font(.title)
            .padding()
    }
}
