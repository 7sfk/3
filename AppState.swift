import Foundation
import Combine

class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var userRole: Role? = nil
    @Published var currentProject: ProjectContainer? = nil
    
    // Здесь может быть логика для входа, выхода и т.д.
}
