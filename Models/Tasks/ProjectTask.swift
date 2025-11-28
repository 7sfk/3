import Foundation

struct ProjectTask: Identifiable, Codable {
    var id: String
    var name: String
    var description: String?
    var isCompleted: Bool
    var assignedTo: String // Should be Employee ID
    var timeline: DateInterval
}
