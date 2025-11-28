import Foundation
import Combine

class EmployeeViewModel: ObservableObject {
    @Published var employees: [Employee] = []

    func fetchEmployees() {
        // Logic to fetch employees from a data source
    }

    func addEmployee(_ employee: Employee) {
        employees.append(employee)
        // You might want to trigger a save to a persistent store here
    }
}
