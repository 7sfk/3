import Foundation
import Combine

final class EmployeeViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var role: EmployeeRole = .worker

    func saveEmployee() {
        // Здесь будет логика сохранения нового сотрудника
        print("Save employee:", name, role.rawValue)
    }
}
