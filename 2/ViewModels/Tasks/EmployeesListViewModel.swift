import SwiftUI
import Combine

@MainActor
final class EmployeesListViewModel: ObservableObject {
    @Published var employees: [Employee] = []
    @Published var searchText: String = ""
    
    var filteredEmployees: [Employee] {
        if searchText.isEmpty {
            return employees
        } else {
            return employees.filter { employee in
                employee.name.localizedCaseInsensitiveContains(searchText) ||
                employee.role.rawValue.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    func loadSampleData() {
        employees = [
            Employee(id: "1", name: "Иван Петров", role: .worker, email: "ivan@example.com", phone: "+79991234567"),
            Employee(id: "2", name: "Мария Сидорова", role: .manager, email: "maria@example.com", phone: "+79991234568"),
            Employee(id: "3", name: "Алексей Козлов", role: .engineer, email: "alex@example.com", phone: "+79991234569")
        ]
    }
}
