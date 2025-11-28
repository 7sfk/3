import Foundation

enum TaskStatus: String, CaseIterable, Codable {
    case new = "Новая"
    case inProgress = "В работе"
    case onHold = "На паузе"
    case completed = "Завершена"
}
