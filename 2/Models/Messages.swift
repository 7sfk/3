import Foundation

struct Message: Identifiable, Codable {
    var id: String
    var content: String
    var sender: String
    var timestamp: Date
    var projectId: String?
}
