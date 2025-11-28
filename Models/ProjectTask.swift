import Foundation

struct ProjectTask: Identifiable, Codable {
    let id: String
    let name: String
    let description: String
    let assignedTo: String // userId
    let projectId: String
    var isCompleted: Bool
    let dueDate: Date
}
