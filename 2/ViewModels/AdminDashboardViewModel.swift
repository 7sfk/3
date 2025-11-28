
import Foundation
import Combine

class AdminDashboardViewModel: ObservableObject {
    @Published var projects: [ProjectContainer] = []
    @Published var isLoading = false
    private let firebaseService = FirebaseService.shared
    
    func fetchAllProjects() {
        isLoading = true
        // Загружаем все проекты, т.к. админ видит всё
        firebaseService.fetchProjects(forUser: "admin1", role: .admin) { [weak self] projects in
            DispatchQueue.main.async {
                self?.projects = projects
                self?.isLoading = false
            }
        }
    }
}
