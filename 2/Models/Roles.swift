import Foundation

enum UserRole: String, Codable, CaseIterable {
    case admin   = "Админ"
    case foreman = "Прораб"
    case worker  = "Рабочий"
    case supplier = "Снабженец"
}

