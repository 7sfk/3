
import Foundation

struct Message: Identifiable, Codable {
    let id: UUID
    let fromUserID: String
    let toUserID: String
    let content: String
    let timestamp: Date
}
