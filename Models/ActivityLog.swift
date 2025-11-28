import Foundation
import Combine  // Добавляем импорт Combine

class ActivityLogger: ObservableObject {
    @Published var recentActivities: [ActivityLog] = []
    
    func logActivity(_ activity: ActivityLog) {
        recentActivities.insert(activity, at: 0)
        // Здесь позже будет сохранение в базу
        print("📝 LOG: \(activity.userName) - \(activity.action.rawValue)")
    }
}

struct ActivityLog: Identifiable, Codable {
    let id: String
    let userId: String
    let userName: String
    let projectId: String?
    let action: LogAction
    let timestamp: Date
    let details: String
    let ipAddress: String?
    let deviceInfo: String
}

enum LogAction: String, Codable {
    case userLogin = "user_login"
    case userLogout = "user_logout"
    case projectCreated = "project_created"
    case projectUpdated = "project_updated"
    case taskAssigned = "task_assigned"
    case taskCompleted = "task_completed"
    case materialReceived = "material_received"
    case materialUsed = "material_used"
    case qualityCheck = "quality_check"
    case safetyIncident = "safety_incident"
    case financialTransaction = "financial_transaction"
    case userPermissionChanged = "user_permission_changed"
}
