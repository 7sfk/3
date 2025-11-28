import SwiftUI
import Combine

class ProjectAccessService: ObservableObject {
    @Published var availableProjects: [ProjectContainer] = []
    @Published var isLoading = false
    
    private var firebaseService = FirebaseService.shared
    
    func fetchProjects(forUser userId: String, role: UserRole) {
        isLoading = true
        firebaseService.fetchProjects(forUser: userId, role: role) { [weak self] projects in
            DispatchQueue.main.async {
                self?.availableProjects = projects
                self?.isLoading = false
            }
        }
    }
    
    func selectProject(_ project: Project) {
        // Логика выбора проекта
        print("Выбран проект: \(project.name)")
    }
}
