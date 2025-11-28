import SwiftUI

struct DefaultProjectView: View {
    let project: ProjectContainer

    var body: some View {
        Text("Стандартное представление для проекта \(project.name)")
            .font(.title)
            .padding()
    }
}
