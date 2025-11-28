import Foundation

struct Employee: Identifiable, Codable {
    let id: String
    var name: String
    var role: UserRole
    var email: String
    var phone: String
    var hireDate: Date?
    var projects: [String] = []
    
    init(id: String, name: String, role: UserRole, email: String, phone: String) {
        self.id = id
        self.name = name
        self.role = role
        self.email = email
        self.phone = phone
    }
}
