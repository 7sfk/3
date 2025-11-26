import Foundation

enum ProjectStatus: String, Codable {
    case planning = "Планирование"
    case active = "Активный"
    case onHold = "На паузе"
    case completed = "Завершен"
}

struct Project: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    var status: ProjectStatus
    var progress: Int
    var startDate: Date
    var endDate: Date?
    var budget: Double?
    var location: String?
    
    init(name: String, description: String, status: ProjectStatus = .planning, progress: Int = 0) {
        self.name = name
        self.description = description
        self.status = status
        self.progress = progress
        self.startDate = Date()
    }
}
