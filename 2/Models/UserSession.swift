import Foundation

struct UserSession: Codable {
    var userId: String
    var username: String
    var role: UserRole
    var loginTime: Date
    var token: String?
}
