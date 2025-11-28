import Foundation
import Combine

// This ViewModel is responsible for managing the data and state
// for the Foreman's dashboard view.
final class ForemanDashboardViewModel: ObservableObject {
    // The project currently being viewed
    @Published var project: ProjectContainer
    // The list of tasks for the project
    @Published var tasks: [ProjectTask] = []
    // The list of employees assigned to the project
    @Published var assignedEmployees: [Employee] = []
    // Controls the visibility of loading indicators
    @Published var isLoading: Bool = false
    
    // A reference to the backend service
    private let firebaseService = FirebaseService.shared
    
    init(project: ProjectContainer) {
        self.project = project
    }
    
    // Fetches all necessary data for the dashboard, including tasks and employees.
    func fetchAllData() {
        isLoading = true
        
        let projectId = project.id
        let dispatchGroup = DispatchGroup()
        
        // Fetch assigned employees
        dispatchGroup.enter()
        firebaseService.fetchTeam(for: projectId) { [weak self] employees in
            DispatchQueue.main.async {
                self?.assignedEmployees = employees
                dispatchGroup.leave()
            }
        }
        
        // TODO: Fetch tasks for the project
        // dispatchGroup.enter()
        // firebaseService.fetchTasks(for: projectId) { [weak self] tasks in
        //     DispatchQueue.main.async {
        //         self?.tasks = tasks
        //         dispatchGroup.leave()
        //     }
        // }
        
        // When all data is fetched, stop loading
        dispatchGroup.notify(queue: .main) {
            self.isLoading = false
        }
    }
}
