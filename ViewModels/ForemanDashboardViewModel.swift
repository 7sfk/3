import Foundation
import Combine

final class ForemanDashboardViewModel: ObservableObject {
    @Published var project: ProjectContainer
    @Published var assignedEmployees: [Employee] = []
    @Published var isLoading: Bool = false
    
    private let firebaseService = FirebaseService.shared
    
    init(project: ProjectContainer) {
        self.project = project
    }
    
    func fetchAssignedEmployees() {
        isLoading = true
        firebaseService.fetchTeam(for: project.id) { [weak self] employees in
            DispatchQueue.main.async {
                self?.assignedEmployees = employees
                self?.isLoading = false
            }
        }
    }
}
