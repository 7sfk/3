import Foundation

struct ProjectTask: Identifiable {
    let id: String
    let name: String
    let description: String
    let assignedTo: String // ID of the user
    let projectId: String
    var isCompleted: Bool
    let dueDate: Date
    var remarks: [String] = [] // Замечания от инспектора
}
