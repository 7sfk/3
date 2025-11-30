import Foundation

struct WorkTask: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String?
    var status: TaskStatus
    var materials: [MaterialUsage]?
}

enum TaskStatus: String, Codable {
    case pending = "pending"
    case inProgress = "inProgress"
    case finishing = "finishing"
    case completed = "completed"
}
