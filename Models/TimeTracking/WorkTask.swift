import Foundation

struct WorkTask: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String?
    var status: TaskStatus
    var materials: [MaterialUsage]?
}
