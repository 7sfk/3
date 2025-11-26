import Foundation

enum UserRole: String, CaseIterable, Codable {
    case admin = "admin"
    case foreman = "foreman"
    case supplier = "supplier" 
    case worker = "worker"
    case inspector = "inspector"
    
    var displayName: String {
        switch self {
        case .admin: return "Администратор"
        case .foreman: return "Прораб"
        case .supplier: return "Снабженец"
        case .worker: return "Рабочий"
        case .inspector: return "Приемщик"
        }
    }
}
