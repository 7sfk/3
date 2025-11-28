import Foundation

enum TaskStatus: String, Codable, CaseIterable {
    case todo = "К выполнению"
    case inProgress = "В работе"
    case done = "Готово"
}

struct ProjectTask: Identifiable, Codable {
    let id: String
    let projectId: String
    let title: String
    let description: String
    var status: TaskStatus
    var assignedTo: String // User ID
    let createdDate: Date
    var dueDate: Date?
}
