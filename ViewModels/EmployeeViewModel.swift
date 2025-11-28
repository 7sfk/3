import Foundation
import Combine

class EmployeeViewModel: ObservableObject {
    @Published var employees: [Employee] = []

    func fetchEmployees() {
        // Логика для получения сотрудников
    }

    func addEmployee(_ employee: Employee) {
        employees.append(employee)
    }
}
