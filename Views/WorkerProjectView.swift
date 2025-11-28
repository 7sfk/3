import SwiftUI

struct WorkerProjectView: View {
    @StateObject private var viewModel: WorkerDashboardViewModel

    init(project: ProjectContainer, userId: String) {
        _viewModel = StateObject(wrappedValue: WorkerDashboardViewModel(project: project, userId: userId))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if viewModel.isLoading {
                    ProgressView("Загрузка задач...")
                } else if viewModel.tasks.isEmpty {
                    Text("Вам пока не назначили задач в этом проекте.")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    ForEach(TaskStatus.allCases, id: \.self) { status in
                        let tasksForStatus = viewModel.tasks.filter { $0.status == status }
                        if !tasksForStatus.isEmpty {
                            TaskSection(status: status, tasks: tasksForStatus)
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchTasks()
        }
    }
}
