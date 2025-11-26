import Foundation

enum ProjectStatus: String, Codable, CaseIterable {
    case planning = "planning"
    case inProgress = "in_progress"
    case onHold = "on_hold"
    case completed = "completed"
    case cancelled = "cancelled"
}

struct ProjectContainer: Identifiable, Codable {
    let id: String
    let name: String
    let address: String
    let createdDate: Date
    let createdBy: String
    var assignedUsers: [String]
    var foremanId: String
    var status: ProjectStatus
    var description: String
    var budget: Double
    var timeline: ProjectTimeline
    var permissions: ProjectPermissions
}

struct ProjectPermissions: Codable {
    var canView: [String]
    var canEdit: [String]
    var canManageUsers: [String]
    var canViewFinancials: [String]
}

struct ProjectTimeline: Codable {
    var startDate: Date
    var plannedEndDate: Date
    var actualEndDate: Date?
    var milestones: [ProjectMilestone]
}

struct ProjectMilestone: Identifiable, Codable {
    let id: String
    let name: String
    let plannedDate: Date
    var actualDate: Date?
    var isCompleted: Bool
    var description: String
}
