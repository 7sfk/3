import Foundation

// Объявление перечисления WorkActivityStatus ПЕРЕД его использованием
enum WorkActivityStatus: String, Codable, CaseIterable {
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
    var status: WorkActivityStatus
    var materials: [MaterialUsage]?
}
