import Foundation

enum EmployeeRole: String, CaseIterable, Codable {
    case worker = "worker"
    case engineer = "engineer" 
    case manager = "manager"
    case architect = "architect"
    case supervisor = "supervisor"
}

struct Employee: Identifiable, Codable {
    let id: String
    var name: String
    var role: EmployeeRole
    var email: String
    var phone: String
    var hireDate: Date?
    var projects: [String] = []
    
    init(id: String, name: String, role: EmployeeRole, email: String, phone: String) {
        self.id = id
        self.name = name
        self.role = role
        self.email = email
        self.phone = phone
    }
}
