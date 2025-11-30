import Foundation

enum Role {
    case admin
    case foreman
    case worker
    case client
}

class Permissions {
    static func canEditWork(for role: Role) -> Bool {
        switch role {
        case .admin, .foreman:
            return true
        default:
            return false
        }
    }
    
    static func canViewReports(for role: Role) -> Bool {
        switch role {
        case .admin, .foreman, .client:
            return true
        default:
            return false
        }
    }
}
