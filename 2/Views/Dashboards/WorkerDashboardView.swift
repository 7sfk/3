import SwiftUI

class WorkerDashboardViewModel: ObservableObject {
    @Published var tasks: [ProjectTask] = []
    @Published var isLoading = false
    
    private let firebaseService = FirebaseService.shared
    
    func fetchTasks(for userId: String, projectId: String) {
        isLoading = true
        firebaseService.fetchTasks(for: userId, projectId: projectId) { [weak self] tasks in
            DispatchQueue.main.async {
                self?.tasks = tasks
                self?.isLoading = false
            }
        }
    }
}

struct WorkerDashboardView: View {
    @StateObject private var viewModel = WorkerDashboardViewModel()
    @EnvironmentObject var appState: AppState
    
    let project: ProjectContainer
    
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
            if let userId = appState.currentUser {
                viewModel.fetchTasks(for: userId, projectId: project.id)
            }
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
