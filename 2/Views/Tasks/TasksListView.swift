import SwiftUI

struct TasksListView: View {
    @StateObject private var viewModel = TasksViewModel()

    var body: some View {
        List(viewModel.tasks) { task in
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                HStack {
                    Text("Назначено: \(task.assignedTo)")
                    Spacer()
                    Text(task.completed ? "Завершено" : "В процессе")
                        .foregroundColor(task.completed ? .green : .orange)
                }
                .font(.subheadline)
                .foregroundColor(.gray)
            }
        }
        .navigationTitle("Задачи")
    }
}
