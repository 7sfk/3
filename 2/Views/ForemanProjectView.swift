import SwiftUI

struct ForemanProjectView: View {
    let project: ProjectContainer

    var body: some View {
        Text("Рабочее место прораба для проекта \(project.name)")
            .font(.title)
            .padding()
    }
}
