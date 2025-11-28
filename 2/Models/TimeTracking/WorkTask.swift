import Foundation

// Объявление перечисления TaskStatus ПЕРЕД его использованием
enum TaskStatus: String, Codable, CaseIterable {
    case new = "Новая"
    case inProgress = "В работе"
    case completed = "Завершена"
    case pending = "Ожидание"
    case urgent = "Срочно"
}

struct WorkTask: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String?
    var status: TaskStatus
    var materials: [MaterialUsage]?
}
