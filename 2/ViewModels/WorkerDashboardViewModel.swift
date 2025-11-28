import Foundation
import Combine

final class WorkerDashboardViewModel: ObservableObject {
    @Published var tasks: [ProjectTask] = []
    @Published var isLoading: Bool = false
    
    private let project: ProjectContainer
    private let userId: String
    private let firebaseService = FirebaseService.shared
    
    init(project: ProjectContainer, userId: String) {
        self.project = project
        self.userId = userId
    }
    
    func fetchTasks() {
        isLoading = true
        firebaseService.fetchTasks(for: userId, projectId: project.id) { [weak self] tasks in
            DispatchQueue.main.async {
                self?.tasks = tasks
                self?.isLoading = false
            }
        }
    }
}
