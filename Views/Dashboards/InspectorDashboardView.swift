import SwiftUI
import Combine

// MARK: - ViewModel
class InspectorDashboardViewModel: ObservableObject {
    @Published var tasks: [ProjectTask] = []
    @Published var isLoading = false
    private let firebaseService = FirebaseService.shared
    let projectId: String

    init(projectId: String) {
        self.projectId = projectId
        fetchAllTasks()
    }

    func fetchAllTasks() {
        isLoading = true
        firebaseService.fetchAllTasks(for: projectId) { [weak self] tasks in
            DispatchQueue.main.async {
                self?.tasks = tasks
                self?.isLoading = false
            }
        }
    }
}

// MARK: - Inspector Dashboard View
struct InspectorDashboardView: View {
    @StateObject private var viewModel: InspectorDashboardViewModel

    init(project: ProjectContainer) {
        _viewModel = StateObject(wrappedValue: InspectorDashboardViewModel(projectId: project.id))
    }

    var body: some View {
        VStack {
            if viewModel.isLoading && viewModel.tasks.isEmpty {
                ProgressView("Загрузка задач...")
            } else {
                List(viewModel.tasks) { task in
                    VStack(alignment: .leading) {
                        Text(task.name)
                            .font(.headline)
                        Text(task.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .navigationTitle("Панель Инспектора")
    }
}
