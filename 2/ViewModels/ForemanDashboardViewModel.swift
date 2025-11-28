import Foundation
import Combine

class ForemanDashboardViewModel: ObservableObject {
    @Published var project: ProjectContainer
    @Published var assignedEmployees: [Employee] = []
    @Published var isLoading: Bool = false
    
    private let firebaseService = FirebaseService.shared
    
    init(project: ProjectContainer) {
        self.project = project
    }
    
    func fetchAssignedEmployees() {
        isLoading = true
        firebaseService.fetchEmployees(forProject: project) { [weak self] employees in
            DispatchQueue.main.async {
                self?.assignedEmployees = employees
                self?.isLoading = false
            }
        }
    }
}
