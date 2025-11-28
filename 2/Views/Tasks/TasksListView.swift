import SwiftUI

struct TasksListView: View {
    var body: some View {
        VStack {
            Text("Список задач")
                .font(.title)
            Text("Здесь будет управление задачами")
                .foregroundColor(.secondary)
        }
        .navigationTitle("Задачи")
    }
}

#Preview {
    TasksListView()
}
