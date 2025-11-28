import SwiftUI

struct WorkerDashboardView: View {
    @StateObject private var viewModel: WorkerDashboardViewModel
    
    init(project: ProjectContainer, userId: String) {
        _viewModel = StateObject(wrappedValue: WorkerDashboardViewModel(project: project, userId: userId))
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Загрузка задач...")
            } else {
                List(viewModel.tasks) { task in
                    TaskCardView(task: task)
                }
            }
        }
        .onAppear {
            viewModel.fetchTasks()
        }
        .navigationTitle("Мои задачи")
    }
}

struct TaskCardView: View {
    let task: ProjectTask
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(task.name)
                .font(.headline)
            Text(task.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            HStack {
                Text("Срок: \(task.dueDate, style: .date)")
                Spacer()
                if task.isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text("Выполнено")
                } else {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.red)
                    Text("В работе")
                }
            }
        }
        .padding()
    }
}
