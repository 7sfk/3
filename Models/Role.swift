import Foundation

enum Role: String, Codable, CaseIterable, Identifiable {
    case admin = "Администратор"
    case inspector = "Инспектор"
    case foreman = "Прораб"
    case worker = "Рабочий"

    var id: String { self.rawValue }

    var displayName: String {
        return self.rawValue
    }
}
