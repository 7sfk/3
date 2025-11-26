import Foundation

struct UserSession: Identifiable, Codable {
    var id: String
    var name: String
    var role: UserRole
}
